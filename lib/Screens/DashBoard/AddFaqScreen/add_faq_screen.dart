import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';

class AddFaqScreen extends StatelessWidget {
  AddFaqScreen({super.key});

  final quesC = TextEditingController();
  final ansC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h,),
        AppText2(
            text: "Question:",
            fontSize: 12.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,
        ),
        SizedBox(height: 1.h,),
        SizedBox(
            width: 25.w,
            child: AppTextField(
                inputController: quesC,
              hintText: " What is TabibiNet?",
            )),
        SizedBox(height: 2.h,),
        AppText2(
          text: "Answer:",
          fontSize: 12.sp, fontWeight: FontWeight.w600,
          isTextCenter: false, textColor: textColor,
        ),
        SizedBox(height: 1.h,),
        SizedBox(
            width: 40.w,
            child: AppTextField(
                inputController: ansC,
              hintText: "Using TabibiNet is simple.",
            )),
        SizedBox(height: 3.h,),
        SubmitButton(
          width: 12.w,
          radius: 6,
          title: "Submit",
          press: () {

          },)

      ],
    );
  }
}
