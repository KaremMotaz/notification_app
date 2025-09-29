import 'package:flutter/material.dart';

import '../theming/colors_manager.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 21,
      height: 21,
      child: CircularProgressIndicator(color: ColorsManager.white),
    );
  }
}
