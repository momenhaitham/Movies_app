import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Api/api_manager.dart';
import '../../../Reusable_widgets/show_dialog_utils.dart';

class EditProfileViewModel extends ChangeNotifier{

  String? message;
  Future<void> UpdateProfile({required String tokin, String? email,int? newAvatar,String? name, String? phone,required BuildContext context})async{
    notifyListeners();
    ShowDialogUtils.ShowLoading(context);
    var response = await ApiManager.UpdateProfile(tokin: tokin, email: email, avaterId: newAvatar,name: name,phone: phone);
    message = response.message;
    notifyListeners();
    ShowDialogUtils.HideLoading(context);
    if(message=="email must be an email"){
      ShowDialogUtils.ShowMessage(context, Title: "Error",
          Content: message,
          NigActionName: "Ok"
      );
    }else{
      ShowDialogUtils.ShowMessage(context, Title: "Profile Updated Sccessfully",
          Content: message,
          NigActionName: "Ok"
      );
    }
    notifyListeners();
  }
}