// ignore_for_file: prefer_const_constructors, duplicate_ignore, file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/addpost_screen_cubit/addpost_text_cubit.dart';
import 'package:hii/control/cubits/addpost_screen_cubit/addpsot_text_state.dart';
import 'package:hii/generated/l10n.dart';



class AddPostTextScreen extends StatelessWidget {
  final File _file;

  const AddPostTextScreen(this._file, {super.key});

  @override
  Widget build(BuildContext context) {
    final captionController = TextEditingController();
    final locationController = TextEditingController();

    return BlocProvider(
      create: (_) => AddPostCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(S.of(context).Addnewpost, style: TextStyle(color: Colors.black)),
          centerTitle: false,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: GestureDetector(
                  onTap: () {
                    final caption = captionController.text;
                    final location = locationController.text;
                    context.read<AddPostCubit>().createPost(_file, caption, location);
                  },
                  child: Text(
                    S.of(context).Share,
                    style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<AddPostCubit, AddPostState>(
            listener: (context, state) {
              if (state is AddPostSuccess) {
                Navigator.of(context).pop(); // Close the screen on success
              } else if (state is AddPostError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is AddPostLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        child: Row(
                          children: [
                            Container(
                              width: 65.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  image: FileImage(_file),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 265.w,
                              height: 60.h,
                              child: TextField(
                                controller: captionController,
                                decoration:  InputDecoration(
                                  hintText: '${S.of(context).Writeacaption} ...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          width: 275.w,
                          height: 30.h,
                          child: TextField(
                            controller: locationController,
                            decoration:  InputDecoration(
                              hintText: S.of(context).Addlocation,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
/*// ignore: must_be_immutable
class AddPostTextScreen extends StatefulWidget {
  File _file;
  AddPostTextScreen(this._file, {super.key});

  @override
  State<AddPostTextScreen> createState() => _AddPostTextScreenState();
}

class _AddPostTextScreenState extends State<AddPostTextScreen> {
  final caption = TextEditingController();
  final location = TextEditingController();
  bool islooding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("New Post", style: TextStyle(color: Colors.black)).tr(),
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    islooding = true;
                  });
                  String post_url = await StorageMethod()
                      .uploadImageToStorage('post', widget._file);
                  await Firebase_Firestor().CreatePost(
                    postImage: post_url,
                    caption: caption.text,
                    location: location.text,
                  );
                  setState(() {
                    islooding = false;
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Share',
                  style: TextStyle(color: Colors.blue, fontSize: 15.sp),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: islooding
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        child: Row(
                          children: [
                            Container(
                              width: 65.w,
                              height: 65.h,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                image: DecorationImage(
                                  image: FileImage(widget._file),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 265.w,
                              height: 60.h,
                              child: TextField(
                                controller: caption,
                                decoration: const InputDecoration(
                                  hintText: 'Write a caption ...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: SizedBox(
                          width: 275.w,
                          height: 30.h,
                          child: TextField(
                            controller: location,
                            decoration: const InputDecoration(
                              hintText: 'Add location',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}*/
