import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';

class OpportunitiesScreen extends StatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  String activeFilter = 'All';
  final List<String> filters = ['All', 'Hackathons', 'Research', 'Startups', 'Study Groups', 'Travel'];

  IconData _getIconForType(String type) {
    if (type.contains('Hackathon')) return LucideIcons.zap;
    if (type.contains('Research')) return LucideIcons.library;
    if (type.contains('Startup')) return LucideIcons.briefcase;
    if (type.contains('Study')) return LucideIcons.graduationCap;
    return LucideIcons.target;
  }

  Color _getColorForType(String type) {
    if (type.contains('Hackathon')) return Colors.orange;
    if (type.contains('Research')) return Colors.blue;
    if (type.contains('Startup')) return Colors.teal;
    if (type.contains('Study')) return Colors.purple;
    return Colors.indigo;
  }

  @override
  Widget build(BuildContext context) {
    final filteredOpportunities = activeFilter == 'All' 
        ? MockData.opportunities 
        : MockData.opportunities.where((o) => o.type.contains(activeFilter)).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            const Text(
              'Opportunity Board',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(width: 8),
            Icon(LucideIcons.target, color: Colors.black.withOpacity(0.4), size: 20),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(LucideIcons.plus, color: Colors.white, size: 20),
              onPressed: () {},
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isActive = activeFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => activeFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.black : Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: isActive ? [
                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))
                      ] : null,
                    ),
                    child: Center(
                      child: Text(
                        filter.toUpperCase(),
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredOpportunities.length,
        itemBuilder: (context, index) {
          final opp = filteredOpportunities[index];
          final color = _getColorForType(opp.type);
          
          return GestureDetector(
            onTap: () => context.push('/opportunity/${opp.id}'),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(_getIconForType(opp.type), size: 14, color: color),
                            const SizedBox(width: 6),
                            Text(opp.type.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: opp.deadline.contains('days') ? Colors.red.withOpacity(0.1) : Colors.indigo.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(LucideIcons.clock, size: 12, color: opp.deadline.contains('days') ? Colors.red : Colors.indigo),
                            const SizedBox(width: 4),
                            Text(opp.deadline.toUpperCase(), style: TextStyle(
                              color: opp.deadline.contains('days') ? Colors.red : Colors.indigo,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    opp.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: opp.skills.map((skill) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(skill, style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 11, fontWeight: FontWeight.bold)),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: CachedNetworkImageProvider(opp.author.avatar),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(opp.author.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  if (opp.author.verified) ...[
                                    const SizedBox(width: 4),
                                    const Icon(LucideIcons.checkCircle, color: Colors.blue, size: 12),
                                  ]
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Icon(LucideIcons.mapPin, size: 10, color: Colors.black.withOpacity(0.5)),
                                  const SizedBox(width: 4),
                                  Text(opp.author.college.toUpperCase(), style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.arrowRight, size: 16),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
