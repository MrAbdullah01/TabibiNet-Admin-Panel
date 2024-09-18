import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/add_button.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Constants/app_fonts.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../Model/Res/Widgets/info_tile.dart';
import '../../../Model/Res/Widgets/submit_button.dart';
import '../../../Provider/Patient/patient_provider.dart';
import 'Components/patient_field.dart';

class PatientScreen extends StatelessWidget {
  PatientScreen({super.key});

  final searchC = TextEditingController();
  final patientNameC = TextEditingController();
  final patientEmailC = TextEditingController();
  final patientPhoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProvider>(
      builder: (context, value, child) {
        return value.isAddPatient ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Add Patient",
              fontSize: 14.sp, fontWeight: FontWeight.w500,
              isTextCenter: false, textColor: themeColor,
              fontFamily: AppFonts.semiBold,),
            SizedBox(height: 20.sp,),
            Row(
              children: [
                PatientField(text: "Patient Name", textEditingController: patientNameC),
                SizedBox(width: 8.w,),
                PatientField(text: "Patient Email", textEditingController: patientEmailC),
              ],
            ),
            SizedBox(height: 20.sp,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PatientField(text: "Patient Name", textEditingController: patientNameC),
                SizedBox(width: 8.w,),
                SubmitButton(
                  width: 10.w,
                  title: "Add Now",
                  press: () {

                  },),
              ],
            ),
          ],) :
        ListView(
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
                SizedBox(width: 2.w,),
                AddButton(onTap: () => value.setAddPatient(true),),
              ],
            ),
            SizedBox(height: 20.sp,),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const InfoTile(
                  nameText: "ALexon",
                  emailText: "info@gmail.com",
                  phoneText: "+92 356 678 90",
                  image: AppAssets.profileImage,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15.sp,);
              },)
          ],
        );
      },);

  }
}
