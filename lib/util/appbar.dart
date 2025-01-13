import 'package:flutter/material.dart';

showLogoAppbar() {
  return AppBar(
    centerTitle: true,
    title: SizedBox(
      width: 130,
      child: Image.asset('assets/logo/text-logo2.png'),
    ),
  );
}
