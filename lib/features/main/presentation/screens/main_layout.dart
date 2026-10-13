import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          child,
          const Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(child: CustomBottomNav()),
          ),
        ],
      ),
    );
  }
}

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    
    final navItems = [
      {'icon': LucideIcons.home, 'path': '/home'},
      {'icon': LucideIcons.search, 'path': '/explore'},
      {'icon': LucideIcons.plus, 'path': '/create'},
      {'icon': LucideIcons.heart, 'path': '/notifications'},
      {'icon': LucideIcons.user, 'path': '/profile'},
    ];

    int activeIndex = navItems.indexWhere((item) => 
        location == item['path'] || (location.startsWith(item['path'] as String) && item['path'] != '/home'));
    if (activeIndex == -1) activeIndex = 0;

    const double itemWidth = 50.0;
    const double itemMargin = 4.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withOpacity(0.85),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 40,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: SizedBox(
            height: 50,
            width: (itemWidth + itemMargin * 2) * navItems.length,
            child: Stack(
              children: [
                // The sliding indicator
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastOutSlowIn,
                  left: activeIndex * (itemWidth + itemMargin * 2) + itemMargin,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                  ),
                ),
                
                // The Icons Layer
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(navItems.length, (index) {
                    final item = navItems[index];
                    final String path = item['path'] as String;
                    final bool isActive = index == activeIndex;
                    
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (path == '/create') {
                          context.push(path);
                        } else {
                          context.go(path);
                        }
                      },
                      child: Container(
                        width: itemWidth,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: itemMargin),
                        child: Center(
                          child: path == '/profile' 
                              ? AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: isActive ? 28 : 24,
                                  height: isActive ? 28 : 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isActive ? Colors.black.withOpacity(0.2) : Colors.transparent,
                                      width: isActive ? 1.5 : 0,
                                    ),
                                    boxShadow: isActive ? [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4)
                                    ] : null,
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: MockData.currentUser.avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 300),
                                  style: TextStyle(
                                    color: isActive ? Colors.black : Colors.white.withOpacity(0.6),
                                  ),
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 22,
                                    color: isActive ? Colors.black : Colors.white.withOpacity(0.6),
                                  ),
                                ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
