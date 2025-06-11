import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movies_app/providers/app_provider.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatefulWidget {

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context,listen: false);
    return AnimatedToggleSwitch<int>.rolling(
      current: currentSelected,
      values: [0,1],
      iconList: [
        CountryFlag.fromCountryCode(
          'US',
          shape: const Circle(),)

        ,

        CountryFlag.fromCountryCode(
          'EG',
          shape: const Circle(),)

      ],
      onChanged: (i) {
        currentSelected = i;
        currentSelected==0?provider.ChangeLanguage(context,"en"):provider.ChangeLanguage(context,"ar");
        currentSelected==0?provider.WriteLocal("en"):provider.WriteLocal("ar");
      } ,
    );
  }
}
