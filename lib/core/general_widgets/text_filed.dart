import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../design/app_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title, this.validator,required this.onChange, this.textInputType, this.password=false});
  final String title;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final TextInputType? textInputType;
  final bool password;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator??(x){
        if(x!.isEmpty){
          return 'مطلوب';
        }else {
          return null;
        }
      },
      onChanged: onChange,
      style: const TextStyle(color: Styles.primary,fontSize: 25,fontWeight: FontWeight.w900),
      cursorColor: Styles.primary,
      keyboardType: textInputType??TextInputType.phone,
      obscureText: password,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.only(start: 20.w,bottom: 15.h,top: 15.h),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Styles.primary),),
        label: Styles.text(title,size: 17),
      ),
    );
  }
}
