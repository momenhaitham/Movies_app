import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class ShowDialogUtils {


  static void ShowLoading(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text("Loading",style: AppStyles.bold20yellow,),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: CircularProgressIndicator(color: Colors.amber,),
      ),
        backgroundColor: appColors.Lightblack,
      );
    },barrierDismissible: false);
  }

  static void HideLoading(BuildContext context){
    Navigator.pop(context);
  }

  static void ShowMessage(
      BuildContext context,
      {required String Title, String? Content, String? PosActionName, Function? PosAction, String? NigActionName, Function? NigAction,})
  {
    List<Widget> Actions=[];
    if(PosActionName!=null){
      Actions.add(TextButton(onPressed: (){
        PosAction==null?Navigator.pop(context):PosAction.call();
        }, child:Text(PosActionName,style: AppStyles.bold20yellow,)));
    }
    if(NigActionName!=null){
      Actions.add(TextButton(onPressed: (){
        NigAction==null?Navigator.pop(context):NigAction.call();
      }, child:Text(NigActionName,style: AppStyles.bold20yellow,)));
    }
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text(Title,style: AppStyles.bold20yellow,),
        content: Text(Content??'',style: AppStyles.bold20yellow,),
        actions: Actions,
        backgroundColor: appColors.Lightblack,
      );
    });

  }




}