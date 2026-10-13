import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isPrivate = false;

  void _handleLogout() {
    // Navigate back to sign in
    context.go('/signin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  color: Colors.white.withOpacity(0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 8),
                          color: Colors.transparent,
                          child: const Icon(LucideIcons.arrowLeft, size: 24, color: Colors.black),
                        ),
                      ),
                      const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(LucideIcons.settings, size: 20, color: Colors.black.withOpacity(0.4)),
                    ],
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Search
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(LucideIcons.search, size: 20, color: Colors.black.withOpacity(0.4)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search settings...',
                              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 15),
                            ),
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Section 1
                  _buildSectionTitle('Your account'),
                  _buildSectionContainer(
                    child: _buildSettingItem(
                      icon: LucideIcons.user,
                      title: 'Account Center',
                      subtitle: 'Password, security, personal details',
                      isLast: true,
                    ),
                  ),

                  // Section 2
                  _buildSectionTitle('Who can see your content'),
                  _buildSectionContainer(
                    child: Column(
                      children: [
                        _buildSettingItem(
                          icon: LucideIcons.shield,
                          title: 'Private Account',
                          subtitle: isPrivate ? 'Visible only to your college' : 'Visible cross-college',
                          rightElement: GestureDetector(
                            onTap: () => setState(() => isPrivate = !isPrivate),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 48,
                              height: 28,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: isPrivate ? Colors.black : Colors.black.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutBack,
                                alignment: isPrivate ? Alignment.centerRight : Alignment.centerLeft,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _buildSettingItem(icon: LucideIcons.user, title: 'Close Friends'),
                        _buildSettingItem(icon: LucideIcons.lock, title: 'Blocked', isLast: true),
                      ],
                    ),
                  ),

                  // Section 3
                  _buildSectionTitle('How you use Unicom'),
                  _buildSectionContainer(
                    child: Column(
                      children: [
                        _buildSettingItem(icon: LucideIcons.bell, title: 'Notifications'),
                        _buildSettingItem(icon: LucideIcons.lock, title: 'Time spent', isLast: true),
                      ],
                    ),
                  ),

                  // Section 4
                  _buildSectionTitle('Info and support'),
                  _buildSectionContainer(
                    child: Column(
                      children: [
                        _buildSettingItem(icon: LucideIcons.helpCircle, title: 'Help'),
                        _buildSettingItem(icon: LucideIcons.info, title: 'About', isLast: true),
                      ],
                    ),
                  ),

                  // Logout
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _handleLogout,
                    child: _buildSectionContainer(
                      child: _buildSettingItem(
                        icon: LucideIcons.logOut,
                        title: 'Log out',
                        danger: true,
                        isLast: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      'UNICOM ENGINE\nVERSION 2.0.0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.black.withOpacity(0.3),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.4),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? rightElement,
    bool danger = false,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: isLast ? null : Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: danger ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: danger ? Colors.red[600]! : Colors.black.withOpacity(0.1)),
              boxShadow: danger 
                  ? [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 2))]
                  : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
            ),
            child: Icon(icon, size: 18, color: danger ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: danger ? Colors.red : Colors.black.withOpacity(0.9),
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (rightElement != null)
            rightElement
          else if (!danger)
            Icon(LucideIcons.chevronRight, size: 18, color: Colors.black.withOpacity(0.3)),
        ],
      ),
    );
  }
}
