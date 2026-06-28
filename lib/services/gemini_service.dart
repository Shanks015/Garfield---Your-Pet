import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flowday/local/collections/health_log_collection.dart';
import 'package:flowday/local/collections/curriculum_day_collection.dart';
import 'package:isar/isar.dart';
import 'package:flowday/providers/isar_provider.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final isar = ref.watch(isarProvider);
  final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  return GeminiService(isar, apiKey);
});

class ExtractedObject {
  final String jsonString;
  final int endIndex;
  ExtractedObject(this.jsonString, this.endIndex);
}

class GeminiService {
  final Isar _isar;
  final String _apiKey;

  GeminiService(this._isar, this._apiKey);

  Future<String> _get7DayHealthSummary() async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final logs = await _isar.healthLogLocals
        .filter()
        .loggedAtGreaterThan(sevenDaysAgo)
        .findAll();

    final waterLogs = logs.where((l) => l.logType == 'water').length;
    final breakLogs = logs.where((l) => l.logType == 'break').length;
    final walkLogs = logs.where((l) => l.logType == 'walk').length;

    return '''
- Water intake logs: $waterLogs (approx. ${waterLogs * 250} ml)
- Screen/Eye break logs: $breakLogs
- Active walk logs: $walkLogs
''';
  }

  Stream<CurriculumDayLocal> generateCurriculumStream({
    required String goalId,
    required String goalTitle,
    required String goalDescription,
    required int targetWeeks,
  }) async* {
    final healthSummary = await _get7DayHealthSummary();

    if (_apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY is not configured in .env');
    }

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
      ),
    );

    final prompt = '''
You are an expert wellness and education AI coach. Generate a daily learning curriculum for the goal: "$goalTitle".
Goal Description: "$goalDescription"
Target Duration: $targetWeeks weeks (each week has 5 study days, total ${targetWeeks * 5} days).

User's 7-Day Wellness Summary:
$healthSummary

Adapt the curriculum workload to the user's wellness metrics:
- If water, eye breaks, or active walks are low, scale down daily "estimated_min" (range: 15-40 mins) and add active stretch/mindfulness cues to the description or practical tasks.
- If wellness is high, you can set the "estimated_min" higher (range: 45-90 mins).

Return the curriculum as a JSON Array of objects matching this exact schema:
[
  {
    "week_number": int,
    "day_number": int,
    "topic": "string",
    "description": "string",
    "practical_task": "string",
    "resources": ["url1", "url2"],
    "estimated_min": int
  }
]
No other text, markdown blocks, or surrounding wrappers outside of the JSON Array.
''';

    final content = [Content.text(prompt)];
    final responseStream = model.generateContentStream(content);

    String accumulatedText = '';
    int parsePointer = 0;
    final yieldedKeys = <String>{};

    await for (final chunk in responseStream) {
      final text = chunk.text;
      if (text == null) continue;
      accumulatedText += text;

      while (true) {
        final nextObj = _extractNextJsonObject(accumulatedText, parsePointer);
        if (nextObj == null) break;

        parsePointer = nextObj.endIndex;

        try {
          final map = jsonDecode(nextObj.jsonString) as Map<String, dynamic>;
          final week = map['week_number'] as int? ?? 1;
          final dayNum = map['day_number'] as int? ?? 1;
          final key = '$week-$dayNum';

          if (!yieldedKeys.contains(key)) {
            yieldedKeys.add(key);

            final curriculumDay = CurriculumDayLocal()
              ..remoteId = ''
              ..goalId = goalId
              ..weekNumber = week
              ..dayNumber = dayNum
              ..topic = map['topic'] as String? ?? ''
              ..description = map['description'] as String? ?? ''
              ..practicalTask = map['practical_task'] as String? ?? ''
              ..resources = jsonEncode(map['resources'] ?? [])
              ..estimatedMin = map['estimated_min'] as int? ?? 30
              ..updatedAt = DateTime.now()
              ..pendingSync = true;

            yield curriculumDay;
          }
        } catch (e) {
          debugPrint('Error parsing streaming object: $e');
        }
      }
    }
  }

  ExtractedObject? _extractNextJsonObject(String text, int startPointer) {
    int braceCount = 0;
    int objectStart = -1;
    bool inString = false;
    bool isEscaped = false;

    for (int i = startPointer; i < text.length; i++) {
      final char = text[i];

      if (inString) {
        if (isEscaped) {
          isEscaped = false;
        } else if (char == '\\') {
          isEscaped = true;
        } else if (char == '"') {
          inString = false;
        }
        continue;
      }

      if (char == '"') {
        inString = true;
        continue;
      }

      if (char == '{') {
        if (braceCount == 0) {
          objectStart = i;
        }
        braceCount++;
      } else if (char == '}') {
        if (braceCount > 0) {
          braceCount--;
          if (braceCount == 0 && objectStart != -1) {
            final jsonString = text.substring(objectStart, i + 1);
            return ExtractedObject(jsonString, i + 1);
          }
        }
      }
    }
    return null;
  }
}
