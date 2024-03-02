import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/asset_path_helper.dart';

class EyeIcon extends StatelessWidget {
  const EyeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPath.eye,
      height: 30,
    );
  }
}
