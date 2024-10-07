import 'package:flutter/material.dart';

// Add Project Form
// Importing the required Flutter packages

// Main widget for adding or editing a project
class AddProjectForm extends StatefulWidget {
  // Optional: If editing, the initial title and description will be passed in
  final String? initialTitle;
  final String? initialDescription;

  // Constructor allows passing in initial title and description
  const AddProjectForm({super.key, this.initialTitle, this.initialDescription});

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
    title = widget.initialTitle ??
        ''; // If no initial title, set it to an empty string
    description = widget.initialDescription ??
        ''; // If no initial description, set it to empty
  }

  // Building the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with dynamic title based on add/edit mode
      appBar: AppBar(
        title:
            Text(widget.initialTitle == null ? "Add Project" : "Edit Project"),
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
                initialValue:
                    title, // If editing, the title will already be filled in
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
                initialValue:
                    description, // If editing, the description will already be filled in
                decoration:
                    const InputDecoration(labelText: "Project Description"),
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
              const SizedBox(
                  height: 20), // Some space between the form and the button

              // Button to submit the form
              ElevatedButton(
                onPressed: () {
                  // If the form passes validation
                  if (_formKey.currentState!.validate()) {
                    // Save the form data (title and description)
                    _formKey.currentState!.save();

                    // Close the form and pass back the entered title and description
                    Navigator.pop(context, {
                      'title': title, // Send back the project title
                      'description':
                          description, // Send back the project description
                    });
                  }
                },
                // Button text changes depending on whether adding or editing a project
                child: Text(widget.initialTitle == null
                    ? "Add Project"
                    : "Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
