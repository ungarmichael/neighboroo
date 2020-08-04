import 'package:flutter/material.dart';
import 'package:neighboroo/constants.dart';
import 'package:neighboroo/models/Village.dart';

class NbVillage extends StatefulWidget {
  
  Village v;
  NbVillage(this.v);
  
  @override
  _NbVillageState createState() => _NbVillageState();
}

class _NbVillageState extends State<NbVillage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: box_color,
        borderRadius: BorderRadius.circular(7.0)
      ),
      
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: widget.v.getPicture(60,60)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(widget.v.name,
                  style: TextStyle(
                    color: text_color,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                                  child: Text(widget.v.description,
                    style: TextStyle(
                      color: hint_text_color,
                      fontSize: 10,
                    ),
                  ),
                )
              )
            ],
          ),
        ],
      ),

    );
  }
}