import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/add_button.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/Faq/faq_provider.dart';
import '../AddFaqScreen/add_faq_screen.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Consumer<FaqProvider>(
          builder: (context, value, child) {
            return Row(
              children: [
                AppText(
                  text: "FAQS",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  isTextCenter: false,
                  textColor: themeColor,
                  fontFamily: AppFonts.semiBold,
                ),
                SizedBox(width: 1.w),
                AddButton(
                  onTap: () {
                    Get.to(AddFaqScreen());
                  },
                ),
              ],
            );
          },
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('faq')
              .orderBy('id', descending: true)
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
                          Visibility(
                            visible: isSelected, // Show delete button only when answer is visible
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SubmitButton(
                                width: 6.w,
                                height: 25,
                                textSize: 10.sp,
                                radius: 5,
                                title: "Delete",
                                press: () {
                                  _deleteFaq(faqData.id);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        // Consumer<FaqProvider>(
        //   builder: (context, value, child) {
        //     return Visibility(
        //       visible: value.isAddFaq,
        //       child: AddFaqScreen(),
        //     );
        //   },
        // ),
      ],
    );
  }

  void _deleteFaq(String id) {
    FirebaseFirestore.instance.collection('faq').doc(id).delete().then((value) {
      // Success
    }).catchError((error) {
      // Handle error
    });
  }
}
