import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final bool? lineThrough;
  final FontWeight? fontWeight;
  final int? maxLines;
  final String? fontFamily;
  final double height;

  const CustomText(this.text,
      {super.key,
      this.fontSize,
      this.textAlign,
      this.color,
      this.height = 1.2,
      this.fontWeight,
      this.lineThrough = false,
      this.maxLines = 2,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'استبدل هذا النص',
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.almarai(
          height: height,
          fontWeight: fontWeight ?? FontWeight.w500,
          color: color ?? Colors.black,
          fontSize: fontSize ?? 22.sp,
          textStyle: TextStyle(
            height: height,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 22.sp,
            color: color ?? Colors.black,
            decoration:
                lineThrough! ? TextDecoration.lineThrough : TextDecoration.none,
          )),
    );
  }
}
