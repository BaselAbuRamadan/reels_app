import 'package:flutter/material.dart';
import 'package:social_media_ui/widgets/custom_video_player_preview.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = ModalRoute.of(context)!.settings.arguments as User?;
    user = user ?? User.users[0];
    List<Post> posts = Post.posts.where((post){
      return post.user.id == user!.id;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '@${user.username}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileInformation(user : user),
            _ProfileContent(posts:posts)
          ],
        ),
      ),
    );
  }
}
class _ProfileContent extends StatelessWidget {

  const _ProfileContent({Key? key,
    required this.posts
  }) : super(key: key);

final List<Post> posts;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.white,
                tabs:[
                  Tab(icon: Icon(Icons.grid_view_rounded),),
                  Tab(icon: Icon(Icons.favorite),)
              ]
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: posts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 9/16
                      ),
                  itemBuilder: (context,index){
                        return CustomVideoPlayerPreview(
                            post: posts[index],
                        );
                  },
                  ),

                  Icon(
                      Icons.favorite,
                      color:Colors.white
                  ),
                ],
              ),
            ),

          ],
        ));
  }
}



class _ProfileInformation extends StatelessWidget {
  const _ProfileInformation({
    Key? key,
    required this.user
  }) : super(key: key);
final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(user.imagePath),

        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
              horizontal : MediaQuery.of(context).size.width*0.11),
          child: Row(
            children: [
              _buildUserInfo(context,'Following','${user.followings}'),
              _buildUserInfo(context,'Followers','${user.followers}'),
              _buildUserInfo(context,'Likes','${user.likes}'),

            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF006E),
                  fixedSize: Size(
                      MediaQuery.of(context).size.width*0.45

                  , MediaQuery.of(context).size.height*0.08
                  )
                ),
                child: Text ("Follow",
                style: Theme.of(context).textTheme.bodyLarge!.
                  copyWith(fontWeight: FontWeight.bold,color: Colors.white),
                )
            ),
            const SizedBox(width: 10,),
            ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.white,
                    fixedSize: Size(
                        MediaQuery.of(context).size.width*0.1

                        , MediaQuery.of(context).size.height*0.08
                    )
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,

                )
            )
          ],
        )
      ],
    );
  }
  Expanded _buildUserInfo(BuildContext context,
      String type,
      String value
      ) {
    return Expanded(
      child: Column(
              children: [
                Text(value,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold, color:Colors.white
                ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  type,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade200,letterSpacing: 1.5
                  ),
                )
              ],
            ),
    );
  }
}
