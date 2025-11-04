import 'package:flutter/material.dart';

class UploadProjectPage extends StatefulWidget {
  const UploadProjectPage({super.key});

  @override
  State<UploadProjectPage> createState() => _UploadProjectPageState();
}

class _UploadProjectPageState extends State<UploadProjectPage> {
  // Simple state to simulate file selection
  String? uploadedFileName;

  void _pickMediaFile() {
    // In a real app, this would open a file picker dialog (using file_picker package)
    setState(() {
      uploadedFileName = 'Creative_Concept_Final.png'; // Mock file name
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('File selected: $uploadedFileName')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share Your Creativity'), elevation: 4),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ), // Max width for content area
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Upload New Project',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Project Title',
                    hintText: 'e.g., Responsive Flutter Portfolio Site',
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText:
                        'Describe your process, tools used, and inspiration.',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 7,
                ),
                const SizedBox(height: 30),

                // --- Media Upload Section (Requirement 4) ---
                Text(
                  'Media Files (Image or Video)',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickMediaFile,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: uploadedFileName == null
                          ? Colors.grey[100]
                          : Colors.green[50],
                      border: Border.all(
                        color: uploadedFileName == null
                            ? Colors.grey
                            : Colors.green,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: uploadedFileName == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.cloud_upload,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Click to select files',
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const Text(
                                  'Supports PNG, JPG, MP4, etc.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 50,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'File Uploaded: $uploadedFileName',
                                  style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Final API call to save project data
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'Publish Project',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
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
