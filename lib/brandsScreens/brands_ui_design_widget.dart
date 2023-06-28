import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employees_app/itemsScreens/items_screen.dart';
import 'package:employees_app/models/option.dart';
import 'package:employees_app/splashScreen/my_splash_screen.dart';

import '../global/global.dart';

class BrandsUiDesignWidget extends StatefulWidget
{
  Options? model;
  BuildContext? context;

  BrandsUiDesignWidget({this.model, this.context,});

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}




class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget>
{
  deleteBrand(String brandUniqueID)
  {
    FirebaseFirestore.instance
        .collection("employee")
        .doc(sharedPreferences!.getString("uid"))
        .collection("option")
        .doc(brandUniqueID)
        .delete();

    Fluttertoast.showToast(msg: "Option Deleted.");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> MySplashScreen()));
  }

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(
          model: widget.model,
        )));
      },
      child: Card(
        elevation: 20,
        shadowColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [

                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 1,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.optionTitle.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        deleteBrand(widget.model!.optionID.toString());
                      },
                      icon: const Icon(
                        Icons.delete_sweep,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
