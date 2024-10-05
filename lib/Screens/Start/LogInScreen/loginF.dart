// import 'dart:developer';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Constants/firebase.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
// import 'package:tabibinet_admin_panel/Model/Res/Widgets/toast_msg.dart';
// import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';
// import 'package:tabibinet_admin_panel/Provider/Login/login_provider.dart';
// import 'package:tabibinet_admin_panel/Screens/DashBoard/DashBoardScreen/dash_board_screen.dart';
//
// import '../../../Model/Res/utils/app_utils.dart';
// import '../../../Provider/DashBoard/dash_board_provider.dart';
// import '../../../Provider/actionProvider/Authen_provider.dart';
// import '../../../Provider/actionProvider/actionProvider.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({super.key});
//
//   final emailC = TextEditingController();
//   final passwordC = TextEditingController();
//   final newPasswordC = TextEditingController();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final forgetPassword = Provider.of<ActionProvider>(context);
//     return Scaffold(
//       backgroundColor: bgColor,
//       body: Form(
//         key: _key,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   height: 100.h,
//                   width: 25.w,
//                   child: Image.asset(AppAssets.logInImage, fit: BoxFit.cover),
//                 ),
//                 Container(
//                   height: 100.h,
//                   width: 25.w,
//                   decoration: BoxDecoration(
//                     color: themeColor.withOpacity(0.45),
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             SizedBox(
//               width: 35.w,
//               height: 100.h,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: SizedBox(
//                       height: 30.h,
//                       child: SvgPicture.asset(AppAssets.logoImage),
//                     ),
//                   ),
//                   AppText(
//                     text: "Email",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     isTextCenter: false,
//                     textColor: textColor,
//                     fontFamily: AppFonts.medium,
//                   ),
//                   SizedBox(height: 1.h),
//                   AppTextField(
//                     inputController: emailC,
//                     hintText: "Enter Email",
//                     validator: (email) {
//                       if (emailC.text.isNotEmpty) {
//                         return AppUtils().validateEmail(email);
//                       }
//                       return 'Required';
//                     },
//                   ),
//                   SizedBox(height: 3.h),
//                   AppText(
//                     text: "Password",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     isTextCenter: false,
//                     textColor: textColor,
//                     fontFamily: AppFonts.medium,
//                   ),
//                   SizedBox(height: 1.h),
//                   Consumer<LogInProvider>(
//                     builder: (context, value, child) {
//                       return AppTextField(
//                         inputController: passwordC,
//                         hintText: "Enter Password",
//                         obscureText: value.isVisible,
//                         validator: (password) {
//                           if (passwordC.text.isNotEmpty) {
//                             if (passwordC.text.length < 8) {
//                               return 'Password must be at least 8 characters';
//                             }
//                             return AppUtils().passwordValidator(password);
//                           }
//                           return 'Required';
//                         },
//                         suffixIcon: IconButton(
//                           onPressed: () {
//                             value.setPasswordVisibility();
//                             log("message:${value.isVisible}");
//                           },
//                           icon: Icon(
//                             value.isVisible ? Icons.visibility_off : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 1.h),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.end,
//                   //   children: [
//                   //     InkWell(
//                   //       onTap: () {
//                   //         showDialog(
//                   //           context: context,
//                   //           builder: (BuildContext context) {
//                   //             return AlertDialog(
//                   //               title: Text("Forget Password"),
//                   //               content: Column(
//                   //                 mainAxisSize: MainAxisSize.min,
//                   //                 children: [
//                   //                   TextField(
//                   //                     controller: newPasswordC,
//                   //                     decoration: InputDecoration(
//                   //                       hintText: "Enter your email",
//                   //                       border: OutlineInputBorder(),
//                   //                     ),
//                   //                   ),
//                   //                 ],
//                   //               ),
//                   //               actions: [
//                   //                 TextButton(
//                   //                   onPressed: () {
//                   //                     Navigator.of(context).pop(); // Close the dialog
//                   //                   },
//                   //                   child: Text("Cancel"),
//                   //                 ),
//                   //                 SubmitButton(title: 'Submit', press: () {
//                   //                   updatePass();
//                   //                 },
//                   //                   width: 5.w,
//                   //                   radius: 2.5.w,
//                   //                   textSize: 10,
//                   //                 )
//                   //               ],
//                   //             );
//                   //           },
//                   //         );
//                   //       },
//                   //       child:    AppText(
//                   //         textDecoration: TextDecoration.underline,
//                   //         text: "Forget Password?",
//                   //         fontSize: 12,
//                   //         fontWeight: FontWeight.w600,
//                   //         isTextCenter: false,
//                   //         textColor: themeColor,
//                   //         fontFamily: AppFonts.medium,
//                   //       ),
//                   //     ),
//                   //     // InkWell(
//                   //     //   onTap: () {
//                   //     //     forgetPassword.setLoginMode(true);
//                   //     //     forgetPassword.toggleForgetPasswordField();
//                   //     //   },
//                   //     //   child:
//                   //     // AppText(
//                   //     //     textDecoration: TextDecoration.underline,
//                   //     //     text: "Forget Password?",
//                   //     //     fontSize: 12,
//                   //     //     fontWeight: FontWeight.w600,
//                   //     //     isTextCenter: false,
//                   //     //     textColor: themeColor,
//                   //     //     fontFamily: AppFonts.medium,
//                   //     //   ),
//                   //     //  ),
//                   //   ],
//                   // ),
//                   Consumer<ActionProvider>(
//                     builder: (context, forgetPasswordProvider, child) {
//                       if (forgetPasswordProvider.isForgetPasswordVisible) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             AppText(
//                               text: "Reset Password",
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               isTextCenter: false,
//                               textColor: textColor,
//                               fontFamily: AppFonts.medium,
//                             ),
//                             SizedBox(height: 1.h),
//                             Consumer<LogInProvider>(
//                               builder: (context, value, child) {
//                                 return AppTextField(
//                                   inputController: newPasswordC,
//                                   hintText: "Enter New Password",
//                                   obscureText: value.isVisibleN,
//                                   validator: (password) {
//                                     if (newPasswordC.text.isNotEmpty) {
//                                       if (newPasswordC.text.length < 8) {
//                                         return 'Password must be at least 8 characters';
//                                       }
//                                       return AppUtils().passwordValidator(password);
//                                     }
//                                     return 'Required';
//                                   },
//                                   suffixIcon: IconButton(
//                                     onPressed: () {
//                                       value.setPasswordVisibility();
//                                       log("message:${value.isVisibleN}");
//                                     },
//                                     icon: Icon(
//                                       value.isVisibleN
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             SizedBox(height: 2.h),
//                             // SubmitButton(
//                             //   width: 10.w,
//                             //   press: () {
//                             //     _upDataPassword(context);
//                             //   },
//                             //   title: "Update Password",
//                             // ),
//                           ],
//                         );
//                       }
//                       return Container();
//                     },
//                   ),
//                   SizedBox(height: 8.h),
//                   Consumer<ActionProvider>(
//                     builder: (context, value, child) {
//                       return HoverLoadingButton(
//                         width: 20.w,
//                         height: 5.h,
//                         text: value.buttonLoginText,
//                         onClicked: () async {
//                           if (!value.isUpdate) {
//                             if (_key.currentState!.validate()) {
//                               _key.currentState!.save();
//                               ActionProvider().setLoading(true);
//                               Provider.of<AuthenticationProvider>(context, listen: false)
//                                   .signInUser(
//                                 email: emailC.text.toString(),
//                                 password: passwordC.text.toString(),
//                                 context: context,
//                               );
//                             }
//                           } else {
//                             _upDataPassword(context,value);
//                           }
//
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//             const Spacer()
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Future<void> logIn() async {
//   //   await auth.signInWithEmailAndPassword(
//   //     email: emailC.text.toString(),
//   //     password: passwordC.text.toString(),
//   //   ).then(
//   //         (value) {
//   //       Get.to(() => DashBoardScreen());
//   //       ToastMsg().toastMsg("Log In Successfully!");
//   //     },
//   //   ).onError(
//   //         (error, stackTrace) {
//   //       ToastMsg().toastMsg(error.toString());
//   //     },
//   //   );
//   // }
//
//   Future<void> _upDataPassword(BuildContext context,ActionProvider provider) async {
//     ActionProvider.startLoading();
//     if (newPasswordC.text.isEmpty || newPasswordC.text.length < 8) {
//       ActionProvider.stopLoading();
//       ToastMsg().toastMsg(
//         'Please Enter a new password with at least 8 characters',
//       );
//       return;
//     }
//
//     try {
//       await FirebaseFirestore.instance
//           .collection('admin')
//           .doc("XcZeK5QjfBpZkrp03pGD")
//           .update({
//         'password': newPasswordC.text,
//       });
//       ActionProvider.stopLoading();
//       // Provider.of<ActionProvider>(context).isVisibleN = true;
//       ToastMsg().toastMsg('Password updated successfully');
//       provider.resetMode();
//       provider.toggleForgetPasswordField();
//     } catch (e) {
//       ActionProvider.stopLoading();
//       ToastMsg().toastMsg('Failed to update password');
//     }
//   }
//   updatePass(){
//     auth.sendPasswordResetEmail(email: newPasswordC.text.toString())
//         .then((value) {
//       ToastMsg().toastMsg(
//           "We have sent Email to Recover"
//               " your Password, Please Check Email");
//     },)
//         .onError((error, stackTrace) {
//       ToastMsg().toastMsg(error.toString());
//     },);
//   }
// }
