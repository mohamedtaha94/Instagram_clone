import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String currentUserId,
    required String otherUserId,
    required String message,
  }) async {
    final timestamp = DateTime.now();

    // Message data
    final messageData = {
      'senderId': currentUserId,
      'receiverId': otherUserId,
      'message': message,
      'timestamp': timestamp,
    };

    // Add message to the current user's chat sub-collection
    await _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(otherUserId)
        .collection('messages')
        .add(messageData);

    // Add message to the other user's chat sub-collection
    await _firestore
        .collection('users')
        .doc(otherUserId)
        .collection('chats')
        .doc(currentUserId)
        .collection('messages')
        .add(messageData);
  }

  Stream<List<Map<String, dynamic>>> fetchMessages({
    required String currentUserId,
    required String otherUserId,
  }) {
    return _firestore
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(otherUserId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}
