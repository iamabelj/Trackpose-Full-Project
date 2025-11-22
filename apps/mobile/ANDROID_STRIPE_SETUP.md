# Android Stripe Integration Guide

## Overview
This guide provides instructions for integrating Stripe payment processing into the TrackPose Android app.

## Files Updated

### 1. MainActivity.kt
**Location:** `android/app/src/main/kotlin/com/example/trackpose_mobile/MainActivity.kt`

**Changes:**
- Added Stripe SDK initialization stub in `configureFlutterEngine()`
- Added MethodChannel for Flutter-to-native Stripe communication
- Added TODO comments with step-by-step integration instructions

**Current State:** Stub implementation with TODO comments

### 2. build.gradle.kts
**Location:** `android/app/build.gradle.kts`

**Changes:**
- Added commented-out Stripe Android dependency
- Version: `com.stripe:stripe-android:20.37.0`

**To Enable:**
Uncomment the dependency line in the `dependencies` block:
```kotlin
dependencies {
    implementation("com.stripe:stripe-android:20.37.0")
}
```

### 3. AndroidManifest.xml
**Location:** `android/app/src/main/AndroidManifest.xml`

**Changes:**
- Added `INTERNET` permission (required for Stripe API)
- Added `CAMERA` permission (for live monitoring feature)
- Added `READ_EXTERNAL_STORAGE` and `WRITE_EXTERNAL_STORAGE` permissions (for video upload)

## Integration Steps

### Step 1: Add flutter_stripe Package
Update `pubspec.yaml`:
```yaml
dependencies:
  flutter_stripe: ^10.0.0  # or latest version
```

Run:
```bash
flutter pub get
```

### Step 2: Get Stripe Keys
1. Sign up at https://dashboard.stripe.com
2. Get your Publishable Key (starts with `pk_test_` for test mode)
3. Never commit secret keys to your repository

### Step 3: Initialize Stripe in Dart
Create a Stripe initialization file (e.g., `lib/services/stripe_service.dart`):
```dart
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static const String publishableKey = 'pk_test_YOUR_KEY_HERE'; // TODO: Move to secure config
  
  static Future<void> init() async {
    Stripe.publishableKey = publishableKey;
    await Stripe.instance.applySettings();
  }
}
```

Call this in `main.dart` before `runApp()`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StripeService.init();
  runApp(const ProviderScope(child: TrackPoseApp()));
}
```

### Step 4: Uncomment Android Dependencies
In `android/app/build.gradle.kts`, uncomment:
```kotlin
implementation("com.stripe:stripe-android:20.37.0")
```

### Step 5: Update MainActivity (Optional for Advanced Use)
If you need custom native Stripe handling, update the TODO sections in `MainActivity.kt`:
```kotlin
import com.stripe.android.PaymentConfiguration

override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    
    val stripePublishableKey = "pk_test_YOUR_KEY_HERE"
    PaymentConfiguration.init(applicationContext, stripePublishableKey)
    
    // Rest of implementation...
}
```

### Step 6: Update Payment Screen
Replace the stub implementation in `lib/screens/payment_screen.dart`:

```dart
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> _processPayment() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _loading = true);
  try {
    final apiClient = ref.read(apiClientProvider);
    
    // Get client secret from backend
    final response = await apiClient.checkout('PAID');
    final clientSecret = response['clientSecret'] as String;
    
    // Initialize PaymentSheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'TrackPose',
        style: ThemeMode.system,
      ),
    );
    
    // Present PaymentSheet
    await Stripe.instance.presentPaymentSheet();
    
    // Verify payment on backend
    await apiClient.verifyPayment(response['sessionId']);
    
    // Update subscription state
    ref.read(subscriptionProvider.notifier).state = 'PAID';
    
    if (!mounted) return;
    context.go('/access-code-entry');
  } on StripeException catch (e) {
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${e.error.message}')),
    );
  } catch (e) {
    if (!mounted) return;
    setState(() => _loading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${e.toString()}')),
    );
  }
}
```

## Security Best Practices

### 1. Environment Variables
Store Stripe keys in environment variables, not in code:
```kotlin
// android/local.properties (add to .gitignore)
stripe.publishable.key=pk_test_YOUR_KEY_HERE
```

Read in `build.gradle.kts`:
```kotlin
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

android {
    defaultConfig {
        // ...
        buildConfigField("String", "STRIPE_KEY", "\"${localProperties.getProperty("stripe.publishable.key")}\"")
    }
}
```

### 2. Backend Integration
- Never expose your Stripe Secret Key in the mobile app
- Create payment intents on your backend server
- Use webhooks to verify payment completion
- Implement proper error handling and logging

### 3. Testing
Use Stripe test cards:
- Success: `4242 4242 4242 4242`
- Decline: `4000 0000 0000 0002`
- 3D Secure: `4000 0025 0000 3155`

## Backend Requirements

Your backend API should implement these endpoints:

### POST /payments/checkout
```json
Request:
{
  "plan": "PAID"
}

Response:
{
  "clientSecret": "pi_xxx_secret_xxx",
  "sessionId": "cs_xxx"
}
```

### POST /payments/verify
```json
Request:
{
  "sessionId": "cs_xxx"
}

Response:
{
  "status": "succeeded",
  "subscriptionId": "sub_xxx"
}
```

## Troubleshooting

### Issue: Stripe not initializing
- Ensure `flutter_stripe` is in `pubspec.yaml`
- Run `flutter pub get`
- Check that `Stripe.publishableKey` is set before any Stripe operations

### Issue: Build errors on Android
- Verify `minSdk` is at least 21 in `build.gradle.kts`
- Ensure internet permission is in `AndroidManifest.xml`
- Clean and rebuild: `flutter clean && flutter pub get && flutter run`

### Issue: Payment sheet not showing
- Verify client secret is correctly passed from backend
- Check that `initPaymentSheet()` is called before `presentPaymentSheet()`
- Ensure app context is valid (widget is mounted)

## Resources

- [Stripe Android SDK Documentation](https://stripe.com/docs/payments/accept-a-payment?platform=android)
- [Flutter Stripe Plugin](https://pub.dev/packages/flutter_stripe)
- [Stripe Test Cards](https://stripe.com/docs/testing)
- [Payment Intents API](https://stripe.com/docs/api/payment_intents)

## Current Status

✅ MainActivity.kt - Configured with TODO stubs
✅ build.gradle.kts - Stripe dependency added (commented)
✅ AndroidManifest.xml - Permissions added
⏳ pubspec.yaml - flutter_stripe needs to be added
⏳ Stripe initialization - Needs implementation
⏳ Payment screen - Needs real Stripe integration
⏳ Backend endpoints - Need to be implemented

## Next Actions

1. Add `flutter_stripe: ^10.0.0` to `pubspec.yaml`
2. Get Stripe publishable key from Stripe Dashboard
3. Implement Stripe initialization in Dart
4. Uncomment Stripe dependency in `build.gradle.kts`
5. Update payment screen with real Stripe PaymentSheet
6. Test with Stripe test cards
7. Implement backend payment endpoints
8. Configure webhooks for payment verification
