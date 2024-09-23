import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/add_button.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Constants/app_icons.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/info_tile.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/Patient/patient_provider.dart';
import '../../../Provider/actionProvider/actionProvider.dart';
import 'Components/patient_field.dart';

class PatientScreen extends StatelessWidget {
  PatientScreen({super.key});

  final searchC = TextEditingController();
  final patientNameC = TextEditingController();
  final patientEmailC = TextEditingController();
  final patientPhoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 40.w,
                      child: AppTextField2(
                        inputController: searchC,
                        hintText: "Search User",
                        prefixIcon: Icons.search,
                      )),
                  SizedBox(
                    width: 2.w,
                  ),
                  // AddButton(
                  //   onTap: () => value.setAddPatient(true),
                  // ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('userType', isEqualTo: "Patient")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No users found'));
                  }

                  final users = snapshot.data!.docs;

                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index].data() as Map<String, dynamic>;

                      return Card(
                          elevation: 2,
                          child: Padding(
                          padding: const EdgeInsets.all(10.0),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  user['profileUrl'] ?? AssetImage(AppAssets.doctorImage), // Default image
                                ),
                              ),
                             Text(
                               user['name'] ?? 'Unknown',
                               style: TextStyle(fontWeight: FontWeight.bold),
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                             ),
                             Text(
                               user['email'] ?? 'No email',
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(color: Colors.grey),
                             ),
                             SizedBox(width: 3.w,),
                             Text(
                               user['phoneNumber'] ?? 'No phone number',
                               style: TextStyle(color: Colors.grey),
                             ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                InkWell(
                                    onTap: (){},
                                    child: SvgPicture.asset(AppIcons.pencilIcon,height: 4.h,)),
                                SizedBox(width: 15.sp,),
                                InkWell(
                                    onTap:  (){
                                      _deleteUser(context,user["userUid"]);
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
                },
              ),
            ],
          );
  }
  void _deleteUser(context,String id) async {
    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(id);

    CollectionReference notifications = userDoc.collection('notifications');

    final notificationsSnapshot = await notifications.get();
    if (notificationsSnapshot.docs.isNotEmpty) {
      for (var notification in notificationsSnapshot.docs) {
        await notification.reference.delete();
      }
    }

    // Delete the user document
    userDoc.delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User and notifications deleted successfully!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $error')),
      );
    });
  }

  // void _deleteUser(context, String id) {
  //
  //   FirebaseFirestore.instance.collection('users').doc(id).delete()
  //       .then((value) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('User deleted successfully!')),
  //     );
  //   }).catchError((error) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete User: $error')),
  //     );
  //   });
  // }
}
