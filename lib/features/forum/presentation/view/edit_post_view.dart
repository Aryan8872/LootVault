import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loot_vault/core/common/snackbar/my_snackbar.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_bloc.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_event.dart';
import 'package:loot_vault/features/forum/presentation/view_model/forum_state.dart';

class EditPostScreen extends StatefulWidget {
  final String postId;

  const EditPostScreen({super.key, required this.postId});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the post details when the screen is initialized
    context.read<ForumBloc>().add(GetPostByIdEvent(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 10,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: BlocListener<ForumBloc, ForumState>(
        listener: (context, state) {
          if (state.error != null) {
            showMySnackBar(
              context: context,
              message: 'Error: ${state.error}',
              color: Colors.red,
            );
          }
        },
        child: BlocBuilder<ForumBloc, ForumState>(
          builder: (context, state) {
            if (state.isLoading && state.singlPost == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.singlPost != null) {
              // Pre-fill the text fields with the current post data
              _titleController.text = state.singlPost!.title;
              _contentController.text = state.singlPost!.content;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Title Input Field
                    TextField(
                      controller: _titleController,
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
                      controller: _contentController,
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
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Post not found'));
            }
          },
        ),
      ),
    );
  }

  void _saveChanges() async{
    final newTitle = _titleController.text.trim();
    final newContent = _contentController.text.trim();

    if (newTitle.isNotEmpty && newContent.isNotEmpty) {
      // Dispatch an event to update the post
      context.read<ForumBloc>().add(
            EditPostEvent(
              postId: widget.postId,
              title: newTitle,
              content: newContent,
            ),
          );
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate a delay

      // Show a snackbar and pop the context after the operation is successful
      showMySnackBar(
        context: context,
        message: 'Post updated successfully',
        color: Colors.green,
      );
      Navigator.pop(
          context, true); // Return true to indicate a refresh is needed
    } else {
      showMySnackBar(
        context: context,
        message: 'Please fill in all fields',
        color: Colors.red,
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
