import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildStories() {
  return Container(
    height: 100.h, // Adjust height as needed
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 5, // Replace with actual number of stories
      itemBuilder: (context, index) {
        return Container(
          width: 80.w, // Adjust width as needed
          margin: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage('https://example.com/story_image.jpg'), // Replace with actual story image
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}