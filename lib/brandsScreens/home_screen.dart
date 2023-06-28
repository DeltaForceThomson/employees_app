import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_app/push_notifications/push_notifications_system.dart';
import 'package:flutter/material.dart';
import 'package:employees_app/brandsScreens/brands_ui_design_widget.dart';
import 'package:employees_app/brandsScreens/upload_brands_screen.dart';
import 'package:employees_app/global/global.dart';
import 'package:employees_app/models/option.dart';
import 'package:employees_app/widgets/text_delegate_header_widget.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../widgets/my_drawer.dart';


class HomeScreen extends StatefulWidget
{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen>
{
  @override
  void initState()
  {
    super.initState();
    PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();

  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors:
                [
                  Colors.green,
                  Colors.green,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "DashBoard",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (c)=> UploadBrandsScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(title: " Options"),
          ),

          //1. write query
          //2  model
          //3. ui design widget

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("employee")
                .doc(sharedPreferences!.getString("uid"))
                .collection("option")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot)
            {
              if(dataSnapshot.hasData) //if brands exists
                  {
                //display brands
                return SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c)=> const StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Options optionModel = Options.fromJson(
                      dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                    );

                    return BrandsUiDesignWidget(
                      model: optionModel,
                      context: context,
                    );
                  },
                  itemCount: dataSnapshot.data.docs.length,
                );
              }
              else //if brands NOT exists
                  {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No option exists",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
