import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hii/control/firebase_Services/storage.dart';
import 'package:hii/control/firebase_Services/firestor.dart';

class UploadStoryPage extends StatefulWidget {
  @override
  _UploadStoryPageState createState() => _UploadStoryPageState();
}

class _UploadStoryPageState extends State<UploadStoryPage> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadStory() async {
    if (_image != null) {
      String downloadUrl = await StorageMethod().uploadImageToStorage('Stories', _image!);
      String username = 'Your Username Here'; // Replace with the actual username logic

      final success = await Firebase_Firestor().createStory(
        imageUrl: downloadUrl,
        username: username,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Story uploaded!')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Story'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 200),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadStory,
              child: Text('Upload Story'),
            ),
          ],
        ),
      ),
    );
  }
} 