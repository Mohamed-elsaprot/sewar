import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/features/settings/models/Pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../const.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key, required this.page});
  final Pages page;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Styles.text(page.title??''),elevation: 0,scrolledUnderElevation: 0,backgroundColor: Colors.white,),
      // body: SingleChildScrollView(
      //   padding: EdgeInsets.all(20.sp),
      //   child: Center(
      //     child: HtmlWidget(page.content??'',
      //       // onTapUrl: (url) => print('tapped $url'),
      //       renderMode: RenderMode.column,
      //       textStyle: const TextStyle(fontFamily: fontFamily),
      //     ),
      //   ),
      // ),
    );
  }
}
