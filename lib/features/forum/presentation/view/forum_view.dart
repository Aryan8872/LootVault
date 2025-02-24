import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/app/di/di.dart';
import 'package:loot_vault/app/shared_prefs/token_shared_prefs.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_state.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForumBloc>()..add(const GetAllPostEvent()),
      child: Scaffold(
        body: BlocBuilder<ForumBloc, ForumState>(
          builder: (context, state) {
        

            if (state.isLoading && state.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.error}',
                        style: const TextStyle(color: Colors.red)),
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
                  if (state.posts.isEmpty)
                    const Expanded(
                        child: Center(child: Text('No Posts Added Yet')))
                  else
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          final post = state.posts[index];
                       
                          return _buildPostCard(
                            context,
                            post.postId ?? '',
                            post.title,
                            post.content,
                            post.postUser,
                            post.postComments?.length ?? 0,
                            post.likes ?? [],
                            post.dislikes ?? []
                          );
                        },
                      ),
                    ),
                  if (state.isLoading && state.posts.isNotEmpty)
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator()),
                  if (state.hasMore && !state.isLoading)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ForumBloc>().add(GetAllPostEvent(
                                page: state.currentPage + 1,
                                limit: 10,
                              ));
                        },
                        child: const Text('Load More'),
                      ),
                    ),
                  if (!state.hasMore && state.posts.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No more posts to load'),
                    ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ForumBloc>().add(NavigateToAddPost(
                  context: context,
                  destination: CreatePostScreen(),
                ));
          },
          backgroundColor: const Color(0xFF00FFFF),
          child: const Icon(Icons.add, color: Colors.white),
        ),
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
    List<String>dislikes,
  ) {
    final TokenSharedPrefs tokenSharedPrefs = getIt<TokenSharedPrefs>();

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author and post content
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF00FFFF),
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  const SizedBox(width: 8.0),
                  Text(author,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8.0),
              Text(content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12.0),
              // Like, dislike, and comment buttons
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      likes.contains(tokenSharedPrefs.getUserData())
                          ? Icons.thumb_up
                          : Icons.thumb_up_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      final userDataResult =
                          await tokenSharedPrefs.getUserData();
                      userDataResult.fold(
                        (failure) => print(
                            'Failed to get user data: ${failure.message}'),
                        (userData) {
                          final userId = userData['userId'];
                          if (userId != null && userId.isNotEmpty) {
                            context.read<ForumBloc>().add(LikePostEvent(
                                  postId: postId,
                                  userId: userId,
                                ));
                          } else {
                            showMySnackBar(
                              context: context,
                              message: 'Unable to like post',
                              color: Colors.red,
                            );
                          }
                        },
                      );
                    },
                  ),
                  Text('${likes.length}',
                      style: const TextStyle(color: Colors.black)),
                    const SizedBox(width: 35),

                  Text('${dislikes.length}',
                      style: const TextStyle(color: Colors.black)),
                  IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined,
                        color: Colors.black),
                    onPressed: () async {
                      final userDataResult =
                          await tokenSharedPrefs.getUserData();
                      userDataResult.fold(
                        (failure) => print(
                            'Failed to get user data: ${failure.message}'),
                        (userData) {
                          final userId = userData['userId'];
                          if (userId != null && userId.isNotEmpty) {
                            context.read<ForumBloc>().add(DisLikePostEvent(
                                  postId: postId,
                                  userId: userId,
                                ));
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
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(Icons.comment, color: Colors.black),
                  const SizedBox(width: 8.0),
                  Text('$comments',
                      style: const TextStyle(color: Colors.black)),
                  const Spacer(),
                  const Icon(Icons.share, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
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
        title: const Text('Create Post'),
        backgroundColor: const Color(0xFF00FFFF),
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

                      // Navigate back to the previous screen
                      Navigator.pop(context);
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
                backgroundColor: const Color(0xFF00FFFF),
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
