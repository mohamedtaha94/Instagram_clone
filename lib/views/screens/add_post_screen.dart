import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/cubits/add_post_cubit/add_post_cubit.dart';
import 'package:hii/control/cubits/add_post_cubit/add_post_state.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/addPost_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit()..fetchMedia(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:  Text(
            S.of(context).NewPost,
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            BlocBuilder<AddPostCubit, AddPostState>(
              builder: (context, state) {
                if (state is AddPostLoaded && state.selectedFile != null) {
                  return Center(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddPostTextScreen(state.selectedFile!),
                          ));
                        },
                        child:  Text(
                          S.of(context).Next,
                          style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              if (state is AddPostLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AddPostLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 360.h,
                        child: GridView.builder(
                          itemCount: 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) {
                            return state.mediaList[state.selectedIndex];
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 22.h,
                        color: Colors.white,
                        child: Row(
                          children:  [
                            SizedBox(width: 10.w),
                            Text(
                              S.of(context).Recent,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: state.mediaList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.read<AddPostCubit>().selectFile(index);
                            },
                            child: state.mediaList[index],
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is AddPostError) {
                return Center(child: Text(state.message));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}




/*class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final List<Widget> _mediaList = []; 
  final List<File> path = [];
  // ignore: unused_field
  File? _file;
  int currentPage = 0;
  int? lastPage;
  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> album =
          await PhotoManager.getAssetPathList(type: RequestType.image);
      List<AssetEntity> media =
          await album[0].getAssetListPaged(page: currentPage, size: 60);

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          final file = await asset.file;
          if (file != null) {
            path.add(File(file.path));
            _file = path[0];
          }
        }
      }
      List<Widget> temp = [];
      for (var asset in media) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                // ignore: curly_braces_in_flow_control_structures
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

              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchNewMedia();
  }

  int indexx = 0;

  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPostTextScreen(_file!),
                  ));
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 15.sp, color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 360.h,
                  child: GridView.builder(
                    itemCount: _mediaList.isEmpty ? _mediaList.length : 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      return _mediaList[indexx];
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 22.h,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Text(
                        'Recent',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: _mediaList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexx = index;
                          _file = path[index];
                        });
                      },
                      child: _mediaList[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
