package com.example.trackpose_mobile

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // TODO: Configure Stripe with your publishable key
    // Add the following steps to enable Stripe:
    // 1. Add flutter_stripe package to pubspec.yaml
    // 2. Set your Stripe publishable key below
    // 3. Initialize Stripe in onCreate or configureFlutterEngine
    
    private val STRIPE_CHANNEL = "com.trackpose.stripe"
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // TODO: Initialize Stripe SDK here
        // Example:
        // val stripePublishableKey = "pk_test_YOUR_PUBLISHABLE_KEY"
        // PaymentConfiguration.init(applicationContext, stripePublishableKey)
        
        // Setup method channel for Stripe operations if needed
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, STRIPE_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initStripe" -> {
                    // TODO: Initialize Stripe with key from Dart side
                    // val publishableKey = call.argument<String>("publishableKey")
                    // PaymentConfiguration.init(applicationContext, publishableKey ?: "")
                    result.success("Stripe initialized (stub)")
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

