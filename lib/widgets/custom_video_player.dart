import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../models/post_model.dart';
import '../screens/profile_screen.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    required this.post}) : super(key: key);

  final Post post;
  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = VideoPlayerController.asset(widget.post.assetPath);
   controller.initialize().then((_){
     setState(() {

     });
   });
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(controller.dataSource),
      onVisibilityChanged: (visibilityInfo){
        if(visibilityInfo.visibleFraction > 0.5){
          controller.play();
        }else{
          if(mounted){
            controller.pause();
          }
        }
      },
      child: GestureDetector(
        onTap: (){
          setState(() {
            if(controller.value.isPlaying){
              controller.play();
            }else{
              controller.pause();
            }
          });
        },
        child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(controller),
              const Positioned.fill(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black,
                        ],
                        begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0,0.2,0.8,1.0],
                        )
                      )
                  )
              ),
              _builVideoCaption(context),
              _buildVideoAction(context),

          ],
        )
        ),
      ),
    );
  }

  Align _buildVideoAction(BuildContext context) {
    return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: controller.value.size.height,
              width: MediaQuery.of(context).size.width *0.2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _VideoActions(icon:Icons.favorite,value : '11.4k'),
                    SizedBox(height: 10,),
                    _VideoActions(icon:Icons.comment,value : '1.4k'),
                    SizedBox(height: 10),
                    _VideoActions(icon:Icons.forward_rounded,value : '400'),

                  ],
                ),
              ),
            ),
          );
  }

  GestureDetector _builVideoCaption(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProfileScreen.routeName,
        arguments: widget.post.user);
      },
      child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width*0.75,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${widget.post.user.username}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.white,fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        widget.post.caption,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _VideoActions extends StatelessWidget {
  const _VideoActions({
    super.key,
    required this.icon,
    required this.value
  });
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,

          child: Ink(
            decoration: const ShapeDecoration(
                shape: CircleBorder(),
              color: Colors.black
            ),
            child: IconButton(onPressed: (){},
              color: Colors.white,
                icon: Icon(icon),

            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(value,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Colors.white,fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
