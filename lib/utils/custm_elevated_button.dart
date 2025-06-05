import 'package:flutter/material.dart';

class CustmElevatedButton extends StatelessWidget {

  Function onpressed;
  String? text;
  TextStyle? styleOfChild;
  Color? BGcolor;

  CustmElevatedButton({
    required this.onpressed,
    this.text,
    this.styleOfChild,
    this.BGcolor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){onpressed();},
        child: Text(text??"",style: styleOfChild,),
        style: ElevatedButton.styleFrom(
          backgroundColor: BGcolor,
        )
    );
  }
}
