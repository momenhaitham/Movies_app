import 'package:flutter/material.dart';

class CustmElevatedButton extends StatelessWidget {

  Function onpressed;
  String? text;
  TextStyle? styleOfChild;
  Color? BGcolor;
  Color? BorderColor;
  double? BorderWidth;
  double? borderRadius;

  CustmElevatedButton({
    required this.onpressed,
    this.text,
    this.styleOfChild,
    this.BGcolor,
    this.borderRadius,
    this.BorderColor,
    this.BorderWidth
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
        onPressed: (){onpressed();},
        child: Text(text??"",style: styleOfChild,),
        style: ElevatedButton.styleFrom(
          
          backgroundColor: BGcolor,
          shape:RoundedRectangleBorder(side: BorderSide(color:BorderColor??Colors.transparent,width: BorderWidth??0,),
              borderRadius:BorderRadius.circular(borderRadius??15))
        )
    );
  }
}
