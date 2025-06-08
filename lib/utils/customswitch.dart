import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movies_app/providers/langueprovider.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      borderRadius: 30,
      switchBorder: Border.all(color: appColors.primary, width: 2.0),
      width: 70.0,
      height: 40.0,
      value: Provider.of<LangProvider>(context).locale.languageCode == 'ar',
      onToggle: (val) {
        Provider.of<LangProvider>(
          context,
          listen: false,
        ).setLocale(val ? const Locale('ar') : const Locale('en'));
      },
      activeIcon: SvgPicture.asset(
        fit: BoxFit.fill,
        AppImages.eg,
        width: 32,
        height: 32,
      ),
      inactiveIcon: SvgPicture.asset(
        fit: BoxFit.contain,
        AppImages.us,
        width: 32,
        height: 32,
      ),
      activeColor: Colors.black,
      inactiveColor: Colors.black,
    );
  }
}
