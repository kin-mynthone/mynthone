import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/asset_path_helper.dart';

class SlashEyeIcon extends StatelessWidget {
  const SlashEyeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPath.eyeSlash,
      height: 30,
    );
  }
}
