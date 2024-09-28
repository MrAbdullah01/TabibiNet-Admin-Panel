// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
// import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
//
// import '../../../../Model/Res/Constants/app_assets.dart';
// import '../../../../Model/Res/Constants/app_colors.dart';
// import '../../../../Model/Res/Constants/app_fonts.dart';
// import '../../../../Model/Res/Constants/app_icons.dart';
// import '../../../../Model/Res/Widgets/app_text_widget.dart';
//
// class AppointmentCard extends StatelessWidget {
//   const AppointmentCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final appointmentP = Provider.of<AppointmentProvider>(context,listen: false);
//     return Container(
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(15)
//       ),
//       child: Row(
//         children: [
//           Container(
//             height: 80,
//             width: 80,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               image: const DecorationImage(
//                   image: AssetImage(AppAssets.doctorImage)
//               )
//             ),
//           ),
//           SizedBox(width: 1.w,),
//           AppText(
//             text: "Alex",
//             fontSize: 14.sp, fontWeight: FontWeight.w600,
//             isTextCenter: false, textColor: textColor,
//             fontFamily: AppFonts.semiBold,),
//           const Spacer(),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   SvgPicture.asset(AppIcons.clockIcon,height: 15,),
//                   const SizedBox(width: 10,),
//                   AppText(
//                       text: "11 Sep, 2024   10:45Am",
//                       fontSize: 10.sp, fontWeight: FontWeight.w400,
//                       isTextCenter: false, textColor: textColor)
//                 ],
//               ),
//               SizedBox(height: 1.h,),
//               AppText(
//                 text: "Dr.John",
//                 fontSize: 12.sp, fontWeight: FontWeight.w500,
//                 isTextCenter: false, textColor: themeColor,
//                 fontFamily: AppFonts.semiBold,
//               )
//             ],
//           ),
//           const Spacer(),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   SvgPicture.asset(AppIcons.smsIcon,height: 17,),
//                   const SizedBox(width: 10,),
//                   AppText(
//                       text: "info@gmail.com",
//                       fontSize: 10.sp, fontWeight: FontWeight.w400,
//                       isTextCenter: false, textColor: textColor)
//                 ],
//               ),
//               const SizedBox(height: 10,),
//               Row(
//                 children: [
//                   SvgPicture.asset(AppIcons.phone2Icon,height: 15,),
//                   const SizedBox(width: 10,),
//                   AppText(
//                       text: "+212 124-567-890-1",
//                       fontSize: 10.sp, fontWeight: FontWeight.w400,
//                       isTextCenter: false, textColor: textColor)
//                 ],
//               ),
//
//             ],
//           ),
//           // const Spacer(),
//           SizedBox(width: 3.w,),
//           InkWell(
//               onTap: () => appointmentP.setAppointmentScreen(true),
//               child: SvgPicture.asset(AppIcons.visibleIcon,height: 30,)),
//           // SvgPicture.asset(AppIcons.visibleIcon,height: 30,)
//         ],
//       ),
//     );
//   }
// }
//
// //SubmitButton(
// //             title: "Accept",
// //             width: 5.w,
// //             height: 40,
// //             press: () {
// //
// //           },),
// //           SizedBox(width: 1.w,),
// //           SubmitButton(
// //             title: "Reject",
// //             width: 5.w,
// //             height: 40,
// //             bgColor: bgColor,
// //             textColor: themeColor,
// //             press: () {
// //
// //           },),