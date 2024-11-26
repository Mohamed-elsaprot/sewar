import 'package:alsewar/core/design/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SignUpWebView extends StatefulWidget {
  const SignUpWebView({super.key});

  @override
  State<SignUpWebView> createState() => _SignUpWebViewState();
}

class _SignUpWebViewState extends State<SignUpWebView> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (x){
            // print('NEW LINK: $x');
            // if(x.url!.contains('success')){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const SuccessScreen()));
            // }
          },
        ),
      )..loadRequest(Uri.parse('https://forly.io/d/194515'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,centerTitle: true,
        title: Styles.text('تسجيل حساب جديد'),
      ),
      body: WebViewWidget(controller: controller,),
    );
  }
}
