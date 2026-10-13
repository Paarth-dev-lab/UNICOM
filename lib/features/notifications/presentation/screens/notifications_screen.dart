import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';
import 'package:unicom/core/widgets/custom_button.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String activeTab = 'All';
  final tabs = ['All', 'My Posts', 'Mentions'];

  Widget _getNotificationIcon(String type) {
    switch (type) {
      case 'like':
        return _buildIconBadge(LucideIcons.heart, Colors.red);
      case 'connection':
        return _buildIconBadge(LucideIcons.userPlus, Colors.blue);
      case 'opportunity':
        return _buildIconBadge(LucideIcons.briefcase, Colors.orange);
      case 'comment':
        return _buildIconBadge(LucideIcons.messageSquare, Colors.green);
      default:
        return const SizedBox();
    }
  }

  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 2))
        ],
      ),
      child: Center(
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Premium Apple-style Glass Header
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                    ),
                                    child: const Icon(LucideIcons.arrowLeft, size: 24),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(LucideIcons.bellRing, size: 20, color: Colors.black.withOpacity(0.4)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                              ),
                              child: const Icon(LucideIcons.moreHorizontal, size: 20),
                            ),
                          ],
                        ),
                      ),

                      // Tabs
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: tabs.map((tab) {
                            final isActive = activeTab == tab;
                            return GestureDetector(
                              onTap: () => setState(() => activeTab = tab),
                              child: Container(
                                margin: const EdgeInsets.only(right: 24),
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isActive ? Colors.black : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  tab,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isActive ? Colors.black : Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: MockData.notifications.length,
                itemBuilder: (context, index) {
                  final notif = MockData.notifications[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: notif.read ? Colors.white.withOpacity(0.6) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: notif.read ? Colors.black.withOpacity(0.05) : Colors.transparent,
                      ),
                      boxShadow: notif.read ? null : [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar and Icon
                        SizedBox(
                          width: 56,
                          height: 56,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundImage: CachedNetworkImageProvider(notif.user.avatar),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: _getNotificationIcon(notif.type),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.4),
                                  children: [
                                    TextSpan(text: '${notif.user.name} ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                                    TextSpan(text: notif.content),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif.time.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.4),
                                  letterSpacing: 1,
                                ),
                              ),
                              
                              if (notif.type == 'connection') ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {},
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: const Text('Accept', style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: CustomButton(
                                        onPressed: () {},
                                        variant: ButtonVariant.outline,
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: const Text('Ignore', style: TextStyle(fontSize: 12)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              if (notif.type == 'opportunity') ...[
                                const SizedBox(height: 12),
                                CustomButton(
                                  onPressed: () {},
                                  variant: ButtonVariant.outline,
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  child: const Text('View Details', style: TextStyle(fontSize: 12)),
                                ),
                              ],
                            ],
                          ),
                        ),

                        // Unread Dot
                        if (!notif.read)
                          Container(
                            margin: const EdgeInsets.only(top: 8, left: 8),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 8)
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
