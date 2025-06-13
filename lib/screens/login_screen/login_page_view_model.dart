import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/Reusable_widgets/show_dialog_utils.dart';
import 'package:movies_app/models/login_response.dart';

import 'login_page_states.dart';

class LoginPageViewModel extends Cubit<LoginPageStates>{
  LoginPageViewModel():super(LoginPageState());

  String? message;
  String? tokin;

  void Login({required String Email,required String Password,required BuildContext context}) async
  {

    var response = await ApiManager.Login(Email: Email, Password: Password);
    if (response.message=="Success Login"){
      message=response.message;
      tokin=response.data;
      emit(GoToHomeState());
    }else{
      message=response.message;
      emit(LoginErrorState());
    }
  }
}