import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';

class StoryViewScreen extends StatefulWidget {
  final String id;
  const StoryViewScreen({super.key, required this.id});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  late int _currentIndex;
  Timer? _timer;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = MockData.stories.indexWhere((s) => s.id == widget.id);
    if (_currentIndex == -1) _currentIndex = 0;
    
    _startTimer();
  }

  void _startTimer() {
    _progress = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += (50 / 5000); // 5 seconds per story
        if (_progress >= 1.0) {
          _progress = 1.0;
          timer.cancel();
          _handleNext();
        }
      });
    });
  }

  void _handleNext() {
    if (_currentIndex < MockData.stories.length - 1) {
      setState(() {
        _currentIndex++;
        _startTimer();
      });
    } else {
      context.pop();
    }
  }

  void _handlePrev() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _startTimer();
      });
    } else {
      _startTimer(); // Restart current if it's the first one
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = MockData.stories[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: story.image,
                fit: BoxFit.cover,
              ),
            ),
            
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.3, 1.0],
                  ),
                ),
              ),
            ),

            // Tap Areas
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.3,
              child: GestureDetector(
                onTap: _handlePrev,
                behavior: HitTestBehavior.opaque,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.7,
              child: GestureDetector(
                onTap: _handleNext,
                behavior: HitTestBehavior.opaque,
              ),
            ),

            // Progress Bars
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(MockData.stories.length, (index) {
                  return Expanded(
                    child: Container(
                      height: 3,
                      margin: EdgeInsets.only(right: index == MockData.stories.length - 1 ? 0 : 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(1.5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: index == _currentIndex
                                ? MediaQuery.of(context).size.width * _progress
                                : (index < _currentIndex ? MediaQuery.of(context).size.width : 0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Header
            Positioned(
              top: 32,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: CachedNetworkImageProvider(story.user.avatar),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        story.user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '2h',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      color: Colors.transparent,
                      child: const Icon(LucideIcons.x, color: Colors.white, size: 24),
                    ),
                  ),
                ],
              ),
            ),

            // Reply Area
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Reply...',
                          hintStyle: TextStyle(color: Colors.white70, fontSize: 15),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: const Center(
                      child: Text('❤️', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
