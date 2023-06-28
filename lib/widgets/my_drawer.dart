import 'package:employees_app/brandsScreens/home_screen.dart';
import 'package:employees_app/readyItemsScreen/ready_items.dart';
import 'package:employees_app/requestScreens/requests_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../splashScreen/my_splash_screen.dart';


class MyDrawer extends StatefulWidget
{
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}



class _MyDrawerState extends State<MyDrawer>
{
  @override
  Widget build(BuildContext context)
  {
    return Drawer(
      backgroundColor: Colors.teal,
      child: ListView(
        children: [

          //header
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 130,
                  width: 130,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),

                const SizedBox(height: 12,),

                //user name
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12,),

              ],
            ),
          ),

          //body
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [

                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //home
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white,),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=> HomeScreen()));
                  },
                ),

                //my orders

                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.request_page_outlined, color: Colors.white,),
                  title: const Text(
                    "My Requests",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=> OrdersScreen()));
                  },
                ),

                //my orders

                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.local_post_office_rounded, color: Colors.white,),
                  title: const Text(
                    "Ready At Office",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    Navigator.push(context,MaterialPageRoute(builder: (c)=> ReadyScreen()));
                  },
                ),

                //my orders

                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

                //logout
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white,),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: ()
                  {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.white,
                  thickness: 2,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
