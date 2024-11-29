// ignore_for_file: prefer_final_fields, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  List<Widget> _mediaList = [];
  List<File> _fileList = [];
  int currentPage = 0;

  void fetchMedia() async {
    emit(AddPostLoading());
    try {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth) {
        final album = await PhotoManager.getAssetPathList(type: RequestType.image);
        final media = await album[0].getAssetListPaged(page: currentPage, size: 60);

        List<Widget> tempMediaList = [];
        for (var asset in media) {
          if (asset.type == AssetType.image) {
            final file = await asset.file;
            if (file != null) {
              _fileList.add(File(file.path));
            }
          }
        }

        for (var asset in media) {
          tempMediaList.add(
            FutureBuilder(
              // ignore: prefer_const_constructors
              future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // ignore: avoid_unnecessary_containers
                  return Container(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          );
        }

        _mediaList.addAll(tempMediaList);

        emit(AddPostLoaded(
          mediaList: _mediaList,
          fileList: _fileList,
          selectedFile: _fileList.isNotEmpty ? _fileList[0] : null,
          selectedIndex: 0,
        ));

        currentPage++;
      } else {
        emit(AddPostError("Permission denied to access media."));
      }
    } catch (e) {
      emit(AddPostError("Error fetching media: $e"));
    }
  }

  void selectFile(int index) {
    emit(AddPostLoaded(
      mediaList: _mediaList,
      fileList: _fileList,
      selectedFile: _fileList[index],
      selectedIndex: index,
    ));
  }
}
