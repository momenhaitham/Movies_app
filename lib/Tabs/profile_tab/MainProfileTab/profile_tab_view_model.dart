import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Tabs/profile_tab/MainProfileTab/profile_tab_states.dart';

class ProfileTabViewModel extends Cubit<ProfileTabStates>{
  ProfileTabViewModel():super(ProfileTabState());

}