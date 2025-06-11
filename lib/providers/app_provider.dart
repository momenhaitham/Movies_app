import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/Api/api_manager.dart';
import 'package:movies_app/models/get_profile_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_images.dart';
import '../utils/shared_prefs.dart';

class AppProvider extends ChangeNotifier {

  String? CurrentLocal;
  String? CurrentUserTokin;
  List images = [
    AppImages.gamer1,
    AppImages.gamer2,
    AppImages.gamer3,
    AppImages.gamer4,
    AppImages.gamer5,
    AppImages.gamer6,
    AppImages.gamer7,
    AppImages.gamer8,
    AppImages.gamer9,];
  Data? ProfileData;
  int? selectedAvatar;
//==============================================================================
  void ReadTokin() async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    CurrentUserTokin = share.getString(sharedPrefs.UserTokin)??null;
    notifyListeners();
  }

  void WriteTokin(String tokin)async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    await share.setString(sharedPrefs.UserTokin, tokin);
    notifyListeners();
  }

  Future<void> GetProfileData(String Tokin)async{
   var response = await ApiManager.GetProfile(tokin: Tokin);
   ProfileData = response.data;
   selectedAvatar = ProfileData?.avaterId??0;
   notifyListeners();
  }

  //============================================================================
  void ReadLocal() async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    CurrentLocal = share.getString(sharedPrefs.LocalePref)??"en";
    notifyListeners();
  }

  void WriteLocal(String newlocal)async
  {
    SharedPreferences share= await SharedPreferences.getInstance();
    await share.setString(sharedPrefs.LocalePref, newlocal);
  }

  void ChangeLanguage(BuildContext context, String newlocal)
  {
    if(CurrentLocal==newlocal)
    {
      return;
    }
    CurrentLocal=newlocal;
    context.setLocale(Locale(newlocal));
    notifyListeners();
  }
//==============================================================================

//  void UpdateProfile({String? email,int? newAvatar,String? name, String? phone }){
//    ApiManager.UpdateProfile(tokin: CurrentUserTokin!, email: email, avaterId: newAvatar,name: name,phone: phone);
 //   notifyListeners();
 //   GetProfileData(CurrentUserTokin!);
 //   notifyListeners();
//  }

}
