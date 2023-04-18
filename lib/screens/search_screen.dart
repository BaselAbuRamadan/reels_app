import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_ui/screens/profile_screen.dart';
import 'package:social_media_ui/widgets/custom_buttom_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/user_model.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> users = User.users;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Discover",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: MasonryGridView.count(


            shrinkWrap: true,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            padding: EdgeInsets.all(0),
            itemCount: users.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProfileScreen.routeName,
                      arguments: users[index]);
                },
                child: Stack(

                  children: [
                    Container(
                      height: (index == 0) ? 250 : 300,
                      decoration: BoxDecoration(

                        color: Colors.black,
                          image: DecorationImage(
                        image: AssetImage(users[index].imagePath),
                        fit: BoxFit.cover,
                      )),
                    ),
                    const Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          // color: Colors.black,
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black],
                                begin: (Alignment.center),
                                end: Alignment.bottomCenter,
                                stops: [0.4, 1.0])),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(users[index].imagePath),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index].username,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "2 min ago",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
