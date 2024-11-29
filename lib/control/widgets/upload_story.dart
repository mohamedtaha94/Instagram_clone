import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadStory(String userId) async {
  try {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload to Firebase Storage
      final file = File(pickedFile.path);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('stories')
          .child(userId)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(file);

      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Save metadata to Firestore
      await FirebaseFirestore.instance.collection('stories').add({
        'userId': userId,
        'imageUrl': imageUrl,
        'timestamp': Timestamp.now(),
      });
    }
  } catch (e) {
    print('Failed to upload story: $e');
  }
}
