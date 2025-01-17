import 'package:flutter/material.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "forum",
          style: Theme.of(context).textTheme.displayMedium!.copyWith(),
        ),
      ),
    );
  }
}
