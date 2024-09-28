import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Provider/actionProvider/actionProvider.dart';

class AddFaqScreen extends StatelessWidget {
  AddFaqScreen({super.key});

  final quesC = TextEditingController();
  final ansC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          HoverLoadingButton(
            isIcon: false,
              text: 'Submit',
              onClicked: () async {
                _uploadFaq(context);

              },
              width: 12.w,
              height: 5.h),


        ],
      ),
    );
  }
  void _uploadFaq(BuildContext context) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if (quesC.text.isNotEmpty || ansC.text.isNotEmpty) {
      ActionProvider.startLoading();
      var faq = FirebaseFirestore.instance
          .collection('faq')
          .doc(timeStamp);

      faq.set({
        'question': quesC.text,
        'answer': ansC.text,
        'id': timeStamp,
      }).then((value) {
        ActionProvider.stopLoading();
        quesC.clear();
        ansC.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Specialty added successfully!')),
        );
      }).catchError((error) {
        ActionProvider.stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add specialty: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a specialty')),
      );
    }
  }

}
