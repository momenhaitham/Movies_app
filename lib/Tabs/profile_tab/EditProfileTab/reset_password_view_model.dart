
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Api/api_manager.dart';
import '../../../Reusable_widgets/show_dialog_utils.dart';

class ResetPasswordViewModel extends ChangeNotifier{

  String? message;
  Future<void> ResetPassword({required BuildContext context,required String tokin,required String oldPassword,required String newPassword})async{

    var response = await ApiManager.ResetPassword(tokin: tokin,newPassword: newPassword,oldPassword: oldPassword);
    message = response.message;
    notifyListeners();
  }
}