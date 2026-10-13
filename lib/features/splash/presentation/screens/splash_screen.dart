import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    const String bgImage = "https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1000&auto=format&fit=crop";

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Immersive Background Image with Zoom and Blur Animation
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.network(
                bgImage,
                fit: BoxFit.cover,
              )
                  .animate()
                  .scale(begin: const Offset(1.1, 1.1), end: const Offset(1.0, 1.0), duration: 4.seconds, curve: Curves.easeOut)
                  .blur(begin: const Offset(10, 10), end: Offset.zero, duration: 4.seconds),
            ),
          ),

          // 2. Heavy Premium Dark Vignette Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF000511).withOpacity(0.9),
                    const Color(0xFF000511).withOpacity(0.6),
                    const Color(0xFF000511),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // 3. Elegant Glassmorphic Container
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Text Animation
                      ClipRect(
                        child: Text(
                          'UNICOM',
                          style: GoogleFonts.syne(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 10.0,
                            color: Colors.white,
                          ),
                        )
                            .animate()
                            .moveY(begin: 100, end: 0, duration: 1.2.seconds, delay: 300.ms, curve: Curves.easeOutCubic)
                            .fadeIn(duration: 1.2.seconds, delay: 300.ms),
                      ),

                      const SizedBox(height: 16),

                      // Gradient Line
                      Container(
                        height: 1,
                        width: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      )
                          .animate()
                          .scaleX(begin: 0, end: 1, duration: 1.5.seconds, delay: 800.ms, curve: Curves.easeOutCirc),

                      const SizedBox(height: 24),

                      // Subtitle
                      Text(
                        'YOUR ACADEMIC CANVAS',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          letterSpacing: 3.0,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 1.seconds, delay: 1.4.seconds)
                          .blur(begin: const Offset(5, 5), end: Offset.zero, duration: 1.seconds),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .moveY(begin: 30, end: 0, duration: 1.5.seconds, curve: Curves.easeOutCubic)
                .fadeIn(duration: 1.5.seconds),
          ),

          // 4. Apple Style Loading Bar
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 192,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.white70, blurRadius: 10),
                              ],
                            ),
                          ),
                        ).animate(onPlay: (controller) => controller.repeat()).moveX(
                              begin: -1.0,
                              end: 3.0,
                              duration: 1.8.seconds,
                              delay: 2.2.seconds,
                              curve: Curves.easeInOut,
                            ),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 2.2.seconds),
            ),
          ),
        ],
      ),
    );
  }
}
