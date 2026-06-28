import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flowday/theme/app_theme.dart';
import 'package:flowday/providers/supabase_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isSignUp = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final supabase = ref.read(supabaseClientProvider);

    try {
      if (_isSignUp) {
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful! Please sign in.')),
          );
          setState(() {
            _isSignUp = false;
            _isLoading = false;
          });
        }
      } else {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // GoRouter redirect will automatically send user to /dashboard
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
        _isLoading = false;
      });
    }
  }

  Future<void> _googleSignIn() async {
    try {
      await Supabase.instance.client.auth.signInWithOAuth(
        OAuthProvider.google,
        // Force it to use our deep link instead of the default localhost:3000
        redirectTo: 'io.supabase.flowday://login-callback/', 
      );
    } catch (error) {
      setState(() {
        _errorMessage = 'Google Sign-In Error: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3), width: 2),
                        ),
                        child: const Icon(
                          Icons.spa,
                          color: AppTheme.primaryGreen,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'FlowDay',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your Wellness & Learning OS',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                
                // Form Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _isSignUp ? 'Create Account' : 'Welcome Back',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          if (_errorMessage != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.accentRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.accentRed.withOpacity(0.3)),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.accentRed),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.inter(color: AppTheme.textSecondary),
                              prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.textSecondary),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.surfaceMuted),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.primaryGreen),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.accentRed),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.accentRed),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: GoogleFonts.inter(color: AppTheme.textPrimary),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.inter(color: AppTheme.textSecondary),
                              prefixIcon: const Icon(Icons.lock_outlined, color: AppTheme.textSecondary),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.surfaceMuted),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.primaryGreen),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.accentRed),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: AppTheme.accentRed),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: GoogleFonts.inter(color: AppTheme.textPrimary),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          
                          // Submit Button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                  )
                                : Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                          ),
                          const SizedBox(height: 16),
                          
                          // Switch Sign In / Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isSignUp ? 'Already have an account? ' : 'Need an account? ',
                                style: theme.textTheme.bodySmall,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSignUp = !_isSignUp;
                                    _errorMessage = null;
                                  });
                                },
                                child: Text(
                                  _isSignUp ? 'Sign In' : 'Sign Up',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppTheme.accentBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                const Center(child: Text('OR', style: TextStyle(color: AppTheme.textSecondary))),
                const SizedBox(height: 20),
                
                // Google Sign In
                OutlinedButton.icon(
                  onPressed: _isLoading ? null : _googleSignIn,
                  icon: const Icon(Icons.g_mobiledata, size: 24, color: AppTheme.textPrimary),
                  label: const Text('Continue with Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
