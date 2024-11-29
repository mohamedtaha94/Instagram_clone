import 'package:flutter/material.dart';
import 'dart:io';

abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostLoaded extends AddPostState {
  final List<Widget> mediaList;
  final List<File> fileList;
  final File? selectedFile;
  final int selectedIndex;

  AddPostLoaded({
    required this.mediaList,
    required this.fileList,
    this.selectedFile,
    required this.selectedIndex,
  });
}

class AddPostError extends AddPostState {
  final String message;

  AddPostError(this.message);
}
