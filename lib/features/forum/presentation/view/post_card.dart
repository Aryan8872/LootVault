import 'package:flutter/material.dart';
import 'package:loot_vault/features/forum/presentation/view/forum_view.dart';

class ForumPostCard extends StatefulWidget {
  final ForumPost post;

  const ForumPostCard({super.key, required this.post});

  @override
  _ForumPostCardState createState() => _ForumPostCardState();
}

class _ForumPostCardState extends State<ForumPostCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      onTap: () {
        Navigator.pushNamed(context, '/post', arguments: widget.post);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blue[100],
                  child: Text(
                    widget.post.user[0],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Post Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Person"),
                      Text(
                        widget.post.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.post.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                               Icon(Icons.thumb_up,
                                  size: 20, color: Colors.grey[600]),
                              const SizedBox(width: 6),
                              Text('${widget.post.likes}',
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(width: 16),
                              Icon(Icons.comment,
                                  size: 20, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text('${widget.post.comments}',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          Row(
                            children: [
                             
                              const SizedBox(width: 16),
                              Icon(Icons.remove_red_eye,
                                  size: 16, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text('${widget.post.views}',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
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
      ),
    );
  }
}