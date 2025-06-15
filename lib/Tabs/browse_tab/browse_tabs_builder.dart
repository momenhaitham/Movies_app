import 'package:flutter/material.dart';

class BrowseTabsBuilder extends StatelessWidget {
  String txt;
  bool isSelected;
  TextStyle txtStyle;
  Color BGColor;

  BrowseTabsBuilder({
    required this.txt,
    required this.isSelected,
    required this.txtStyle,
    required this.BGColor
  });


  @override
  Widget build(BuildContext context) {
    return Container(child: Column(
      children: [
        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: BGColor,
        border: Border.all(width: 2,color: Colors.amber)
        ),
        child: Text(txt,style: txtStyle,),padding: EdgeInsets.symmetric(horizontal:6),
        )

      ],
    )
    );
  }
}
