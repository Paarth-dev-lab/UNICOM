import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/widgets/custom_button.dart';
import 'package:unicom/core/widgets/custom_input.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  int step = 0;
  final PageController _pageController = PageController();

  String role = '';
  String name = '';
  String phone = '';
  String age = '';
  String college = '';
  String course = '';
  String year = '';
  List<String> interests = [];

  final List<String> availableInterests = [
    "Tech & Coding", "Design", "Business & Startup", "Music", 
    "Sports", "Gaming", "Photography", "Art", "Hackathons", 
    "Literature", "Fests", "Robotics"
  ];

  final List<Map<String, dynamic>> roles = [
    {'id': 'student', 'label': 'Student', 'icon': LucideIcons.graduationCap},
    {'id': 'professor', 'label': 'Professor', 'icon': LucideIcons.briefcase},
    {'id': 'club', 'label': 'Club/Society', 'icon': LucideIcons.users},
    {'id': 'admin', 'label': 'College Admin', 'icon': LucideIcons.building},
  ];

  void _nextStep() {
    if (step < 3) {
      setState(() => step++);
      _pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic);
    } else {
      context.go('/home');
    }
  }

  void _prevStep() {
    if (step > 0) {
      setState(() => step--);
      _pageController.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOutCubic);
    } else {
      context.pop();
    }
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (interests.contains(interest)) {
        interests.remove(interest);
      } else {
        interests.add(interest);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: CachedNetworkImage(
                imageUrl: "https://images.unsplash.com/photo-1523240795612-9a054b0db644?q=80&w=1000&auto=format&fit=crop",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _prevStep,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: const Icon(LucideIcons.arrowLeft, color: Colors.white, size: 20),
                        ),
                      ),
                      Row(
                        children: List.generate(4, (index) {
                          final isActive = step >= index;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 6,
                            width: isActive ? 32 : 16,
                            decoration: BoxDecoration(
                              color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: isActive ? [BoxShadow(color: Colors.white.withOpacity(0.5), blurRadius: 10)] : null,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                // Content Pages
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStep0(),
                      _buildStep1(),
                      _buildStep2(),
                      _buildStep3(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep0() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text('Select Role', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 8),
          Text('How will you use Unicom?', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
          const SizedBox(height: 32),
          
          Expanded(
            child: ListView.builder(
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final r = roles[index];
                final isSelected = role == r['id'];
                return GestureDetector(
                  onTap: () => setState(() => role = r['id'] as String),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isSelected ? Colors.white : Colors.white.withOpacity(0.2)),
                      boxShadow: isSelected ? [BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 20)] : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.black.withOpacity(0.05) : Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(r['icon'] as IconData, color: isSelected ? Colors.black : Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            r['label'] as String,
                            style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (isSelected) const Icon(LucideIcons.check, color: Colors.black),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomButton(
              onPressed: role.isNotEmpty ? _nextStep : null,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fullWidth: true,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(LucideIcons.arrowRight, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text('About you', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 8),
          Text("Let's start with the basics.", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputLabel(role == 'club' ? 'Club Name' : 'Full Name'),
                CustomInput(
                  hintText: role == 'club' ? "e.g. Coding Club" : "John Doe",
                  icon: role == 'club' ? LucideIcons.users : LucideIcons.user,
                  onChanged: (v) => setState(() => name = v),
                ),
                const SizedBox(height: 16),
                
                _buildInputLabel('Phone Number'),
                CustomInput(
                  hintText: "+91 98765 43210",
                  icon: LucideIcons.phone,
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => setState(() => phone = v),
                ),
                
                if (role == 'student') ...[
                  const SizedBox(height: 16),
                  _buildInputLabel('Age'),
                  CustomInput(
                    hintText: "19",
                    icon: LucideIcons.calendar,
                    keyboardType: TextInputType.number,
                    onChanged: (v) => setState(() => age = v),
                  ),
                ],
              ],
            ),
          ),
          
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomButton(
              onPressed: name.isNotEmpty ? _nextStep : null,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fullWidth: true,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(LucideIcons.arrowRight, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text('Academics', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 8),
          Text("Where are you studying or working?", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
          const SizedBox(height: 32),
          
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInputLabel('College / University'),
                CustomInput(
                  hintText: "e.g. IIT Delhi",
                  icon: LucideIcons.building,
                  onChanged: (v) => setState(() => college = v),
                ),
                
                if (role == 'student') ...[
                  const SizedBox(height: 16),
                  _buildInputLabel('Course / Degree'),
                  CustomInput(
                    hintText: "e.g. B.Tech Computer Science",
                    icon: LucideIcons.bookOpen,
                    onChanged: (v) => setState(() => course = v),
                  ),
                  const SizedBox(height: 16),
                  _buildInputLabel('Year of Study'),
                  CustomInput(
                    hintText: "e.g. 2nd Year",
                    icon: LucideIcons.graduationCap,
                    onChanged: (v) => setState(() => year = v),
                  ),
                ],
              ],
            ),
          ),
          
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomButton(
              onPressed: college.isNotEmpty ? _nextStep : null,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fullWidth: true,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8),
                  Icon(LucideIcons.arrowRight, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text('Interests', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 8),
          Text("Pick 3 or more to personalize your feed.", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
          const SizedBox(height: 32),
          
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: availableInterests.map((interest) {
                  final isSelected = interests.contains(interest);
                  return GestureDetector(
                    onTap: () => _toggleInterest(interest),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: isSelected ? Colors.white : Colors.white.withOpacity(0.2)),
                        boxShadow: isSelected ? [BoxShadow(color: Colors.white.withOpacity(0.4), blurRadius: 15)] : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const Icon(LucideIcons.check, size: 16, color: Colors.black),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            interest,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CustomButton(
              onPressed: interests.length >= 3 ? _nextStep : null,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fullWidth: true,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text('Complete Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
