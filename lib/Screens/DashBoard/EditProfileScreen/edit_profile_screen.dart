  import 'dart:developer';

  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:provider/provider.dart';
  import 'package:sizer/sizer.dart';
  import 'dart:html' as html;
  import 'dart:typed_data';
  import 'package:tabibinet_admin_panel/Model/Res/Constants/app_assets.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Widgets/AppTextField.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
  import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Provider/profileProvider/profileInfo.dart';
  import '../../../Model/Res/Widgets/toast_msg.dart';
  import '../../../Provider/actionProvider/actionProvider.dart';
  import '../../../Provider/cloudinaryProvider/imageProvider.dart';

  class EditProfileScreen extends StatelessWidget {
    EditProfileScreen({super.key});

    final TextEditingController firstNameC = TextEditingController();
    final TextEditingController lastNameC = TextEditingController();
    final TextEditingController emailC = TextEditingController();
    final TextEditingController phoneC = TextEditingController();
    final TextEditingController addressC = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Consumer2<ProfileInfoProvider,CloudinaryProvider>(
        builder: (context, value,provider, child) {
         return ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: provider.imageData != null
                            ? MemoryImage(provider.imageData!)
                            : value.profileImageUrl != null
                            ? NetworkImage(value.profileImageUrl!) // Use NetworkImage if imageUrl is available
                            : const AssetImage(AppAssets.profileImage) as ImageProvider,
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickAndUploadImage(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                              color: themeColor,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(AppIcons.cameraIcon),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 1.5.w,),
                  SubmitButton(
                    width: 10.w,
                    height: 35,
                    radius: 6,
                    textSize: 12.sp,
                    title: "Upload Photo",
                    press: () {},)
                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  InfoField(text1:  "First Name",
                      hint:  value.profileName !=null ?  firstNameC.text = value.profileName.toString() : "Enter First Name",
                      controller: firstNameC),
                  SizedBox(width: 10.w,),
                  InfoField(text1: "Last Name",
                      hint:  value.profileLastName !=null ?  lastNameC.text = value.profileLastName.toString() : "Enter last Name",

                      controller: lastNameC),

                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                children: [
                  InfoField(
                      text1: "Email",
                      hint:  value.profileEmail !=null ?  emailC.text = value.profileEmail.toString() : "Enter Email",

                      controller: emailC),
                  SizedBox(width: 10.w,),
                  InfoField(text1: "Phone Number",
                      hint:  value.profilePhone !=null ?  phoneC.text = value.profilePhone.toString() : "Enter Number",

                      controller: phoneC),
                ],
              ),
              SizedBox(height: 2.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InfoField(text1: "Address",
                      hint:  value.profileAddress !=null ?  addressC.text = value.profileAddress.toString() : "Enter Address",

                      controller: addressC),
                  SizedBox(width: 10.w,),
                  SubmitButton(
                    width: 10.w,
                    radius: 6,
                    textSize: 14.sp,
                    title: "Save",
                    press: () async{

                      _uploadData(context);
                    },),
                ],
              ),
            ],
          );
        },
      );
    }
    Future<void> _pickAndUploadImage(BuildContext context) async {
      final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
      uploadInput.accept = 'image/*'; // Accept only images

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);

        reader.onLoadEnd.listen((e) async {
          final bytes = reader.result as Uint8List;

          // Set image data using Provider to display in the container
          final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
          cloudinaryProvider.setImageData(bytes);

          ToastMsg().toastMsg('Image uploaded successfully');
        });
      });

      uploadInput.click(); // Trigger the file picker dialog
    }

    Future<void> _uploadData(BuildContext context) async {
      ActionProvider.startLoading();
      final cloudinaryProvider = Provider.of<CloudinaryProvider>(context, listen: false);
      // Email validation to check if it contains @gmail.com
      // if (!emailC.text.contains('@gmail.com')) {
      //   ActionProvider.stopLoading();
      //   ToastMsg().toastMsg('Please enter a valid Gmail address');
      //   return;
      // }

      if (firstNameC.text.isEmpty ||
          lastNameC.text.isEmpty ||
          // emailC.text.isEmpty ||
          phoneC.text.isEmpty ||
          addressC.text.isEmpty ||
          cloudinaryProvider.imageData == null) {
        ActionProvider.stopLoading();
        ToastMsg().toastMsg('Please fill all fields or upload an image',);
        return;
      }

      try {
        await cloudinaryProvider.uploadImage(cloudinaryProvider.imageData!);
        log('Image URL: ${cloudinaryProvider.imageUrl}');
        if (cloudinaryProvider.imageUrl.isNotEmpty) {
          //  Save the data to Firebase
          // Example Firebase code:
          await FirebaseFirestore.instance.collection('admin').doc("XcZeK5QjfBpZkrp03pGD").update({
            'firstName': firstNameC.text,
            'lastName': lastNameC.text,
            'email': emailC.text,
            'address': addressC.text,
            'phoneNumber': phoneC.text,
            'imageUrl': cloudinaryProvider.imageUrl.toString(),
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
            'gender': "male",
          });
          ActionProvider.stopLoading();


          ToastMsg().toastMsg( 'Data uploaded successfully');
        } else {
          ActionProvider.stopLoading();
          cloudinaryProvider.clearImage();
          ToastMsg().toastMsg( 'Image upload failed',);
        }
      } catch (e) {
        log('Error uploading Data: $e');
        ActionProvider.stopLoading();
        cloudinaryProvider.clearImage();
        ToastMsg().toastMsg( 'Failed to upload Data', );
      }
    }

  }

  class InfoField extends StatelessWidget {
    const InfoField({
      super.key,
      required this.text1,
      required this.controller,
       this.hint,
      this.readOnly =false,
    });

    final String text1;
    final String? hint;
    final bool readOnly;
    final TextEditingController controller;

    @override
    Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: text1,
            fontSize: 12.sp, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor,
            fontFamily: AppFonts.semiBold,),
          SizedBox(height: 1.h,),
          SizedBox(
              width: 15.w,
              child: AppTextField(
                readOnly: readOnly,
                hintText: hint ?? "",
                  inputController: controller,

              ))
        ],
      );
    }
  }
