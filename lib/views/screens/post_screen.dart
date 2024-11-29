import 'package:flutter/material.dart';
import 'package:hii/control/cubits/post_screen_cubit/post_screen_cubit.dart';
import 'package:hii/control/cubits/post_screen_cubit/post_screen_state.dart';
import 'package:hii/control/widgets/posting_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/generated/l10n.dart';


class PostScreen extends StatelessWidget {
  final dynamic snapshot;

  const PostScreen(this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostScreenCubit()..loadPost(snapshot),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<PostScreenCubit, PostScreenState>(
            builder: (context, state) {
              if (state is PostScreenLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PostScreenError) {
                return Center(child: Text(state.message));
              } else if (state is PostScreenLoaded) {
                return PostWidget(state.postData);
              }
              return Center(child: Text(S.of(context).Nopostdataavailable));
            },
          ),
        ),
      ),
    );
  }
}

