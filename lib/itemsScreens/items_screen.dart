import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_app/models/option.dart';
import 'package:flutter/material.dart';
import 'package:employees_app/itemsScreens/items_ui_design_widget.dart';
import 'package:employees_app/itemsScreens/upload_items_screen.dart';
import 'package:employees_app/models/items.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../global/global.dart';
import '../widgets/text_delegate_header_widget.dart';


class ItemsScreen extends StatefulWidget
{
  Options? model;

  ItemsScreen({this.model,});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}



class _ItemsScreenState extends State<ItemsScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
          "Employee",
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
              Navigator.push(context, MaterialPageRoute(builder: (c)=> UploadItemsScreen(
                model: widget.model,
              )));
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [

          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(title: "" + widget.model!.optionTitle.toString() + "'s Items"),
          ),

          //1. query
          //2. model
          //3. ui design widget

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("employee")
                .doc(sharedPreferences!.getString("uid"))
                .collection("option")
                .doc(widget.model!.optionID)
                .collection("items")
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
                    Items itemsModel = Items.fromJson(
                      dataSnapshot.data.docs[index].data() as Map<String, dynamic>,
                    );

                    return ItemsUiDesignWidget(
                      model: itemsModel,
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
                      "No items exists",
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
