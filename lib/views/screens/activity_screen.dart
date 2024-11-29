import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ActivityScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchActivities() async {
    try {
      final userId = _auth.currentUser!.uid;
      QuerySnapshot snapshot = await _firestore
          .collection('activities')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print('Error fetching activities: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final activities = snapshot.data ?? [];

          if (activities.isEmpty) {
            return Center(child: Text('No recent activity.'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ActivityItem(
                profileImage: activity['profileImage'] ?? 'assets/images/default_avatar.jpg',
                message: activity['message'] ?? 'Activity detail not available',
                time: formatTimestamp(activity['timestamp']),
                previewImage: activity['previewImage'], // Optional image
                isComment: activity['type'] == 'comment',
              );
            },
          );
        },
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}

class ActivityItem extends StatelessWidget {
  final String profileImage;
  final String message;
  final String time;
  final String? previewImage;
  final bool isComment;

  const ActivityItem({
    required this.profileImage,
    required this.message,
    required this.time,
    this.previewImage,
    this.isComment = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profileImage),
      ),
      title: Text.rich(
        TextSpan(
          text: message,
          style: TextStyle(fontSize: 14),
        ),
      ),
      subtitle: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: previewImage != null
          ? Image.network(previewImage!, width: 50, height: 50, fit: BoxFit.cover)
          : null,
    );
  }
}


/*class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          SectionTitle(title: 'Follow Requests'),
          SectionTitle(title: 'New'),
          ActivityItem(
            profileImage: 'assets/images/karen.jpg', // Replace with your asset path
            message: 'karennne liked your photo.',
            time: '1h',
            previewImage: 'assets/images/photo1.jpg',
          ),
          SectionTitle(title: 'Today'),
          ActivityItem(
            profileImage: 'assets/images/kiero.jpg',
            message: 'kiero_d, zackjohn, and 26 others liked your photo.',
            time: '3h',
            previewImage: 'assets/images/photo1.jpg',
          ),
          SectionTitle(title: 'This Week'),
          ActivityItem(
            profileImage: 'assets/images/craig.jpg',
            message: 'craig_love mentioned you in a comment: "@jacob_w exactly.."',
            time: '2d',
            previewImage: 'assets/images/photo2.jpg',
            isComment: true,
          ),
          FollowItem(profileImage: 'assets/images/martini.jpg', name: 'martini_rond', time: '3d'),
          FollowItem(profileImage: 'assets/images/max.jpg', name: 'maxjacobson', time: '3d'),
          FollowItem(profileImage: 'assets/images/mis.jpg', name: 'mis_potter', time: '3d', showFollowButton: true),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String profileImage;
  final String message;
  final String time;
  final String? previewImage;
  final bool isComment;

  const ActivityItem({
    required this.profileImage,
    required this.message,
    required this.time,
    this.previewImage,
    this.isComment = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
      ),
      title: Text.rich(
        TextSpan(
          text: message,
          style: TextStyle(fontSize: 14),
        ),
      ),
      subtitle: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: previewImage != null
          ? Image.asset(previewImage!, width: 50, height: 50, fit: BoxFit.cover)
          : null,
    );
  }
}

class FollowItem extends StatelessWidget {
  final String profileImage;
  final String name;
  final String time;
  final bool showFollowButton;

  const FollowItem({
    required this.profileImage,
    required this.name,
    required this.time,
    this.showFollowButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImage),
      ),
      title: Text(name),
      subtitle: Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
      trailing: showFollowButton
          ? TextButton(
              onPressed: () {},
              child: Text('Follow'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
              ),
            )
          : TextButton(
              onPressed: () {},
              child: Text('Message'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
    );
  }
}*/