import 'package:flutter/material.dart';



class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamer Forum',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0F1F),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'Orbitron',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
              fontFamily: 'Roboto', color: Colors.white, fontSize: 14),
          titleMedium: TextStyle(
              fontFamily: 'Roboto', color: Colors.white70, fontSize: 12),
        ),
      ),
      home: const ForumHomeScreen(),
    );
  }
}

class ForumHomeScreen extends StatefulWidget {
  const ForumHomeScreen({super.key});

  @override
  _ForumHomeScreenState createState() => _ForumHomeScreenState();
}

class _ForumHomeScreenState extends State<ForumHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Gamer Forum', style: TextStyle(fontFamily: 'Orbitron')),
        backgroundColor: const Color(0xFF0A0F1F),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      body: _selectedIndex == 0
          ? ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildPostCard(
                    'Best FPS Games 2023',
                    'Discuss the top FPS games of the year.',
                    'user123',
                    125,
                    45),
                _buildPostCard('Upcoming RPGs',
                    'What RPGs are you looking forward to?', 'gamerX', 89, 23),
                _buildPostCard(
                    'Esports News',
                    'Latest updates in the esports world.',
                    'esportsFan',
                    312,
                    67),
              ],
            )
          : const Center(
              child:
                  Text('Coming Soon', style: TextStyle(color: Colors.white))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreatePostScreen()));
        },
        backgroundColor: const Color(0xFF00FFFF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0A0F1F),
        selectedItemColor: const Color(0xFF39FF14),
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Popular'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildPostCard(
      String title, String content, String author, int upvotes, int comments) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          // Navigate to post detail screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF00FFFF),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 8.0),
                  Text(author,
                      style: const TextStyle(
                          color: Color(0xFF39FF14), fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8.0),
              Text(content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    onPressed: () {
                      // Upvote logic
                    },
                  ),
                  Text('$upvotes', style: const TextStyle(color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    onPressed: () {
                      // Downvote logic
                    },
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(Icons.comment, color: Colors.white),
                  const SizedBox(width: 8.0),
                  Text('$comments',
                      style: const TextStyle(color: Colors.white)),
                  const Spacer(),
                  const Icon(Icons.share, color: Colors.white),
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
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Create Post', style: TextStyle(fontFamily: 'Orbitron')),
        backgroundColor: const Color(0xFF0A0F1F),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: const TextStyle(color: Color(0xFF39FF14)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xFF39FF14)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: const TextStyle(color: Color(0xFF39FF14)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color(0xFF39FF14)),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle post creation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFFF),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Post',
                  style:
                      TextStyle(fontFamily: 'Orbitron', color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
