import 'package:flutter/material.dart';
import 'package:social_media_ui/screens/profile_screen.dart';
import 'package:social_media_ui/screens/search_screen.dart';
import 'package:social_media_ui/widgets/custom_buttom_app_bar.dart';

import '../models/post_model.dart';
import '../widgets/custom_video_player.dart';

class HomeScreen extends StatelessWidget {
  static const routeName ='/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Post> posts = Post.posts;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _CustomeAppBar(),
      bottomNavigationBar: CustomBottomAppBar(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: posts.map((post){
            return CustomVideoPlayer(post:post);
          }).toList()
        ),
      ),
    );
  }
}




class _CustomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _bulidButton(context,'For You'),
          _bulidButton(context,'For You')

        ],
      ),
    );
  }

  TextButton _bulidButton(
      BuildContext context,
      String text,
      ) {
    return TextButton(onPressed: () {},
            style:TextButton.styleFrom(
              fixedSize: const Size(100, 50),
            ) ,
            child: Text(
              text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
