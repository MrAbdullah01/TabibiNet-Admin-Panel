import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Provider/Faq/faq_provider.dart';
import '../../../Provider/actionProvider/actionProvider.dart';

class AddFaqScreen extends StatelessWidget {
  AddFaqScreen({super.key});

  final quesC = TextEditingController();
  final ansC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActionProvider>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,),
            AppText2(
              text: "FAQS",
              fontSize: 15.sp, fontWeight: FontWeight.w600,
              isTextCenter: false, textColor: themeColor,
            ),
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
            Consumer<ActionProvider>(
              builder: (context, provider, child) {
                return HoverLoadingButton(
                    isIcon: false,
                    text: provider.buttonFaqText,
                    onClicked: () async {
                      if (provider.editingId == null) {
                        _uploadFaq(context);
                      } else {
                        _updateFaq(context, provider.editingId!);
                      }
                    },
                    width: 12.w,
                    height: 5.h);
              },
            ),
            SizedBox(height: 8.h,),
            AppText2(
              text: "Recent FAQS:",
              fontSize: 15.sp, fontWeight: FontWeight.w600,
              isTextCenter: false, textColor: themeColor,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('faq')
                  .orderBy('id', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
        
                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching FAQs.'));
                }
        
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No FAQs found.'));
                }
        
                var faqList = snapshot.data!.docs;
        
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqList.length,
                  itemBuilder: (context, index) {
                    var faqData = faqList[index];
                    var question = faqData['question'] ?? 'No question';
                    var answer = faqData['answer'] ?? 'No answer';
                    var id = faqData['id'] ?? 'No id';

                    return Consumer<FaqProvider>(
                      builder: (context, value, child) {
                        bool isSelected = value.selectedIndex == index; // Check if this question is selected
        
                        return Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText2(
                                    text: "Q: $question",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    isTextCenter: false,
                                    textColor: textColor,
                                    fontFamily: AppFonts.medium,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      value.toggleFaq(index); // Toggle answer visibility
                                    },
                                    icon: Icon(
                                      isSelected
                                          ? CupertinoIcons.chevron_up
                                          : CupertinoIcons.chevron_down ,
                                      color: textColor,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey, thickness: 1.5),
                              Visibility(
                                visible: isSelected, // Show the answer if this question is selected
                                child: AppText2(
                                  text: "A: $answer",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  isTextCenter: false,
                                  textColor: Colors.grey,
                                  fontFamily: AppFonts.medium,
                                  maxLines: 10,
                                ),
                              ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                             Visibility(
                               visible: isSelected, // Show delete button only when answer is visible
                               child: Align(
                                 alignment: Alignment.bottomRight,
                                 child: SubmitButton(
                                   width: 6.w,
                                   height: 25,
                                   textSize: 10.sp,
                                   radius: 5,
                                   title: "Edit",
                                   press: () {
                                     quesC.text = faqData['question'];
                                     ansC.text = faqData['answer'];
                                     provider.setEditingMode(id);
                                   },
                                 ),
                               ),
                             ),
                             SizedBox(width: 2.w,),
                             Visibility(
                                 visible: isSelected, // Show delete button only when answer is visible
                                 child: Align(
                                   alignment: Alignment.bottomRight,
                                   child: SubmitButton(
                                     width: 6.w,
                                     height: 25,
                                     textSize: 10.sp,
                                     radius: 5,
                                     title: 'Delete',
                                     press: () {
                                         _deleteFaq(faqData.id);
                                     },
                                   ),
                                 ),
                               ),
                           ],)
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
        
          ],
        ),
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
  void _deleteFaq(String id) {
    FirebaseFirestore.instance.collection('faq').doc(id).delete().then((value) {
      // Success
    }).catchError((error) {
      // Handle error
    });
  }

  void _updateFaq(BuildContext context, String id) {
    FirebaseFirestore.instance.collection('faq').doc(id).update({
      'question': quesC.text,
      'answer': ansC.text,
    }).then((value) {
      quesC.clear();
      ansC.clear();
      Provider.of<ActionProvider>(context, listen: false).resetMode();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('FAQ updated successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update FAQ: $error')),
      );
    });
  }
}
