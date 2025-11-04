import 'package:flutter/material.dart';

// Dummy data for illustration
class Project {
  final String title;
  final String category;
  const Project(this.title, this.category);
}

class ProfilePage extends StatelessWidget {
  // Use 'true' for own profile, 'false' to view another user's profile
  final bool isOwnProfile;
  const ProfilePage({super.key, this.isOwnProfile = true});

  final String userName = 'CreativeCoder_99';
  final String bio =
      'Flutter developer, digital artist, and UI/UX enthusiast. Building beautiful apps with Dart.';
  final List<Project> uploadedProjects = const [
    Project('FTP Web App UI', 'Flutter'),
    Project('Animated Login Flow', 'UI/UX'),
    Project('Vector Portrait Series', 'Design'),
    Project('Data Visualization Tool', 'Data Science'),
    Project('Mobile Game Prototype', 'Game Dev'),
    Project('Abstract Art', 'Design'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isOwnProfile ? 'My Portfolio' : '$userName\'s Portfolio'),
        elevation: 4,
        actions: [
          if (isOwnProfile)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // TODO: Implement Edit Profile logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile Settings/Edit UI goes here (Req 3)'),
                  ),
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildProfileHeader(context, userName, bio, isOwnProfile),
            const Divider(height: 1, thickness: 1),
            _buildProjectsGrid(context, uploadedProjects),
          ],
        ),
      ),
    );
  }

  // Helper method for the profile header section
  Widget _buildProfileHeader(
    BuildContext context,
    String name,
    String bio,
    bool isOwnProfile,
  ) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.brush,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            '@$name',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              bio,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 20),
          if (!isOwnProfile)
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Simulating follow/message action.'),
                  ),
                );
              },
              icon: const Icon(Icons.person_add),
              label: const Text('Follow User'),
            ),
        ],
      ),
    );
  }

  // Helper method for the projects grid section
  Widget _buildProjectsGrid(BuildContext context, List<Project> projects) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine number of columns based on screen width (Responsiveness!)
        int crossAxisCount = (constraints.maxWidth / 300).floor().clamp(1, 4);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Projects (${projects.length})',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.9, // Slightly taller for title
              ),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image Placeholder
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.tertiaryContainer,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              projects[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              projects[index].category,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            // Update/Delete actions (Req 10 - only for own profile)
                            if (isOwnProfile)
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 20,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Delete action initiated.',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
