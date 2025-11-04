import 'package:flutter/material.dart';
// Import ProfilePage to enable navigation to it.
import 'profile_page.dart';
// Assuming ProfilePage is in the same directory (lib/pages/)

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> feedItems = const [
    {
      'title': 'Responsive Flutter Layout',
      'user': 'DartDev_Expert',
      'category': 'Flutter',
      'description':
          'A detailed look at using LayoutBuilder for multi-device support.',
    },
    {
      'title': '3D Concept Art Sketch',
      'user': 'DigitalArtGuru',
      'category': 'Design',
      'description': 'Created using Procreate and optimized for web viewing.',
    },
    {
      'title': 'MongoDB Schema Design for Creative Hub',
      'user': 'DB_Master',
      'category': 'Backend',
      'description': 'Optimizing data storage for scale and security.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creative Hub Feed'),
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file, color: Colors.deepPurple),
            tooltip: 'Upload Project',
            // Note: This relies on a named route '/upload' being defined in MaterialApp
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigation to /upload route (Req 4)'),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.deepPurple),
            tooltip: 'My Profile',
            // Note: This relies on a named route '/profile' being defined in MaterialApp
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(isOwnProfile: true),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Search Bar (Requirement 7 UI)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search projects, users, or categories...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.0,
                  ), // Rounded pill shape
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onSubmitted: (query) {
                // TODO: Implement actual search logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Searching for: "$query" (Req 7)')),
                );
              },
            ),
          ),
          // Projects Feed (Requirements 5 & 6 display)
          Expanded(
            child: ListView.builder(
              itemCount: feedItems.length,
              itemBuilder: (context, index) {
                final item = feedItems[index];
                return _buildFeedPost(context, item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedPost(BuildContext context, Map<String, String> item) {
    // Constrain the width of the posts on large screens for better readability
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Header
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.1),
                  child: Text(
                    item['user']![0],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                title: Text(
                  item['user']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Category: ${item['category']}'),
                trailing: TextButton(
                  onPressed: () {
                    // Navigate to view other user's profile (Req 6)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ProfilePage(isOwnProfile: false),
                      ),
                    );
                  },
                  child: const Text('View Profile'),
                ),
              ),
              // Project Title and Description
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  item['title']!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Text(item['description']!),
              ),
              // Image/Media Placeholder
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  image: DecorationImage(
                    // Placeholder image using the project title
                    image: NetworkImage(
                      'https://placehold.co/700x300/F0F8FF/333333?text=${item['title']!.replaceAll(' ', '+')}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Action Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Like action simulated.'),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Comment action simulated.'),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Share action simulated.'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Text('32 Likes • 5 Comments'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
