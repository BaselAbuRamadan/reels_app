import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black ,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, HomeScreen.routeName);

                },
                icon: Icon(Icons.home),
                iconSize: 30,
                color: Colors.white
            ),
            IconButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, SearchScreen.routeName);
                },
                icon: Icon(Icons.search),
                iconSize: 30,

                color: Colors.white
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.add_circle),
                iconSize: 30,

                color: Colors.white
            ),
            IconButton(
                onPressed: (){},
                icon: Icon(Icons.message),
                iconSize: 30,

                color: Colors.white
            ),
            IconButton(
                onPressed: (){
                  Navigator.popAndPushNamed(context, ProfileScreen.routeName);

                },
                icon: Icon(Icons.person),
                iconSize: 30,

                color: Colors.white
            ),
          ],
        ),
      ),
    );
  }
}
