import 'dart:async';
import 'package:diet_fairy/presentation/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:diet_fairy/them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  // splash 적용
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 첫번째 함수에서 발생하는 모든 에러를 두번째 함수에서 처리함
  runZonedGuarded(
    () async {
      // 파이어베이스 연동
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // splash 종료
      FlutterNativeSplash.remove();

      runApp(const ProviderScope(child: MyApp()));
    },
    // 플러터 앱 내에서 발생하는 모든 에러가 이쪽으로 빠질 것임
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stack,
        fatal: true,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diet Fairy',
      theme: theme,
      home: LoginPage(),
    );
  }
}
