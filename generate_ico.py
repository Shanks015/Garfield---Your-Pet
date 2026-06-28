from PIL import Image
import os

input_path = 'assets/images/standing_idle/frame_000.png'
output_path = 'assets/images/garfield.ico'

if os.path.exists(input_path):
    img = Image.open(input_path)
    # Convert to standard icon sizes
    img.save(output_path, format='ICO', sizes=[(16, 16), (32, 32), (48, 48), (64, 64)])
    print(f"Successfully generated {output_path}")
else:
    print(f"Error: Could not find {input_path}")
