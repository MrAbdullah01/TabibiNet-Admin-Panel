import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';

class PatientField extends StatelessWidget {
  const PatientField({
    super.key,
    required this.text,
    required this.textEditingController
  });

  final TextEditingController textEditingController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: text,
          fontSize: 12.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: textColor,
          fontFamily: AppFonts.medium,),
        SizedBox(
            width: 15.w,
            child: AppTextField(inputController: textEditingController))
      ],
    );
  }
}
