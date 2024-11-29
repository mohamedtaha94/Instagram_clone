// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/cubits/explore_screen_cubit/explore_cubit.dart';
import 'package:hii/control/cubits/explore_screen_cubit/explore_state.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/post_screen.dart';
import 'package:hii/views/screens/profile_screen.dart';
import 'package:hii/control/util/image_cached.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExploreCubit()..loadPosts(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: ExploreView(),
        ),
      ),
    );
  }
}

class ExploreView extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreCubit = context.read<ExploreCubit>();

    return Column(
      children: [
        // Search Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Container(
            height: 36.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.black),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration:  InputDecoration(
                      hintText: S.of(context).SearchUser,
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    onChanged: (value) {
                      exploreCubit.searchUsers(value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // State Handling
        Expanded(
          child: BlocBuilder<ExploreCubit, ExploreState>(
            builder: (context, state) {
              if (state is ExploreLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ExploreShowPosts) {
                return _buildPostGrid(context, state.posts);
              } else if (state is ExploreShowUsers) {
                return _buildUserList(context, state.users);
              } else if (state is ExploreError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPostGrid(BuildContext context, List<Map<String, dynamic>> posts) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostScreen(post),
              ),
            );
          },
          child: CachedImage(post['postImage']),
        );
      },
    );
  }

  Widget _buildUserList(BuildContext context, List<Map<String, dynamic>> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfileScreen(Uid: user['id']),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 23.r,
                  backgroundImage: NetworkImage(user['profile']),
                ),
                SizedBox(width: 15.w),
                Text(user['username']),
              ],
            ),
          ),
        );
      },
    );
  }
}
