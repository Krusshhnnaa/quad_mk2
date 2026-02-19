import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final String _name = 'Krushna Tarde';
  final String _rollNo = '231090070';
  final String _email = 'kbtarde_b23@et.vjti.ac.in';

  bool _editingBio = false;
  String _bio = 'Meet me at the Quad';
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  void _deleteImage() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Profile Picture?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _imageFile = null);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _saveBio() {
    final text = _bioController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bio cannot be empty',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    setState(() {
      _bio = text;
      _editingBio = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = theme.scaffoldBackgroundColor;
    final tileColor = theme.cardColor;
    final iconColor = theme.colorScheme.secondary;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.secondary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          const SizedBox(height: 32),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierColor: Colors.black87,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            Center(
                              child: InteractiveViewer(
                                child: _imageFile != null
                                    ? Image.file(_imageFile!)
                                    : Icon(
                                        Icons.person_outline,
                                        size: 250,
                                        color: theme.colorScheme.onBackground
                                            .withOpacity(0.5),
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 20,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: theme.colorScheme.onBackground
                                      .withOpacity(0.7),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_circle_outline,
                                      color: theme.colorScheme.onBackground
                                          .withOpacity(0.7),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteImage();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.upload_outlined,
                                      color: theme.colorScheme.onBackground
                                          .withOpacity(0.7),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _pickImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: theme.colorScheme.onBackground.withOpacity(
                      0.1,
                    ),
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                    child: _imageFile == null
                        ? Icon(
                            Icons.account_circle,
                            size: 200,
                            color: theme.colorScheme.onBackground.withOpacity(
                              0.5,
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          ListTile(
            tileColor: tileColor,
            leading: Icon(Icons.person, color: iconColor),
            title: Text('Name', style: theme.textTheme.bodyLarge),
            subtitle: Text(_name, style: theme.textTheme.bodyMedium),
          ),
          ListTile(
            tileColor: tileColor,
            leading: Icon(Icons.confirmation_number, color: iconColor),
            title: Text('Roll No', style: theme.textTheme.bodyLarge),
            subtitle: Text(_rollNo, style: theme.textTheme.bodyMedium),
          ),
          ListTile(
            tileColor: tileColor,
            leading: Icon(Icons.email, color: iconColor),
            title: Text('Email', style: theme.textTheme.bodyLarge),
            subtitle: Text(_email, style: theme.textTheme.bodyMedium),
          ),
          ListTile(
            tileColor: tileColor,
            leading: Icon(Icons.info_outline, color: iconColor),
            title: Text('Bio', style: theme.textTheme.bodyLarge),
            subtitle: !_editingBio
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _bioController.text = _bio;
                        _editingBio = true;
                      });
                    },
                    child: Text(_bio, style: theme.textTheme.bodyMedium),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _bioController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'Enter bio',
                            hintStyle: TextStyle(
                              color: theme.colorScheme.onBackground.withOpacity(
                                0.6,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.check,
                          color: theme.colorScheme.secondary,
                        ),
                        onPressed: _saveBio,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
