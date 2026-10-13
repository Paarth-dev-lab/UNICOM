import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingSlide {
  final String title;
  final String bgImage;
  final List<Color> gradient;

  OnboardingSlide({
    required this.title,
    required this.bgImage,
    required this.gradient,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;
  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: "Join Socials\nNetwork\nfor Amplify\nin your\nlife.",
      bgImage: "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=800&auto=format&fit=crop",
      gradient: [const Color(0xFFDB9D47).withOpacity(0.4), const Color(0xFFDB9D47).withOpacity(0.1), const Color(0xFF8B5A19)],
    ),
    OnboardingSlide(
      title: "Discover\nOpportunities\nand Connect\nwith peers\neverywhere.",
      bgImage: "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=800&auto=format&fit=crop",
      gradient: [Colors.black.withOpacity(0.4), Colors.transparent, Colors.black.withOpacity(0.9)],
    ),
    OnboardingSlide(
      title: "Safe &\nPrivate\ncampus\ncommunities\nfor you.",
      bgImage: "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=800&auto=format&fit=crop",
      gradient: [const Color(0xFF0064E0).withOpacity(0.4), Colors.transparent, const Color(0xFF003882).withOpacity(0.9)],
    ),
  ];

  void _nextSlide() {
    if (_step < slides.length - 1) {
      setState(() => _step++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Animated Background Image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: Stack(
                key: ValueKey(_step),
                children: [
                  Positioned.fill(
                    child: Image.network(
                      slides[_step].bgImage,
                      fit: BoxFit.cover,
                    ).animate().scale(begin: const Offset(1.05, 1.05), end: const Offset(1.0, 1.0), duration: 600.ms),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: slides[_step].gradient,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Bars (Instagram Style)
                  Row(
                    children: List.generate(
                      slides.length,
                      (index) => Expanded(
                        child: Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: index <= _step
                              ? FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: 1.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ).animate(onPlay: (controller) {
                                    if (index == _step) {
                                      controller.forward().then((_) => _nextSlide());
                                    }
                                  }).scaleX(begin: index == _step ? 0 : 1, duration: index == _step ? 5.seconds : 0.ms),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Title Text
                  AnimatedSwitcher(
                    duration: 400.ms,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(Tween(begin: const Offset(0, 0.2), end: Offset.zero)),
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      slides[_step].title,
                      key: ValueKey(_step),
                      style: GoogleFonts.inter(
                        fontSize: 50,
                        height: 1.1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Drag to Start Button
                  _DragButton(
                    onComplete: () => context.go('/signin'),
                    isFinal: _step == slides.length - 1,
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

class _DragButton extends StatefulWidget {
  final VoidCallback onComplete;
  final bool isFinal;

  const _DragButton({required this.onComplete, required this.isFinal});

  @override
  State<_DragButton> createState() => _DragButtonState();
}

class _DragButtonState extends State<_DragButton> {
  double _dragX = 0;
  final double _buttonSize = 48;
  final double _containerHeight = 64;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxDrag = constraints.maxWidth - _buttonSize - 16;

        return Container(
          height: _containerHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Label Text
                Center(
                  child: Text(
                    widget.isFinal ? 'Start Now' : 'Lets Started',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),

                // Arrows
                Positioned(
                  right: 24,
                  child: Row(
                    children: [
                      Icon(LucideIcons.chevronRight, size: 22, color: Colors.white.withOpacity(0.2)),
                      Transform.translate(
                        offset: const Offset(-12, 0),
                        child: Icon(LucideIcons.chevronRight, size: 22, color: Colors.white.withOpacity(0.4)),
                      ),
                      Transform.translate(
                        offset: const Offset(-24, 0),
                        child: Icon(LucideIcons.chevronRight, size: 22, color: Colors.white.withOpacity(0.6)),
                      ),
                    ],
                  ),
                ),

                // Draggable Thumb
                Positioned(
                  left: 8 + _dragX,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        _dragX += details.delta.dx;
                        if (_dragX < 0) _dragX = 0;
                        if (_dragX > maxDrag) _dragX = maxDrag;
                      });
                    },
                    onHorizontalDragEnd: (details) {
                      if (_dragX > maxDrag * 0.8) {
                        setState(() => _dragX = maxDrag);
                        widget.onComplete();
                      } else {
                        setState(() => _dragX = 0);
                      }
                    },
                    child: Container(
                      width: _buttonSize,
                      height: _buttonSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 20),
                        ],
                      ),
                      child: Icon(
                        widget.isFinal ? LucideIcons.unlock : LucideIcons.lock,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
