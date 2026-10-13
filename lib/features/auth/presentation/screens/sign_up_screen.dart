import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/widgets/custom_input.dart';
import 'package:unicom/core/widgets/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final String bgImage = "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=1000&auto=format&fit=crop";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;

  void _handleSignUp() {
    if (!_termsAccepted) return;
    context.go('/setup');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: CachedNetworkImage(
                imageUrl: bgImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(),
              ),
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black45,
                    Colors.black87,
                    Colors.black,
                  ],
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  // Header
                  Column(
                    children: [
                      Text(
                        'UNICOM',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join thousands of students on the network.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Glassmorphic Form Card
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A).withOpacity(0.7),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Email
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 6),
                                  child: Text(
                                    'EMAIL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                CustomInput(
                                  icon: Icon(LucideIcons.mail, size: 20, color: Colors.white.withOpacity(0.5)),
                                  placeholder: 'name@university.edu',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const SizedBox(width: 4),
                                    Icon(LucideIcons.checkCircle2, size: 12, color: Colors.white.withOpacity(0.8)),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Use official .ac.in or .edu email',
                                      style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Password
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 6),
                                  child: Text(
                                    'PASSWORD',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                CustomInput(
                                  icon: Icon(LucideIcons.lock, size: 20, color: Colors.white.withOpacity(0.5)),
                                  placeholder: '••••••••',
                                  obscureText: _obscurePassword,
                                  rightIcon: GestureDetector(
                                    onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                                    child: Icon(
                                      _obscurePassword ? LucideIcons.eye : LucideIcons.eyeOff,
                                      size: 20,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 20),

                                // Confirm Password
                                Padding(
                                  padding: const EdgeInsets.only(left: 4, bottom: 6),
                                  child: Text(
                                    'CONFIRM PASSWORD',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.7),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                CustomInput(
                                  icon: Icon(LucideIcons.lock, size: 20, color: Colors.white.withOpacity(0.5)),
                                  placeholder: '••••••••',
                                  obscureText: _obscureConfirmPassword,
                                  rightIcon: GestureDetector(
                                    onTap: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                    child: Icon(
                                      _obscureConfirmPassword ? LucideIcons.eye : LucideIcons.eyeOff,
                                      size: 20,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Terms Checkbox
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Checkbox(
                                        value: _termsAccepted,
                                        onChanged: (val) => setState(() => _termsAccepted = val ?? false),
                                        fillColor: WidgetStateProperty.resolveWith((states) {
                                          if (states.contains(WidgetState.selected)) return Colors.white;
                                          return Colors.black.withOpacity(0.3);
                                        }),
                                        checkColor: Colors.black,
                                        side: BorderSide(color: Colors.white.withOpacity(0.2)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.6), height: 1.4),
                                          children: const [
                                            TextSpan(text: 'I agree to the '),
                                            TextSpan(text: 'Terms of Service', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                            TextSpan(text: ' and '),
                                            TextSpan(text: 'Privacy Policy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                            TextSpan(text: '.'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Sign Up Button
                                CustomButton(
                                  onPressed: _termsAccepted ? _handleSignUp : null,
                                  fullWidth: true,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  child: const Text('Continue →'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/signin'),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
