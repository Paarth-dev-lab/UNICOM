import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  const ChatScreen({super.key, required this.id});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGroup = widget.id == 'm2';
    final chatName = isGroup ? 'ETHIndia Team 4' : 'Sneha Rao';
    final chatAvatar = isGroup ? 'https://picsum.photos/seed/team4/200/200' : 'https://picsum.photos/seed/sneha/200/200';
    final isOnline = !isGroup;

    final messages = [
      {"text": "Hey! Are you going to the UI/UX workshop tomorrow?", "sender": "other", "time": "10:24 AM"},
      {"text": "Yes, I RSVP'd yesterday. Should we go together?", "sender": "me", "time": "10:30 AM"},
      {"text": "Sounds good! Let's meet at the campus gate.", "sender": "other", "time": "10:32 AM"},
    ];

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
                  color: Colors.white.withOpacity(0.9),
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
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(LucideIcons.chevronLeft, size: 24, color: Colors.black),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: CachedNetworkImageProvider(chatAvatar),
                                    ),
                                    if (isOnline)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.white, width: 2),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chatName,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.2),
                                  ),
                                  if (isOnline)
                                    Text(
                                      'Active now',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(LucideIcons.phone, size: 20, color: Colors.black.withOpacity(0.6)),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(LucideIcons.video, size: 20, color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Chat Area
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isMe = msg['sender'] == 'me';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[600] : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isMe ? 20 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 20),
                            ),
                            border: isMe ? null : Border.all(color: Colors.black.withOpacity(0.05)),
                            boxShadow: [
                              BoxShadow(
                                color: isMe ? Colors.blue.withOpacity(0.2) : Colors.black.withOpacity(0.02),
                                blurRadius: isMe ? 15 : 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            msg['text']!,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            msg['time']!,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(LucideIcons.image, size: 20, color: Colors.black.withOpacity(0.6)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              decoration: InputDecoration(
                                hintText: 'Message...',
                                hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 15),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                              onChanged: (v) => setState(() {}),
                            ),
                          ),
                          if (_inputController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(LucideIcons.send, size: 16, color: Colors.white),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(LucideIcons.mic, size: 20, color: Colors.black.withOpacity(0.6)),
                            ),
                        ],
                      ),
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
