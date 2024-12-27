import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class beta extends StatefulWidget {
  @override
  State<beta> createState() => _betaState();
}

class _betaState extends State<beta> {
  late String _name;
  late String _title;
  late String _email;
  late String _phone;
  XFile? _image; // This will hold the selected image

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initial values
    _name = '';
    _title = '';
    _email = '';
    _phone = '';

    // Initializing controllers with existing values
    _nameController.text = _name;
    _titleController.text = _title;
    _emailController.text = _email;
    _phoneController.text = _phone;
  }

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  // Function to save the changes
  void _saveChanges() {
    setState(() {
      _name = _nameController.text;
      _title = _titleController.text;
      _email = _emailController.text;
      _phone = _phoneController.text;
    });
    // Here you can integrate with your local storage or database
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Profile Page",
          style: TextStyle(color: Color(0xff8a6d3b)),
        ),
        backgroundColor: const Color(0xff524331),
        elevation: 4.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path))
                      : const AssetImage('images/3.png'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffa3865d),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xffc9c9c9),
                ),
              ),
              const SizedBox(height: 30),

              // Edit Profile Section
              Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: const Color(0xff524331),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffa3865d),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon:
                              Icon(Icons.person, color: Color(0xffa3865d)),
                          labelStyle: TextStyle(color: Color(0xffc9c9c9)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc9c9c9)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          prefixIcon:
                              Icon(Icons.work, color: Color(0xffa3865d)),
                          labelStyle: TextStyle(color: Color(0xffc9c9c9)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc9c9c9)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xffa3865d)),
                          labelStyle: TextStyle(color: Color(0xffc9c9c9)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc9c9c9)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          prefixIcon:
                              Icon(Icons.phone, color: Color(0xffa3865d)),
                          labelStyle: TextStyle(color: Color(0xffc9c9c9)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffc9c9c9)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff09020),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 40),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffa3865d),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
