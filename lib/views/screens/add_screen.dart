import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/cubits/add_screen_cubit/add_Screen_state.dart';
import 'package:hii/control/cubits/add_screen_cubit/add_screen_cubit.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/add_post_screen.dart';
import 'package:hii/views/screens/add_reels_screen.dart';




class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddScreenCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              BlocBuilder<AddScreenCubit, AddScreenState>(
                builder: (context, state) {
                  // ignore: unused_local_variable
                  int currentIndex = 0; // Default index
                  if (state is AddScreenPageChanged) {
                    currentIndex = state.currentIndex;
                  }
                  
                  return PageView(
                    onPageChanged: (page) {
                      context.read<AddScreenCubit>().changePage(page);
                    },
                    children: const [
                      AddPostScreen(),
                      AddReelsScreen(),
                    ],
                  );
                },
              ),
              BlocBuilder<AddScreenCubit, AddScreenState>(
                builder: (context, state) {
                  int currentIndex = 0; // Default index
                  if (state is AddScreenPageChanged) {
                    currentIndex = state.currentIndex;
                  }
                  
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    bottom: 10.h,
                    right: currentIndex == 0 ? 100.w : 150.w,
                    child: Container(
                      width: 120.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<AddScreenCubit>().changePage(0);
                            },
                            child: Text(
                              S.of(context).Post,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: currentIndex == 0
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AddScreenCubit>().changePage(1);
                            },
                            child: Text(
                              S.of(context).Reels,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                color: currentIndex == 1
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

int _currentIndex = 0;

class _AddScreenState extends State<AddScreen> {
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: const [
                AddPostScreen(),
                AddReelsScreen(),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 10.h,
              right: _currentIndex == 0 ? 100.w : 150.w,
              child: Container(
                width: 120.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigationTapped(0);
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationTapped(1);
                      },
                      child: Text(
                        'Reels',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              _currentIndex == 1 ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

