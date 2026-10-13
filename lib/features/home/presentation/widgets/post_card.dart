import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:unicom/core/constants/mock_data.dart';
import 'package:go_router/go_router.dart';

class PostCard extends StatefulWidget {
  final MockPost post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int voteStatus;
  late int voteCount;
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    voteStatus = widget.post.isLiked ? 1 : 0;
    voteCount = widget.post.likes;
    isSaved = widget.post.isSaved;
  }

  void _handleUpvote() {
    setState(() {
      if (voteStatus == 1) {
        voteStatus = 0;
        voteCount--;
      } else {
        voteCount += (voteStatus == -1 ? 2 : 1);
        voteStatus = 1;
      }
    });
  }

  void _handleDownvote() {
    setState(() {
      if (voteStatus == -1) {
        voteStatus = 0;
        voteCount++;
      } else {
        voteCount -= (voteStatus == 1 ? 2 : 1);
        voteStatus = -1;
      }
    });
  }

  void _handleSave() {
    setState(() {
      isSaved = !isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayImage = (widget.post.images.isNotEmpty)
        ? widget.post.images[0]
        : "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=800&auto=format&fit=crop";

    return GestureDetector(
      onTap: () {
        context.push('/post/${widget.post.id}');
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 25,
              offset: const Offset(0, 4),
            )
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Hero Image
              CachedNetworkImage(
                imageUrl: displayImage,
                fit: BoxFit.cover,
              ),

              // Gradient Overlay
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black45,
                      Colors.transparent,
                      Colors.black87,
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
              ),

              // Top Overlay
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author Info
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.push('/profile'),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withOpacity(0.2)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundImage: CachedNetworkImageProvider(widget.post.author.avatar),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                widget.post.author.name,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  letterSpacing: -0.5,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (widget.post.author.role.isNotEmpty) ...[
                                              const SizedBox(width: 4),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.2),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  widget.post.author.role.toUpperCase(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            if (widget.post.author.verified) ...[
                                              const SizedBox(width: 4),
                                              const Icon(Icons.check_circle, color: Color(0xFF0064E0), size: 14),
                                            ],
                                          ],
                                        ),
                                        Text(
                                          widget.post.author.handle.isNotEmpty ? widget.post.author.handle : '@student',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Top Right Actions
                    Column(
                      children: [
                        _buildGlassIconButton(
                          icon: isSaved ? LucideIcons.bookmark : LucideIcons.bookmark,
                          iconColor: isSaved ? Colors.white : Colors.white,
                          isFilled: isSaved,
                          onTap: _handleSave,
                        ),
                        const SizedBox(height: 8),
                        _buildGlassIconButton(
                          icon: LucideIcons.moreHorizontal,
                          iconColor: Colors.white,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Overlay
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Actions Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Voting
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white.withOpacity(0.1)),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: _handleUpvote,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: voteStatus == 1 ? Colors.orange.withOpacity(0.2) : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        LucideIcons.arrowUp,
                                        size: 22,
                                        color: voteStatus == 1 ? Colors.orange : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      voteCount.toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: voteStatus == 1 ? Colors.orange : (voteStatus == -1 ? Colors.indigoAccent : Colors.white),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _handleDownvote,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: voteStatus == -1 ? Colors.indigoAccent.withOpacity(0.2) : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        LucideIcons.arrowDown,
                                        size: 22,
                                        color: voteStatus == -1 ? Colors.indigoAccent : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Comments and Share
                        Row(
                          children: [
                            _buildGlassIconButton(
                              icon: LucideIcons.messageCircle,
                              iconColor: Colors.white,
                              size: 44,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            _buildGlassIconButton(
                              icon: LucideIcons.send,
                              iconColor: Colors.white,
                              size: 44,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Tags & Badges
                    if (widget.post.skills != null || widget.post.type.isNotEmpty || widget.post.date != null)
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          if (widget.post.type.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                widget.post.type.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          if (widget.post.type == 'event' && widget.post.date != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.8),
                                  ),
                                  child: Text(
                                    widget.post.date!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (widget.post.skills != null)
                            ...widget.post.skills!.map(
                              (skill) => ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                                    ),
                                    child: Text(
                                      '#${skill.toLowerCase().replaceAll(' ', '')}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    
                    const SizedBox(height: 8),

                    // Caption
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.post.title != null)
                          Text(
                            widget.post.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        if (widget.post.title != null) const SizedBox(height: 4),
                        Text(
                          widget.post.content,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassIconButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    bool isFilled = false,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isFilled ? Colors.white : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(size / 2),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Icon(
              icon,
              size: size * 0.45,
              color: isFilled ? Colors.black : iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
