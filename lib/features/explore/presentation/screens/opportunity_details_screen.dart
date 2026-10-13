import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unicom/core/constants/mock_data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OpportunityDetailsScreen extends StatefulWidget {
  final String oppId;

  const OpportunityDetailsScreen({super.key, required this.oppId});

  @override
  State<OpportunityDetailsScreen> createState() => _OpportunityDetailsScreenState();
}

class _OpportunityDetailsScreenState extends State<OpportunityDetailsScreen> {
  late MockOpportunity opp;
  bool applied = false;

  @override
  void initState() {
    super.initState();
    opp = MockData.opportunities.firstWhere((o) => o.id == widget.oppId, orElse: () => MockData.opportunities.first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Opportunity',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).padding.bottom + 80,
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    opp.type,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                opp.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              
              // Author info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Row(
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
                            Text(
                              opp.author.name,
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            if (opp.author.verified) ...[
                              const SizedBox(width: 4),
                              const Icon(Icons.check_circle, color: Colors.blue, size: 14),
                            ],
                          ],
                        ),
                        Text(
                          opp.author.college,
                          style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Details
              Row(
                children: [
                  Icon(LucideIcons.clock, size: 16, color: Colors.black.withOpacity(0.5)),
                  const SizedBox(width: 8),
                  Text(
                    opp.deadline,
                    style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                  ),
                  const SizedBox(width: 24),
                  Icon(LucideIcons.users, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    '${opp.interested} interested',
                    style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.7)),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                opp.description,
                style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8), height: 1.5),
              ),
              
              const SizedBox(height: 24),
              
              const Text(
                'Roles Needed',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...opp.roles.map((role) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          role['title'],
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${role['count']} needed',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (role['skills'] as List<String>).map((skill) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              )),
            ],
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.02), offset: const Offset(0, -4), blurRadius: 10)
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  if (!applied) {
                    setState(() => applied = true);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 56,
                  decoration: BoxDecoration(
                    color: applied ? Colors.green : Colors.black,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text(
                      applied ? 'Interest Expressed ✓' : 'Express Interest',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
}
