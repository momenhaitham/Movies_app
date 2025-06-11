import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/screens/register_screen/register_states.dart';

import '../../Reusable_widgets/show_dialog_utils.dart';

class RegisterViewModel extends Cubit<RegisterStates>{
  RegisterViewModel():super(RegisterState());
  String? message;

  void Registe({
    required String name,
    required String email,
    required String Password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
    required BuildContext context
  })async{
    ShowDialogUtils.ShowLoading(context);
    var response =await ApiManager.Register(name: name, email: email, Password: Password, confirmPassword: confirmPassword, phone: phone, avaterId: avaterId);
    Future.delayed(Duration(seconds: 2));
    message=response.message;
    if(message=="User created successfully"){
      emit(BacktoLoginState());
    }else{

      emit(RegisterErrorState());
    }
  }
}