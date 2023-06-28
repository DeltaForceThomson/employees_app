import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_app/requestScreens/request_card.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

class ReadyScreen extends StatefulWidget {
  const ReadyScreen({Key? key}) : super(key: key);

  @override
  State<ReadyScreen> createState() => _ReadyScreenState();
}



class _ReadyScreenState extends State<ReadyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Items Ready At The Office",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where("employeeUID",isEqualTo: sharedPreferences!.getString("uid"))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, AsyncSnapshot dataSnapShot)
        {
          if(dataSnapShot.hasData)
          {
            return ListView.builder(
              itemCount: dataSnapShot.data.docs.length,
              itemBuilder: (c, index)
              {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemID", whereIn: cartMethods.separateOrderItemIDs((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["productIDs"]))
                      .where("employeeUID", whereIn: (dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot)
                  {
                    if(snapshot.hasData)
                    {
                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapShot.data.docs[index].id,
                        seperateQuantitiesList: cartMethods.separateOrderItemsQuantities((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["productIDs"]),
                      );
                    }
                    else
                    {
                      return const Center(
                        child: Text(
                          "No data exists.",
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
          else
          {
            return const Center(
              child: Text(
                "No data exists.",
              ),
            );
          }
        },
      ),
    );
  }
}
