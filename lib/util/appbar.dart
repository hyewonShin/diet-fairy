import 'package:flutter/material.dart';

showLogoAppbar() {
  return AppBar(
    title: Center(
      child: SizedBox(
        width: 130,
        child: Image.asset('assets/logo/text-logo2.png'),
      ),
    ),
  );
}
