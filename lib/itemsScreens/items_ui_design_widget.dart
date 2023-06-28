import 'package:flutter/material.dart';
import 'package:employees_app/itemsScreens/items_details_screen.dart';
import 'package:employees_app/models/items.dart';

class ItemsUiDesignWidget extends StatefulWidget
{
  Items? model;
  BuildContext? context;

  ItemsUiDesignWidget({this.model, this.context,});

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}




class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget>
{
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsDetailsScreen(
          model: widget.model,
        )));
      },
      child: Card(
        elevation: 20,
        shadowColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: 280,
            width: MediaQuery.of(context).size.width*2,
            child: Column(
              children: [

                const SizedBox(height: 2,),

                Text(
                  widget.model!.itemTitle.toString(),
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 2,),

                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 4,),

                Text(
                  widget.model!.itemInfo.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
