import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/cubits/home_cubit/home_cubit.dart';
import 'package:hii/control/cubits/home_cubit/home_state.dart';
import 'package:hii/control/firebase_Services/firestor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/widgets/posting_widget.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/UploadStoryPage%20.dart';
import 'package:hii/views/screens/activity_screen.dart';
import 'package:hii/views/screens/chatscreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Define your buildStories method to fetch and display stories
  Widget buildStories() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: Firebase_Firestor().getStories(), // Fetch stories from Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final stories = snapshot.data ?? [];
        return Container(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80.w,
                margin: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(stories[index]['imageUrl']), // Use the actual image URL
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenCubit(FirebaseFirestore.instance),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: SizedBox(
            width: 105.w,
            height: 28.h,
            child: Image.asset('images/instagram.jpg'),
          ),
          leading: IconButton(
            icon:const  Icon(Icons.camera_alt, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadStoryPage(), // Open story upload page
                ),
              );
            },
            color: Colors.black,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityScreen(), // Navigate to ActivityScreen
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            Padding(
              padding: EdgeInsets.only(right: 19.r),
              child: Image.asset('images/send.jpg'),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeScreenError) {
                return Center(child: Text(state.message));
              } else if (state is HomeScreenLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: buildStories(), // Integrate the stories widget here
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return PostWidget(state.posts[index].data());
                        },
                        childCount: state.posts.length,
                      ),
                    ),
                  ],
                );
              }
              return  Center(child: Text(S.of(context).Nopostsavailable));
            },
          ),
        ),
        floatingActionButton: Transform.translate(
          offset: Offset(-30, 0), 
          child: FloatingActionButton(
            onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      currentUserId: "_USER_ID", 
                      otherUserId: "_USER_ID", 
                      otherUserName: "Chat User",  
                    ),
                  ),
                );
              
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.chat),
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:hii/views/screens/activity_screen.dart'; // Import ActivityScreen here

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ... (other methods like buildStories remain unchanged)

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenCubit(FirebaseFirestore.instance),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: SizedBox(
            width: 105.w,
            height: 28.h,
            child: Image.asset('images/instagram.jpg'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.camera_alt, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadStoryPage(),
                ),
              );
            },
            color: Colors.black,
          ),
          actions: [
            // Favorite IconButton to navigate to ActivityScreen
            IconButton(
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActivityScreen(), // Navigate to ActivityScreen
                  ),
                );
              },
            ),
            SizedBox(width: 20.w),
            Padding(
              padding: EdgeInsets.only(right: 19.r),
              child: Image.asset('images/send.jpg'),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeScreenError) {
                return Center(child: Text(state.message));
              } else if (state is HomeScreenLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: buildStories(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return PostWidget(state.posts[index].data());
                        },
                        childCount: state.posts.length,
                      ),
                    ),
                  ],
                );
              }
              return Center(child: Text(S.of(context).Nopostsavailable));
            },
          ),
        ),
        floatingActionButton: Transform.translate(
          offset: Offset(-30, 0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    currentUserId: "_USER_ID",
                    otherUserId: "_USER_ID",
                    otherUserName: "Chat User",
                  ),
                ),
              );
            },
            backgroundColor: Colors.blue,
            child: const Icon(Icons.chat),
          ),
        ),
      ),
    );
  }
}*/


