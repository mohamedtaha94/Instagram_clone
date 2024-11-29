import 'package:flutter/material.dart';
import 'package:hii/generated/l10n.dart';

class StoryDetailPage extends StatelessWidget {
  final String imageUrl; // URL of the story image
  final String description; // Description or any additional info

  const StoryDetailPage({
    Key? key,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).StoryDetail),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              description,
              style:const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}