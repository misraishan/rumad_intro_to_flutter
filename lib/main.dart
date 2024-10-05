import 'package:flutter/material.dart';
import 'package:my_app/projects_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ProfileCard(),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'Flutter Profile App',
      'description':
          'A demo app showcasing navigation and UI design in Flutter.',
      'isPinned': false
    },
    {
      'title': 'Rutgers Research Project',
      'description':
          'Developed as part of the CS program at Rutgers University.',
      'isPinned': false
    },
    {
      'title': 'Rusty Linux',
      'description': 'Rebuilt Linux in rust.',
      'isPinned': false
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("Profile_Image.jpeg"),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Your Name",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Rutgers University",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "About Me",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              "I'm a CS student at Rutgers, and I love to code.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Icon(Icons.work, size: 28),
                    SizedBox(height: 4),
                    Text(
                      "Company",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.school, size: 28),
                    SizedBox(height: 4),
                    Text(
                      "Rutgers",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.location_on, size: 28),
                    SizedBox(height: 4),
                    Text(
                      "New Jersey",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildSocialButton(
                    Icons.code, "GitHub", "https://github.com/{your_gh_here}"),
                _buildSocialButton(Icons.work_history_outlined, "LinkedIn",
                    "https://www.linkedin.com/in/{your_linkedin_here}/")
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProjectScreen(projects: projects)),
                  );
                },
                child: const Text('View Projects'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String labelText, String url) {
    return ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(labelText),
        onPressed: () {
          launchUrl(Uri.parse(url));
        });
  }
  
}

// New Addition - Projects Screen
class ProjectScreen extends StatefulWidget {
  final List<Map<String, dynamic>> projects;
  ProjectScreen({required this.projects});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  void _addProject() async {
    final newProject = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProjectForm()),
    );
    if (newProject != null) {
      setState(() {
        widget.projects.add(newProject);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Projects")),
      body: ListView.builder(
        itemCount: widget.projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.projects[index]['title']),
            subtitle: Text(widget.projects[index]['description']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProject,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Add Project Form
// Importing the required Flutter packages

// Main widget for adding or editing a project
class AddProjectForm extends StatefulWidget {
  // Optional: If editing, the initial title and description will be passed in
  final String? initialTitle;
  final String? initialDescription;

  // Constructor allows passing in initial title and description
  AddProjectForm({this.initialTitle, this.initialDescription});

  @override
  _AddProjectFormState createState() => _AddProjectFormState();
}

// State class to handle form inputs and state changes
class _AddProjectFormState extends State<AddProjectForm> {
  // Key to keep track of the form and its state
  final _formKey = GlobalKey<FormState>();

  // Variables to store title and description entered by the user
  String? title;
  String? description;

  // When the form is first shown, we set the initial title and description (if editing)
  @override
  void initState() {
    super.initState();
    title = widget.initialTitle ?? ''; // If no initial title, set it to an empty string
    description = widget.initialDescription ?? ''; // If no initial description, set it to empty
  }

  // Building the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with dynamic title based on add/edit mode
      appBar: AppBar(
        title: Text(widget.initialTitle == null ? "Add Project" : "Edit Project"),
      ),
      // Main content of the screen
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the form
        child: Form(
          key: _formKey, // Attaching the form key to the form
          child: Column(
            children: [
              // Input field for project title
              TextFormField(
                initialValue: title, // If editing, the title will already be filled in
                decoration: const InputDecoration(labelText: "Project Title"),
                // When the form is saved, the entered value is stored in the 'title' variable
                onSaved: (value) {
                  title = value ?? '';
                },
                // Validation: Make sure the title isn't empty
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project title'; // Error message if empty
                  }
                  return null; // If everything is fine, return null (no error)
                },
              ),
              // Input field for project description
              TextFormField(
                initialValue: description, // If editing, the description will already be filled in
                decoration: const InputDecoration(labelText: "Project Description"),
                // When the form is saved, the entered value is stored in the 'description' variable
                onSaved: (value) {
                  description = value ?? '';
                },
                // Validation: Make sure the description isn't empty
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a project description'; // Error message if empty
                  }
                  return null; // If everything is fine, return null (no error)
                },
              ),
              const SizedBox(height: 20), // Some space between the form and the button

              // Button to submit the form
              ElevatedButton(
                onPressed: () {
                  // If the form passes validation
                  if (_formKey.currentState!.validate()) {
                    // Save the form data (title and description)
                    _formKey.currentState!.save();

                    // Close the form and pass back the entered title and description
                    Navigator.pop(context, {
                      'title': title,          // Send back the project title
                      'description': description, // Send back the project description
                    });
                  }
                },
                // Button text changes depending on whether adding or editing a project
                child: Text(widget.initialTitle == null ? "Add Project" : "Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
