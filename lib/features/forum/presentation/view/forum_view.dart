import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/forum/domain/entity/comment_entity.dart';
import 'package:loot_vault/features/forum/domain/entity/post_entity.dart';
import 'package:loot_vault/features/forum/presentation/view/edit_post_view.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_state.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ForumBloc>().add(const GetAllPostEvent());
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        centerTitle: true,
      ),
      body: BlocListener<ForumBloc, ForumState>(
        listenWhen: (previous, current) => previous.posts != current.posts,
        listener: (context, state) {},
        child: BlocBuilder<ForumBloc, ForumState>(
          builder: (context, state) {
            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.error}',
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context
                          .read<ForumBloc>()
                          .add(const GetAllPostEvent()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  state.posts.isEmpty
                      ? const Expanded(
                          child: Center(
                              child: Text('No Posts Added Yet',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))))
                      : Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: state.posts.length,
                            itemBuilder: (context, index) {
                              print("state ko post comment");
                              print(state.posts[index]);
                              final post = state.posts[index];
                              return _buildPostCard(
                                  context,
                                  post.postId ?? '',
                                  post.title,
                                  post.content,
                                  post.postUsername??'Anonymous',
                                  post.postComments?.length ?? 0,
                                  post.likes ?? [],
                                  post.dislikes ?? []);
                            },
                          ),
                        ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => getIt<ForumBloc>(),
                child: CreatePostScreen(),
              ),
            ),
          );
          if (shouldRefresh == true) {
            context.read<ForumBloc>().add(const GetAllPostEvent());
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPostCard(
    BuildContext context,
    String postId,
    String title,
    String content,
    String author,
    int comments,
    List<String> likes,
    List<String> dislikes,
  ) {
    final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

    return FutureBuilder(
      future: tokenSharedPrefs.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userData = snapshot.data;
          final userId =
              userData?.fold((failure) => '', (data) => data['userId'] ?? '');

          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 5,
            shadowColor: Colors.deepPurple.withOpacity(0.2),
            child: InkWell(
              borderRadius: BorderRadius.circular(12.0),
              onTap: () async {
                final shouldRefresh = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: getIt<ForumBloc>()
                        ..add(const GetAllPostEvent())
                        ..add(GetCommentsEvent(postId: postId)),
                      child: PostDetailScreen(
                        postId: postId,
                        title: title,
                        content: content,
                        author: author,
                        comments: comments,
                        likes: likes,
                        dislikes: dislikes,
                      ),
                    ),
                  ),
                );
                if (shouldRefresh == true) {
                  context.read<ForumBloc>().add(const GetAllPostEvent());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 8.0),
                        Text(author,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const Spacer(),
                        if (author ==
                            userId) // Show option button only if the post belongs to the current user
                          IconButton(
                            icon: const Icon(Icons.more_vert,
                                color: Colors.deepPurple),
                            onPressed: () {
                              _showPostOptions(context, postId);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Text(content,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            likes.contains(userId)
                                ? Icons.thumb_up
                                : Icons.thumb_up_outlined,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            if (userId!.isNotEmpty) {
                              context.read<ForumBloc>().add(LikePostEvent(
                                  postId: postId, userId: userId));
                            } else {
                              showMySnackBar(
                                  context: context,
                                  message: 'Unable to like post',
                                  color: Colors.red);
                            }
                          },
                        ),
                        Text('${likes.length}',
                            style: const TextStyle(color: Colors.deepPurple)),
                        const SizedBox(width: 35),
                        Text('${dislikes.length}',
                            style: const TextStyle(color: Colors.deepPurple)),
                        IconButton(
                          icon: const Icon(Icons.thumb_down_alt_outlined,
                              color: Colors.deepPurple),
                          onPressed: () async {
                            if (userId!.isNotEmpty) {
                              context.read<ForumBloc>().add(DisLikePostEvent(
                                  postId: postId, userId: userId));
                            } else {
                              showMySnackBar(
                                  context: context,
                                  message: 'Unable to dislike post',
                                  color: Colors.red);
                            }
                          },
                        ),
                        const SizedBox(width: 16.0),
                        const Icon(Icons.comment, color: Colors.deepPurple),
                        const SizedBox(width: 8.0),
                        Text('$comments',
                            style: const TextStyle(color: Colors.deepPurple)),
                        const Spacer(),
                        const Icon(Icons.share, color: Colors.deepPurple),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _showPostOptions(BuildContext context, String postId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.deepPurple),
              title: const Text('Edit Post'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _navigateToEditPostScreen(context, postId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Post'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _deletePost(context, postId);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToEditPostScreen(BuildContext context, String postId) {
    // Navigate to the edit post screen
    // You can implement this based on your app's navigation structure
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: getIt<ForumBloc>(),
          child: EditPostScreen(postId: postId),
        ),
      ),
    );
    context.read<ForumBloc>().add(const GetAllPostEvent());
  }

  void _deletePost(BuildContext context, String postId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                getIt<ForumBloc>().add(DeletePostEvent(postId: postId));
                Navigator.pop(context); // Close the dialog
                showMySnackBar(
                  context: context,
                  message: 'Post deleted successfully',
                  color: Colors.green,
                );
                context.read<ForumBloc>().add(const GetAllPostEvent());
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final String postId;
  final String title;
  final String content;
  final String author;
  final int comments;
  final List<String> likes;
  final List<String> dislikes;

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.title,
    required this.content,
    required this.author,
    required this.comments,
    required this.likes,
    required this.dislikes,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text('Post Details', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          elevation: 10,
          centerTitle: true,
        ),
        body: BlocBuilder<ForumBloc, ForumState>(
          builder: (context, state) {
            final post = state.posts.firstWhere((post) => post.postId == postId,
                orElse: () =>
                    const PostEntity(postUser: '', title: '', content: ''));

            if (post.postUser == '') {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPostHeader(),
                        _buildPostContent(),
                        _buildPostActions(
                            context,
                            post.likes!.length.toString(),
                            post.dislikes!.length.toString()),
                        const SizedBox(height: 20),
                        const Text('Comments',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        _buildCommentSection(state.comments),
                      ],
                    ),
                  ),
                ),
                _buildCommentInput(context, commentController),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 8.0),
        Text(author,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(content, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildPostActions(
      BuildContext context, String likes, String dislikes) {
    return Row(
      children: [
        _buildLikeButton(context),
        Text(likes),
        const SizedBox(width: 35),
        Text(dislikes),
        _buildDislikeButton(context),
        const SizedBox(width: 16.0),
        const Icon(Icons.comment, color: Colors.deepPurple),
        const SizedBox(width: 8.0),
        Text('$comments', style: const TextStyle(color: Colors.deepPurple)),
        const Spacer(),
        const Icon(Icons.share, color: Colors.deepPurple),
      ],
    );
  }

  Widget _buildLikeButton(BuildContext context) {
    final userId = getIt<TokenSharedPrefs>().getUserData().toString();
    final isLiked = likes.contains(userId);
    return IconButton(
        icon: Icon(isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
            color: Colors.deepPurple),
        onPressed: () async {
          final userDataResult = await getIt<TokenSharedPrefs>().getUserData();
          userDataResult.fold(
            (failure) => print('Failed to get user data: ${failure.message}'),
            (userData) {
              final userId = userData['userId'];
              if (userId != null && userId.isNotEmpty) {
                context
                    .read<ForumBloc>()
                    .add(LikePostEvent(postId: postId, userId: userId));
              } else {
                showMySnackBar(
                  context: context,
                  message: 'Unable to like post',
                  color: Colors.red,
                );
              }
            },
          );
        });
  }

  Widget _buildDislikeButton(BuildContext context) {
    final userId = getIt<TokenSharedPrefs>().getUserData;
    final isDisliked = dislikes.contains(userId);
    return IconButton(
      icon: Icon(isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
          color: Colors.deepPurple),
      onPressed: () async {
        final userDataResult = await getIt<TokenSharedPrefs>().getUserData();
        userDataResult.fold(
          (failure) => print('Failed to get user data: ${failure.message}'),
          (userData) {
            final userId = userData['userId'];
            if (userId != null && userId.isNotEmpty) {
              context
                  .read<ForumBloc>()
                  .add(DisLikePostEvent(postId: postId, userId: userId));
            } else {
              showMySnackBar(
                context: context,
                message: 'Unable to dislike post',
                color: Colors.red,
              );
            }
          },
        );
      },
    );
  }

  // ListView to display the comments
  Widget _buildCommentSection(List<CommentEntity> comments) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) => ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(comments[index].commentUser),
        subtitle: Text(comments[index].content),
      ),
    );
  }

  // Input section to write a new comment
  Widget _buildCommentInput(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Write a comment...'),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.deepPurple),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final userDataResult =
                    await getIt<TokenSharedPrefs>().getUserData();
                userDataResult.fold(
                  (failure) =>
                      print('Failed to get user data: ${failure.message}'),
                  (userData) {
                    final userId = userData['userId'];
                    if (userId != null && userId.isNotEmpty) {
                      context.read<ForumBloc>().add(CreateCommentEvent(
                            postId: postId,
                            userId: userId,
                            comment: controller.text,
                          ));
                      context
                          .read<ForumBloc>()
                          .add(GetCommentsEvent(postId: postId));
                    } else {
                      showMySnackBar(
                          context: context,
                          message: 'Unable to like post',
                          color: Colors.red);
                    }
                  },
                );

                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class CreatePostScreen extends StatelessWidget {
  final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title Input Field
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),

            // Content Input Field
            TextField(
              maxLines: 5,
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),

            // Post Button
            ElevatedButton(
              onPressed: () async {
                // Get user data from shared preferences
                final userDataResult = await tokenSharedPrefs.getUserData();
                userDataResult.fold(
                  (failure) {
                    // Handle failure to get user data
                    showMySnackBar(
                      context: context,
                      message: 'Failed to get user data: ${failure.message}',
                      color: Colors.red,
                    );
                  },
                  (userData) {
                    final userId = userData['userId'];
                    if (userId != null &&
                        userId.isNotEmpty &&
                        titleController.text.isNotEmpty &&
                        contentController.text.isNotEmpty) {
                      // Dispatch CreatePostEvent to the ForumBloc
                      context.read<ForumBloc>().add(
                            CreatePostEvent(
                              postUser: userId,
                              title: titleController.text,
                              content: contentController.text,
                            ),
                          );

                      showMySnackBar(
                        context: context,
                        message: 'Successfully created post',
                        color: Colors.green,
                      );

                      // Navigate back to the previous screen
                      Navigator.pop(context, true);
                    } else {
                      // Show error if fields are empty or user data is invalid
                      showMySnackBar(
                        context: context,
                        message: 'Please fill in all fields',
                        color: Colors.red,
                      );
                    }
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
