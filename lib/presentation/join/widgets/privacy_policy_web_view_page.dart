import 'package:diet_fairy/util/appbar.dart';
import 'package:diet_fairy/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyWebViewPage extends StatefulWidget {
  @override
  State<PrivacyPolicyWebViewPage> createState() =>
      _PrivacyPolicyWebViewPageState();
}

class _PrivacyPolicyWebViewPageState extends State<PrivacyPolicyWebViewPage> {
  String pdfPath =
      'https://www.notion.so/17b2be659105807f8ea0ce6728e23caa?pvs=4';
  WebViewController? _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setOnJavaScriptAlertDialog(
        (request) async => await customCupertinoDialog(
            context: context, title: null, content: request.message),
      )
      ..setOnJavaScriptConfirmDialog(
        (request) async {
          await customCupertinoDialog(
              context: context, title: null, content: request.message);
          return true;
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            print('onProgress => $progress');
          },
          onHttpError: (error) {
            print('onHttpError => ${error.response!.statusCode}');
          },
          onWebResourceError: (error) {
            print('onWebResourceError => ${error.description}');
          },
        ),
      )
      ..loadRequest(
        Uri.parse(pdfPath),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showLogoAppbar(),
      body: WebViewWidget(
        controller: _controller!,
      ),
    );
  }
}
