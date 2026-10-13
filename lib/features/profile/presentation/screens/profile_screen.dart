import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';
import 'package:unicom/core/widgets/custom_button.dart';
import 'package:unicom/features/home/presentation/widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String activeTab = 'posts';

  final List<String> portfolioImages = [
    "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=400&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=400&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=400&auto=format&fit=crop",
    "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=400&auto=format&fit=crop"
  ];

  final List<Map<String, dynamic>> skills = [
    {"name": "ReactJS", "endorsements": 12},
    {"name": "UI/UX Design", "endorsements": 8},
    {"name": "Figma", "endorsements": 24},
    {"name": "Product Management", "endorsements": 5},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverToBoxAdapter(
            child: _buildInfoSection(),
          ),
          SliverToBoxAdapter(
            child: _buildTabIcons(),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            sliver: _buildTabContent(),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 100), // Bottom padding for nav bar
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 280,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Cover Image
          Container(
            height: 224,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  imageUrl: "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?q=80&w=1000&auto=format&fit=crop",
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Top Buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(LucideIcons.grid),
                  _buildIconButton(LucideIcons.settings, onTap: () => context.push('/settings')),
                ],
              ),
            ),
          ),

          // Avatar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: 0.05, // Slight rotation (~3 degrees)
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Colors.white, width: 5),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 30, offset: Offset(0, 8))
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(31),
                    child: Transform.rotate(
                      angle: -0.05,
                      child: CachedNetworkImage(
                        imageUrl: MockData.currentUser.avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                MockData.currentUser.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (MockData.currentUser.verified) ...[
                const SizedBox(width: 4),
                const Icon(LucideIcons.checkCircle2, color: Color(0xFF0064E0), size: 20),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${MockData.currentUser.handle} • ${MockData.currentUser.college}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),
          ),
          const SizedBox(height: 12),
          Text(
            'Product Designer & Developer. Building the future of campus networking ✨',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), height: 1.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          
          // Stats
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.03),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('1.2 K', 'Followers'),
                Container(width: 1, height: 32, color: Colors.black.withOpacity(0.1)),
                _buildStatItem('840', 'Following'),
                Container(width: 1, height: 32, color: Colors.black.withOpacity(0.1)),
                _buildStatItem('166', 'Posts'),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  child: const Text('Follow', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  onPressed: () {},
                  variant: ButtonVariant.outline,
                  child: const Text('Message', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.5), letterSpacing: 1),
        ),
      ],
    );
  }

  Widget _buildTabIcons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabIcon('posts', LucideIcons.grid),
          _buildTabIcon('skills', LucideIcons.shieldCheck),
          _buildTabIcon('saved', LucideIcons.bookmark),
        ],
      ),
    );
  }

  Widget _buildTabIcon(String id, IconData icon) {
    final isActive = activeTab == id;
    return GestureDetector(
      onTap: () => setState(() => activeTab = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 24,
          color: isActive ? Colors.black : Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (activeTab) {
      case 'posts':
        return SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildPortfolioImage(portfolioImages[0], 224),
                    const SizedBox(height: 12),
                    _buildPortfolioImage(portfolioImages[2], 160),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _buildPortfolioImage(portfolioImages[1], 160),
                    const SizedBox(height: 12),
                    _buildPortfolioImage(portfolioImages[3], 224),
                  ],
                ),
              ),
            ],
          ),
        );
      case 'skills':
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8, left: 4),
                  child: Text('Endorsed Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                );
              }
              final skill = skills[index - 1];
              final double percentage = (skill['endorsements'] as int) * 5.0 / 100.0;
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                ),
                child: Stack(
                  children: [
                    // Progress fill
                    FractionallySizedBox(
                      widthFactor: percentage.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(skill['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black.withOpacity(0.05)),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.shieldCheck, size: 14, color: Colors.green),
                                const SizedBox(width: 4),
                                Text(
                                  skill['endorsements'].toString(),
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: skills.length + 1,
          ),
        );
      case 'saved':
        final savedPosts = MockData.posts.where((p) => p.isSaved).toList();
        if (savedPosts.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(LucideIcons.bookmark, size: 40, color: Colors.black.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  const Text('No saved posts yet', style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 8, left: 4),
                  child: Text('Saved Collections', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: PostCard(post: savedPosts[index - 1]),
              );
            },
            childCount: savedPosts.length + 1,
          ),
        );
      default:
        return const SliverToBoxAdapter(child: SizedBox());
    }
  }

  Widget _buildPortfolioImage(String url, double height) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
      ),
    );
  }
}
