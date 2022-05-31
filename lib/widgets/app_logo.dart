import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color color;

  const AppLogo(
      {Key? key, this.size = 100.0, this.color = const Color(0xffF1F2F6)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size,
      duration: const Duration(
        milliseconds: 750,
      ),
      curve: Curves.easeInOutCirc,
      child: SvgPicture.asset(
        'assets/app-logo.svg',
        color: color,
        width: size,
      ),
    );
  }
}