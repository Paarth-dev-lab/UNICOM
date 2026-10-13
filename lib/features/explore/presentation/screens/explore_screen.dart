import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> tabs = ['All', 'People', 'Posts', 'Events', 'Groups'];
  String activeTab = 'All';
  
  final Map<int, String> connections = {};

  final List<Map<String, String>> tags = [
    {'name': '#ETHIndia2026', 'views': '24K'},
    {'name': '#PlacementSzn', 'views': '18K'},
    {'name': '#UIUX', 'views': '12K'},
    {'name': '#StartupPitch', 'views': '5K'},
    {'name': '#TechFest', 'views': '2K'}
  ];

  void _handleConnect(int id) {
    setState(() {
      connections[id] = 'pending';
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          connections[id] = 'connected';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              backgroundColor: Colors.white.withOpacity(0.9),
              pinned: true,
              elevation: 0,
              expandedHeight: 120,
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Search Bar
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              Icon(LucideIcons.search, size: 18, color: Colors.black.withOpacity(0.4)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search people, posts, or keywords...',
                                    hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.3),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Tabs
                        SizedBox(
                          height: 36,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: tabs.length,
                            itemBuilder: (context, index) {
                              final tab = tabs[index];
                              final isActive = activeTab == tab;
                              return GestureDetector(
                                onTap: () => setState(() => activeTab = tab),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.black : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: isActive ? [
                                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))
                                    ] : null,
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
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  
                  // Hubs Grid
                  Row(
                    children: [
                      // Communities
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push('/communities'),
                          child: Container(
                            height: 140,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.orange, Colors.redAccent],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                                  ),
                                  child: const Icon(LucideIcons.users, color: Colors.white, size: 20),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Communities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('JOIN HUBS', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Opps & Events
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => context.push('/opportunities'),
                              child: Container(
                                height: 64,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.deepPurpleAccent, Colors.indigo],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 4))
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                                      ),
                                      child: const Icon(LucideIcons.target, color: Colors.white, size: 16),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text('Opportunities', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () => context.push('/events'),
                              child: Container(
                                height: 64,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.tealAccent, Colors.teal],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 4))
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                                      ),
                                      child: const Icon(LucideIcons.calendar, color: Colors.white, size: 16),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text('Events', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Trending Topics
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), shape: BoxShape.circle),
                        child: const Icon(LucideIcons.trendingUp, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Text('Trending Topics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black.withOpacity(0.05)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(tag['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
                            child: Text(tag['views']!, style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )).toList(),
                  ),

                  const SizedBox(height: 32),

                  // People to Connect
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), shape: BoxShape.circle),
                        child: const Icon(LucideIcons.sparkles, size: 16),
                      ),
                      const SizedBox(width: 8),
                      const Text('People to Connect', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    height: 252,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: MockData.people.length,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        final person = MockData.people[index];
                        final id = index + 1;
                        final status = connections[id] ?? 'none';
                        
                        return Container(
                          width: 180,
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.black.withOpacity(0.05)),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 8))
                            ],
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 34,
                                        backgroundImage: CachedNetworkImageProvider(person.avatar),
                                      ),
                                      if (person.verified)
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF0064E0),
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white, width: 2),
                                            ),
                                            child: const Icon(LucideIcons.check, color: Colors.white, size: 10),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text(person.college, style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                                    child: Text(person.role.toUpperCase(), style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 0.8), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(height: 3),
                                  Text('${person.mutualConnections} mutual', style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 10)),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: status == 'none' ? () => _handleConnect(id) : null,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: status == 'none' ? Colors.black : (status == 'pending' ? Colors.black.withOpacity(0.05) : Colors.green.withOpacity(0.1)),
                                        borderRadius: BorderRadius.circular(14),
                                        border: status == 'pending' ? Border.all(color: Colors.black.withOpacity(0.1)) : null,
                                      ),
                                      child: Center(
                                        child: status == 'none'
                                          ? const Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(LucideIcons.userPlus, color: Colors.white, size: 14),
                                                SizedBox(width: 6),
                                                Text("Connect", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                              ],
                                            )
                                          : status == 'pending'
                                            ? Text("Pending...", style: TextStyle(color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.bold, fontSize: 13))
                                            : Text("Connected ✓", style: TextStyle(color: Colors.green[600], fontWeight: FontWeight.bold, fontSize: 13)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )

                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
