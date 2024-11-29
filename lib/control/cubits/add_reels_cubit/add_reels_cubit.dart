/*import 'package:bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'add_reels_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddReelsCubit extends Cubit<AddReelsState> {
  AddReelsCubit() : super(AddReelsInitial());

  int currentPage = 0;

  Future<void> fetchNewMedia() async {
    emit(AddReelsLoading());
    List<Widget> mediaList = [];
    List<File> paths = [];
    
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      try {
        List<AssetPathEntity> album = await PhotoManager.getAssetPathList(type: RequestType.video);
        List<AssetEntity> media = await album[0].getAssetListPaged(page: currentPage, size: 60);

        for (var asset in media) {
          if (asset.type == AssetType.video) {
            final file = await asset.file;
            if (file != null) {
              paths.add(File(file.path));
              mediaList.add(
                FutureBuilder(
                  future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: Container(
                                alignment: Alignment.center,
                                width: 35.w,
                                height: 15.h,
                                child: Row(
                                  children: [
                                    Text(
                                      asset.videoDuration.inMinutes.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      ':',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      asset.videoDuration.inSeconds.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              );
            }
          }
        }
        emit(AddReelsLoaded(mediaList: mediaList, paths: paths));
        currentPage++;
      } catch (e) {
        emit(AddReelsError(e.toString()));
      }
    } else {
      emit(AddReelsError('Permission denied'));
    }
  }
}*/