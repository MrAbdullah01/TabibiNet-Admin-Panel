import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/loadingButton.dart';
import 'package:tabibinet_admin_panel/Provider/cloudinaryProvider/imageProvider.dart';
import 'package:tabibinet_admin_panel/Provider/profileProvider/profileInfo.dart';
import 'package:tabibinet_admin_panel/Screens/DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';
import 'dart:html' as html;
import 'dart:typed_data';
import '../../Model/Res/Constants/app_icons.dart';
import '../../Model/Res/Widgets/AppTextField.dart';
import '../../Model/Res/Widgets/toast_msg.dart';
import '../../Provider/actionProvider/actionProvider.dart';

class AdsRequest extends StatelessWidget {
  AdsRequest({super.key});


  TextEditingController titleController =  TextEditingController();
  TextEditingController descController =  TextEditingController();
  @override
  Widget build(BuildContext context) {

    final doc = Provider.of<PatientDataProvider>(context);
    titleController = TextEditingController(text: doc.doctorName);
    descController = TextEditingController(text: doc.doctorDescription);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer2<ProfileInfoProvider,CloudinaryProvider>(

       builder: (context, value,provider, child) {
         return Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             GestureDetector(
               onTap: () {
               //  _pickAndUploadImage(context);

               },
               child: Row(
                 children: [
                   CircleAvatar(
                       backgroundColor: themeColor,
                       radius: 100,
                       backgroundImage: provider.imageData != null
                           ? MemoryImage(provider.imageData!)
                           : value.profileImageUrl != null
                           ? NetworkImage(doc.doctorPhoto)
                           : const AssetImage(AppAssets.profileImage) as ImageProvider,
                       // child: ClipRRect(
                       //     borderRadius: BorderRadius.circular(10),
                       //     child: SvgPicture.asset(AppIcons.cameraIcon,height: 70,width: 70,),
                       // ),
                   ),
                   SizedBox(width: 2.w,),
                   AppText(text: "Banner Photo",fontSize: 18,)
                 ],
               ),
             ),
             SizedBox(height: 2.h,),
             AppText2(
               text: "Ad title",
               fontSize: 12.sp, fontWeight: FontWeight.w600,
               isTextCenter: false, textColor: textColor,
             ),
             SizedBox(height: 1.h,),
             SizedBox(
                 width: 45.w,
                 child: AppTextField(
                   readOnly: true,
                   maxLines: 2,
                   inputController: titleController,
                   hintText: '',
                 )),
             SizedBox(height: 2.h),
             AppText2(
               text: "Description",
               fontSize: 12.sp, fontWeight: FontWeight.w600,
               isTextCenter: false, textColor: textColor,
             ),
             SizedBox(height: 1.h,),
             SizedBox(
                 width: 45.w,
                 child: AppTextField(
                   readOnly: true,
                   maxLines: 10,
                   inputController: descController,
                   hintText: '',
                 )),
             SizedBox(height: 2.h,),
             HoverLoadingButton(text: 'Post Ad',
                 onClicked: () async{
                   _uploadData(context);
                 },
                 width: 14.w,
                 height: 6.h)
           ],
         );
       },
      ),
    );
  }
  // Future<void> _pickAndUploadImage(BuildContext context) async {
  //
  //   final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  //   uploadInput.accept = 'image/*'; // Accept only images
  //
  //   uploadInput.onChange.listen((e) async {
  //     final files = uploadInput.files;
  //     if (files!.isEmpty) return;
  //
  //     final reader = html.FileReader();
  //     reader.readAsArrayBuffer(files[0]);
  //
  //     reader.onLoadEnd.listen((e) async {
  //       final bytes = reader.result as Uint8List;
  //
  //       // Set image data using Provider to display in the container
  //       final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
  //       cloudinaryProvider.setImageData(bytes);
  //
  //       ToastMsg().toastMsg('Image uploaded successfully');
  //     });
  //   });
  //
  //   uploadInput.click(); // Trigger the file picker dialog
  // }
  // Future<void> _uploadData(BuildContext context) async {
  //   final doc = Provider.of<PatientDataProvider>(context);
  //
  //   var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  //
  //   ActionProvider.startLoading();
  //   final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
  //   // Email validation to check if it contains @gmail.com
  //   // if (!emailC.text.contains('@gmail.com')) {
  //   //   ActionProvider.stopLoading();
  //   //   ToastMsg().toastMsg('Please enter a valid Gmail address');
  //   //   return;
  //   // }
  //
  //   if (titleController.text.isEmpty ||
  //       descController.text.isEmpty ||
  //       cloudinaryProvider.imageData == null) {
  //     ActionProvider.stopLoading();
  //     ToastMsg().toastMsg('Please fill all fields or upload an image',);
  //     return;
  //   }
  //
  //   try {
  //     await cloudinaryProvider.uploadImage(cloudinaryProvider.imageData!);
  //     log('Image URL: ${cloudinaryProvider.imageUrl}');
  //     if (cloudinaryProvider.imageUrl.isNotEmpty) {
  //       //  Save the data to Firebase
  //       // Example Firebase code:
  //       await FirebaseFirestore.instance.collection('bannerAds').doc(timeStamp).set({
  //         'title': titleController.text,
  //         'description': descController.text,
  //         'imageUrl': cloudinaryProvider.imageUrl.toString(),
  //         'createdAt': timeStamp.toString(),
  //         'doctorName': doc.doctorName,
  //         'doctorDescription': doc.doctorDescription,
  //         'doctorPhoto': doc.doctorPhoto,
  //         'doctorLocation': doc.doctorLocation,
  //         'docPhoneNumber': doc.docPhoneNumber,
  //         'fees': doc.fees,
  //         'feesId': doc.feesId,
  //         'userType': doc.userType,
  //         'userdata': doc.docModel,         });
  //       ActionProvider.stopLoading();
  //
  //       cloudinaryProvider.clearImage();
  //
  //       ToastMsg().toastMsg( 'Data uploaded successfully');
  //     } else {
  //       ActionProvider.stopLoading();
  //       cloudinaryProvider.clearImage();
  //       ToastMsg().toastMsg( 'Image upload failed',);
  //     }
  //   } catch (e) {
  //     log('Error uploading Data: $e');
  //     ActionProvider.stopLoading();
  //     cloudinaryProvider.clearImage();
  //     ToastMsg().toastMsg( 'Failed to upload Data', );
  //   }
  // }
  Future<void> _uploadData(BuildContext context) async {
    final doc = Provider.of<PatientDataProvider>(context, listen: false);
    final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);

    String userUid = doc.docModel?['userUid'] ?? '';

    ActionProvider.startLoading();

    log('Title: ${titleController.text}');
    log('Description: ${descController.text}');
    log('Doctor Photo: ${doc.doctorPhoto}');
    log('Image Data: ${cloudinaryProvider.imageData}');
    log('User UID: $userUid');

    if (titleController.text.isEmpty ||
        descController.text.isEmpty ||
        (cloudinaryProvider.imageData == null && doc.doctorPhoto.isEmpty)) {
      ActionProvider.stopLoading();
      ToastMsg().toastMsg('Please fill all fields or upload an image');
      return;
    }

    try {
      String imageUrl = doc.doctorPhoto;

      if (cloudinaryProvider.imageData != null) {
        await cloudinaryProvider.uploadImage(cloudinaryProvider.imageData!);
        log('Uploaded Image URL: ${cloudinaryProvider.imageUrl}');
        imageUrl = cloudinaryProvider.imageUrl;
      }

      if (imageUrl.isNotEmpty) {
        await FirebaseFirestore.instance.collection('bannerAds').doc(userUid).set(doc.docModel as Map<String, dynamic>);

        ActionProvider.stopLoading();
        cloudinaryProvider.clearImage();
        ToastMsg().toastMsg('Data uploaded successfully');
      } else {
        ActionProvider.stopLoading();
        cloudinaryProvider.clearImage();
        ToastMsg().toastMsg('Image upload failed');
      }
    } catch (e) {
      log('Error uploading data: $e');
      ActionProvider.stopLoading();
      cloudinaryProvider.clearImage();
      ToastMsg().toastMsg('Failed to upload data');
    }
  }

}
