import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/toast_msg.dart';
import 'package:tabibinet_admin_panel/Provider/actionProvider/actionProvider.dart';

import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/add_button.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Model/Res/components/loadingButton.dart';
import '../PatientScreen/Components/patient_field.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  DoctorSpecialityScreen({super.key});

  final doctorSpecialityC = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ActionProvider>(context,listen: false);
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            Row(
              children: [
                AppText(
                  text: "Doctor Specialty",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  isTextCenter: false,
                  textColor: textColor,
                  fontFamily: AppFonts.semiBold,
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              width: 40.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PatientField(
                    text: "Speciality",
                    textEditingController: doctorSpecialityC,
                  ),
                  Consumer<ActionProvider>(
                    builder: (context, provider, child) {
                      return Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: HoverLoadingButton(
                          isIcon: false,
                          text: provider.buttonText,
                          onClicked: () async {
                            if (provider.editingId == null) {
                              _uploadDoctorSpecialty(context);
                            } else {
                              _updateSpecialty(context, provider.editingId!);
                            }
                          },
                          width: 10.w,
                          height: 6.h,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            const Text(
              'Recent Specialties',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3.h),

            // Use StreamBuilder to fetch and display specialties from Firebase
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('doctorsSpecialty')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error fetching specialties.'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No specialties found.'));
                }

                var specialties = snapshot.data!.docs;

                return Container(
                  width: 40.w,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      var specialtyData = specialties[index];
                      var specialty = specialties[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.sp, horizontal: 15.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 20.w,
                                child: AppText(
                                  text:
                                  specialty["specialty"],
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  isTextCenter: false,
                                  textColor: themeColor,
                                  overflow: TextOverflow.ellipsis ,
                                  fontFamily: AppFonts.medium,
                                ),
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  SizedBox(width: 15.sp),
                                  InkWell(
                                    onTap: () {
                                      doctorSpecialityC.text = specialty["specialty"];
                                      provider
                                          .setEditingMode(specialtyData.id);
                                      _scrollToTextField();
                                    },
                                    child: SvgPicture.asset(
                                      AppIcons.pencilIcon,
                                      height: 4.h,
                                    ),
                                  ),
                                  SizedBox(width: 15.sp),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: themeColor,
                                            title: const Text(
                                              'Delete Speciality!',
                                              style: TextStyle(
                                                  fontFamily: AppFonts.semiBold,
                                                  color: bgColor
                                              ),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to Delete Doctors Speciality?',
                                              style: TextStyle(
                                                  fontFamily: AppFonts.regular,
                                                  color: bgColor
                                              ),
                                            ),
                                            actions: <Widget>[
                                              SubmitButton(
                                                height: 30,
                                                width: 8.w,
                                                textSize: 12.sp,
                                                bgColor: themeColor,
                                                textColor: bgColor,
                                                bdColor: bgColor,
                                                title: "No",
                                                press: () => Get.back(),),
                                              SubmitButton(
                                                height: 30,
                                                width: 8.w,
                                                textSize: 12.sp,
                                                bgColor: bgColor,
                                                textColor: themeColor,
                                                bdColor: bgColor,
                                                title: "Yes",
                                                press: () {
                                                  _deleteSpecialty(
                                                      context, specialtyData.id);
                                                  ToastMsg().toastMsg("Specialty deleted successfully");
                                                  Get.back();
                                                }),
                                            ],
                                          );
                                        },
                                      );
                                      // Handle delete icon tap

                                    },
                                    child: SvgPicture.asset(
                                      AppIcons.deleteIcon,
                                      height: 4.h,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  void _scrollToTextField() {
    // Scroll to the TextField position
    _scrollController.animateTo(
      10.0, // Adjust this value based on your layout
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _uploadDoctorSpecialty(BuildContext context) {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if (doctorSpecialityC.text.isNotEmpty) {
      ActionProvider.startLoading();
      var doctorsSpecialtyDoc = FirebaseFirestore.instance
          .collection('doctorsSpecialty')
          .doc(timeStamp);

      doctorsSpecialtyDoc.set({
        'specialty': doctorSpecialityC.text,
        'id': doctorsSpecialtyDoc.id,
        'timestamp': timeStamp,
      }).then((value) {
        ActionProvider.stopLoading();
        doctorSpecialityC.clear();
        Provider.of<ActionProvider>(context, listen: false).resetMode();

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

  void _deleteSpecialty(context, String id) {
    FirebaseFirestore.instance
        .collection('doctorsSpecialty')
        .doc(id)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Specialty deleted successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete specialty: $error')),
      );
    });
  }

  void _updateSpecialty(BuildContext context, String id) {
    FirebaseFirestore.instance.collection('doctorsSpecialty').doc(id).update({
      'specialty': doctorSpecialityC.text,
    }).then((value) {
      doctorSpecialityC.clear();
      Provider.of<ActionProvider>(context, listen: false).resetMode();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Specialty updated successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update specialty: $error')),
      );
    });
  }
}
