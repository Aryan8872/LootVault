// profile_screen.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loot_vault/features/forum/presentation/view/post_detail_view.dart';


class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<User> user;
  late Future<List<Post>> userPosts;
  late Future<List<Post>> savedPosts;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
    userPosts = fetchUserPosts();
    savedPosts = fetchSavedPosts();
  }

  Future<User> fetchUser() async {
    final response =
        await http.get(Uri.parse('YOUR_API_URL/users/${widget.userId}'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<Post>> fetchUserPosts() async {
    final response =
        await http.get(Uri.parse('YOUR_API_URL/users/${widget.userId}/posts'));
    if (response.statusCode == 200) {
      List<dynamic> postsJson = json.decode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user posts');
    }
  }

  Future<List<Post>> fetchSavedPosts() async {
    final response = await http
        .get(Uri.parse('YOUR_API_URL/users/${widget.userId}/saved-posts'));
    if (response.statusCode == 200) {
      List<dynamic> postsJson = json.decode(response.body);
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load saved posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(snapshot.data!.avatar),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            snapshot.data!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                snapshot.data!.location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.bio,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard('Posts', snapshot.data!.posts),
                            _buildStatCard(
                                'Replies', snapshot.data!.postReplies),
                            _buildStatCard('Votes', snapshot.data!.votes),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.blue,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: 'Recent Post'),
                            Tab(text: 'Saved Post'),
                          ],
                        ),
                        SizedBox(
                          height: 500, // Adjust height as needed
                          child: TabBarView(
                            children: [
                              _buildPostsList(userPosts),
                              _buildPostsList(savedPosts),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildStatCard(String label, int value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // profile_screen.dart (continued)

  Widget _buildPostsList(Future<List<Post>> posts) {
    return FutureBuilder<List<Post>>(
      future: posts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data![index].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        snapshot.data![index].content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.thumb_up_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text('${snapshot.data![index].votes}'),
                              const SizedBox(width: 16),
                              const Icon(Icons.comment_outlined, size: 16),
                              const SizedBox(width: 4),
                              Text('${snapshot.data![index].replies}'),
                              const SizedBox(width: 16),
                              const Icon(Icons.remove_red_eye_outlined,
                                  size: 16),
                              const SizedBox(width: 4),
                              Text('${snapshot.data![index].views}'),
                            ],
                          ),
                          Text(
                            snapshot.data![index].timeAgo,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      if (snapshot.data![index].tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: snapshot.data![index].tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor: Colors.blue.withOpacity(0.1),
                              labelStyle: const TextStyle(color: Colors.blue),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

// Add this to your _ProfileScreenState class
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Add this method to handle post interactions
  void _handlePostAction(String action, Post post) {
    switch (action) {
      case 'like':
        // Implement like functionality
        break;
      case 'comment':
        // Navigate to comment section
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailScreen(postId: post.id),
          ),
        );
        break;
      case 'share':
        // Implement share functionality
        break;
      case 'save':
        // Implement save functionality
        break;
    }
  }

// Add this method to refresh the profile data
  Future<void> _refreshProfile() async {
    setState(() {
      user = fetchUser();
      userPosts = fetchUserPosts();
      savedPosts = fetchSavedPosts();
    });
  }

// Add this method to handle editing profile
  void _editProfile() {
    // Navigate to edit profile screen
    // Implement the navigation and edit functionality
  }

// Add this method to handle following/unfollowing
  void _toggleFollow() async {
    // Implement follow/unfollow functionality
    try {
      final response = await http.post(
        Uri.parse('YOUR_API_URL/users/${widget.userId}/follow'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Refresh the profile data
        _refreshProfile();
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update follow status')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

// Add this method to handle reporting a user
  void _reportUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Why are you reporting this user?'),
            SizedBox(height: 16),
            // Add report options here
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement report submission
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
