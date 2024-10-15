
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Model/Res/Widgets/toast_msg.dart';
import '../../../Provider/Patient/patient_provider.dart';
import '../DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

class AdsListScreen extends StatelessWidget {
   AdsListScreen({super.key});

  final searchC = TextEditingController();
  final patientNameC = TextEditingController();
  final patientEmailC = TextEditingController();
  final patientPhoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context, listen: false);
    final pro = Provider.of<DashBoardProvider>(context, listen: false);

    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            SizedBox(
                width: 40.w,
                child: AppTextField2(
                  inputController: searchC,
                  hintText: "Search Ads",
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    patientProvider.setSearchQuery(value);
                  },
                )),
            SizedBox(
              width: 2.w,
            ),
          ],
        ),
        SizedBox(
          height: 20.sp,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('bannerAds')
              .orderBy("specialityId", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No Ads found'));
            }
            patientProvider.setPatients(snapshot.data!.docs);

            return Consumer<PatientProvider>(
              builder: (context, provider, child) {
                final filteredPatients = provider.filteredPatients;

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredPatients.length,
                  itemBuilder: (context, index) {
                    final user = filteredPatients[index];

                    return Card(
                      elevation: 2,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  GestureDetector(
                                    // focusColor: Colors.transparent,
                                    // hoverColor: Colors.transparent,
                                    // highlightColor: Colors.transparent,
                                    // splashColor: Colors.transparent,
                                    onTap: () {
                                      // Provider.of<PatientDataProvider>(context, listen: false).setPatientDataDetails(
                                      //   patientName: user["name"],
                                      //   appointmentDate: user["creationDate"].toString(),
                                      //   fees: user["reviews"].toString(),
                                      //   feesId: user["reviews"].toString(),
                                      //   country: user["country"].toString(),
                                      //   patientPhone: user["phoneNumber"].toString(),
                                      //   userType: user["speciality"].toString() ?? "",
                                      //   patientProblem: user["speciality"].toString(),
                                      //   patientAge: user["birthDate"].toString() ??"",
                                      //   patientEmail: user["email"].toString(),);
                                     // pro.setSelectedIndex(20);
                                    },
                                    child: CircleAvatar(
                                        radius: 18,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: user['profileUrl'].toString().isNotEmpty
                                              ? Image.network(user['profileUrl'], fit: BoxFit.cover, width: 36,  // The same size as CircleAvatar's diameter
                                            height: 36,) :
                                          Image.asset(AppAssets.doctorImage,fit: BoxFit.cover, width: 36,  // The same size as CircleAvatar's diameter
                                            height: 36,),
                                        )

                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 1.5.h),
                                    child: Text(
                                      user['name'] ?? 'Unknown',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 1.5.h),
                                    child: Text(
                                      user['email'] ?? 'No email',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  SizedBox(width: 3.w,),
                                  Padding(
                                    padding:  EdgeInsets.only(top: 1.5.h),
                                    child: Text(
                                      user['phoneNumber'] ?? 'No phone number',
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // InkWell(
                                      //     onTap: (){},
                                      //     child: SvgPicture.asset(AppIcons.pencilIcon,height: 4.h,)),
                                      // SizedBox(width: 15.sp,),
                                      InkWell(
                                          onTap:  (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: themeColor,
                                                  title: const Text(
                                                    'Delete Ad!',
                                                    style: TextStyle(
                                                        fontFamily: AppFonts.semiBold,
                                                        color: bgColor
                                                    ),
                                                  ),
                                                  content: const Text(
                                                    'Are you sure you want to Delete this Ad?',
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
                                                          _deleteUser(context,user["userUid"]);
                                                          ToastMsg().toastMsg("Ad deleted successfully");
                                                          Get.back();
                                                        }),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: SvgPicture.asset(AppIcons.deleteIcon,height: 4.h,)),
                                    ],)
                                ],

                              )
                            ],
                          )
                      ),
                    );
                    //   InfoTile(
                    //   nameText: user['name'] ?? 'Unknown',
                    //   emailText: user['email'] ?? 'No email',
                    //   phoneText: user['phoneNumber'] ?? 'No phone Number',
                    //   isAddIcon: true,
                    //   isStatusText: false,
                    //   image: user['profileUrl'] ??
                    //       'assets/icons/patient_payment_icon.svg', // replace with a default image URL
                    // );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15.sp);
                  },
                );
              },);
          },
        ),
      ],
    );
  }
   void _deleteUser(BuildContext context, String docId) async {
     try {
       // Reference to the specific document (ad) in the 'bannerAds' collection
       DocumentReference adDoc = FirebaseFirestore.instance.collection('bannerAds').doc(docId);

       // Delete the ad document
       await adDoc.delete();

       // Show success message
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Ad deleted successfully!')),
       );
     } catch (error) {
       // Catch and display any errors
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Failed to delete the ad: $error')),
       );
     }
   }

}
