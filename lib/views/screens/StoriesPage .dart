import 'package:flutter/material.dart';
import 'package:hii/control/firebase_Services/firestor.dart';
import 'package:hii/generated/l10n.dart';

class StoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).Stories)),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Firebase_Firestor().getStories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const  Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final stories = snapshot.data ?? [];
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return Card(
                child: Column(
                  children: [
                    Image.network(story['imageUrl']),
                    Text(story['username']),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}