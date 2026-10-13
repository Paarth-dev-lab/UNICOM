import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';
import 'package:unicom/core/widgets/custom_button.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  String activeTab = 'post';
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.x, color: Colors.black),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'New ${activeTab == 'post' ? 'Post' : activeTab == 'story' ? 'Story' : 'Opportunity'}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            const Icon(LucideIcons.chevronDown, size: 16),
                          ],
                        ),
                      ),
                      if (activeTab == 'post')
                        CustomButton(
                          onPressed: () {
                            // Handle share logic here
                            context.pop();
                          },
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          child: const Text('Share'),
                        )
                      else
                        const SizedBox(width: 72),
                    ],
                  ),
                ),

                // Main Content
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),

            // Bottom Tabs
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black.withOpacity(0.1)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 40, offset: const Offset(0, 10))
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: ['post', 'story', 'opportunity'].map((tab) {
                          final isActive = activeTab == tab;
                          return GestureDetector(
                            onTap: () => setState(() => activeTab = tab),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: isActive ? Colors.black : Colors.transparent,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                tab.toUpperCase(),
                                style: TextStyle(
                                  color: isActive ? Colors.white : Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (activeTab) {
      case 'post':
        return _buildPostTab();
      case 'story':
        return _buildStoryTab();
      case 'opportunity':
        return _buildOpportunityTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildPostTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: CachedNetworkImageProvider(MockData.currentUser.avatar),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MockData.currentUser.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: _postController,
                      maxLines: null,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "What's going on?",
                        hintStyle: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.3)),
                      ),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 68, bottom: 80),
            child: Row(
              children: [
                _buildToolIcon(LucideIcons.image),
                const SizedBox(width: 8),
                _buildToolIcon(LucideIcons.video),
                const SizedBox(width: 8),
                _buildToolIcon(LucideIcons.hash),
                const SizedBox(width: 8),
                _buildToolIcon(LucideIcons.smilePlus),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryTab() {
    return Container(
      color: Colors.black,
      width: double.infinity,
      child: Stack(
        children: [
          // Camera Viewfinder (placeholder)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Icon(LucideIcons.camera, color: Colors.white.withOpacity(0.2), size: 40),
                ),
                const SizedBox(height: 40),
                const Text('Tap to capture', style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
          
          // Right Toolbar
          Positioned(
            top: 24,
            right: 16,
            child: Column(
              children: [
                _buildStoryTool(LucideIcons.type),
                const SizedBox(height: 16),
                _buildStoryTool(LucideIcons.sparkles),
                const SizedBox(height: 16),
                _buildStoryTool(LucideIcons.penTool),
                const SizedBox(height: 16),
                _buildStoryTool(LucideIcons.link),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black87, Colors.transparent],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white.withOpacity(0.5)),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(MockData.currentUser.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Container(
                          width: 62,
                          height: 62,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: const Icon(LucideIcons.camera, color: Colors.white, size: 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryTool(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(21),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildOpportunityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(LucideIcons.briefcase),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        hintText: 'Opportunity Title',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Describe the opportunity, project in depth...',
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDropdownField('Opportunity Type', 'Hackathon Team'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInputField('Date', 'e.g. Oct 24th', LucideIcons.calendar)),
              const SizedBox(width: 12),
              Expanded(child: _buildInputField('Languages', 'e.g. Eng', LucideIcons.globe)),
            ],
          ),
          const SizedBox(height: 12),
          _buildInputField('Roles Needed', 'e.g. Frontend Dev (1)', LucideIcons.users),
          const SizedBox(height: 12),
          _buildInputField('Required Skills', 'e.g. React, Node', LucideIcons.hash),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: () => context.pop(),
            backgroundColor: Colors.black,
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Text('Publish Opportunity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildToolIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black.withOpacity(0.5)),
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.5))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Icon(LucideIcons.chevronDown, color: Colors.black.withOpacity(0.4)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.5))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Icon(icon, color: Colors.black.withOpacity(0.4)),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
