TrackPose design prompts & usage hints
====================================

Files in this package:
- designs/ (contains images renamed to match Dart screen names)
- designs/prompts/ (copilot-ready prompts to paste when using "Ask about this file" in VS Code)
- designs/specs/visual_specs.json (approximate colors, spacing, typography)
- README.txt (instructions for extraction & Copilot usage)

How to use (step-by-step):
1. Extract this archive into your Flutter project, for example: apps/mobile/designs/
2. In VS Code open the folder (apps/mobile) as the workspace root.
3. Open the image file you want to use (e.g., designs/intro_welcome.png)
4. In Copilot Chat choose "Ask about this file" so the image is attached.
5. Open the matching prompt file (designs/prompts/intro_welcome.dart.txt) and paste its content into Copilot Chat.
6. Copilot will generate a Dart file for the screen. Save it under lib/screens/ as suggested in the prompt.
7. Repeat for all screens. Use visual_specs.json to adjust colors and spacing to taste.
8. After code generation, run flutter pub get and flutter analyze, then flutter run.

Mapping of input images -> output names (these are already renamed in the package):
{
  "1.png": "intro_welcome.png",
  "2.png": "how_it_works_1.png",
  "3.png": "how_it_works_2.png",
  "4.png": "privacy_card.png",
  "5.png": "role_selection.png",
  "6.png": "login_screen.png"
}

Notes & tips for Copilot:
- Ask Copilot to "extract reusable widgets" if it generates repetitive UI.
- Use the visual_specs.json palette values as tokens in your theme.dart.
- Replace stubbed navigation and API calls with real providers once screens are generated.
- For gradients use a LinearGradient from primaryGradientStart -> primaryGradientEnd.
