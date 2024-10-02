import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_fonts.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_icons.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/app_text_widget.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';
import '../../../Provider/profileProvider/profileInfo.dart';
import '../../../Screens/Start/LogInScreen/login_screen.dart';
import '../Constants/app_assets.dart';
import '../Constants/app_colors.dart';
import '../Constants/firebase.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileInfoProvider>(context, listen: false);

    // Initialize the profile listener when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.listenToProfileInfo();
    });
    final dashP = Provider.of<DashBoardProvider>(context,listen: false);

    return Column(
      children: [
        Consumer<ProfileInfoProvider>(
        builder: (context, profileInfo, child) {
          return Container(
            width: 100.w,
            height: 10.h,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                color: themeColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 6)
                  )
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _showCustomPopupMenu(context, _buildProfilePopUp(context));
                  },
                  child: CircleAvatar(
                    backgroundImage: profileInfo.profileImageUrl != null
                        ? NetworkImage(profileInfo.profileImageUrl!)
                        : const AssetImage(
                        AppAssets.profileImage) as ImageProvider,
                  ),
                ),
                const SizedBox(width: 10,),
                // InkWell(
                //     onTap: () {
                //       _showCustomPopupMenu(context, _buildNotificationList());
                //     },
                //     child: SvgPicture.asset(AppIcons.bellIcon, height: 20,)),
                // const SizedBox(width: 10,),
                InkWell(
                    onTap: () {
                      dashP.setSelectedIndex(16);
                    },
                    child: SvgPicture.asset(AppIcons.settingIcon, height: 20,)),
              ],
            ),
          );
        }
        ),
        SizedBox(
          width: 100.w,
          height: 10.h,
          child: Stack(
            children: [
              SizedBox(
                  width: 100.w,
                  height: 10.h,
                  child: Image.asset(AppAssets.bgImage,fit: BoxFit.cover)),
              Container(
                width: 100.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: themeColor.withOpacity(0.9),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _showCustomPopupMenu(BuildContext context,Widget child) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      color: bgColor,
      surfaceTintColor: bgColor,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 40, // Positioning the popup near the notification icon
        kToolbarHeight,
        0,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: child, // Prevents dismissing on tap
        ),
      ],
    );
  }

  Widget _buildProfilePopUp(context){
    final dashP = Provider.of<DashBoardProvider>(context,listen: false);
    final profileProvider = Provider.of<ProfileInfoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.listenToProfileInfo();
    });
    return Consumer<ProfileInfoProvider>(
        builder: (context, profileInfo, child) {

          return Center(
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10)
          ),
          height: 200,
          width: 120,
          child: Column(
            children: [
               CircleAvatar(
                radius: 20,
                backgroundImage: profileInfo.profileImageUrl != null
                    ? NetworkImage(profileInfo.profileImageUrl!)
                    : const AssetImage(AppAssets.profileImage) as ImageProvider,
              ),
              AppText(
                  text: profileInfo.profileName.toString() + profileInfo.profileLastName.toString(),
                  fontSize: 10.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: themeColor,
                  fontFamily:  AppFonts.regular),
              AppText(
                  text: profileInfo.profileEmail.toString(),
                  fontSize: 10.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontFamily:  AppFonts.regular,maxLines: 1,),
              InkWell(
                onTap: () {
                  dashP.setSelectedIndex(11);
                  Navigator.pop(context);
                  },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.visible2Icon,
                        height: 15,
                        colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),),
                      SizedBox(width: 1.h,),
                      AppText(
                          text: "View Profile",
                          fontSize: 10.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor, fontFamily: AppFonts.medium,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dashP.setSelectedIndex(12);
                  Navigator.pop(context);
                  },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.personIcon,
                        height: 15,
                        colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),),
                      SizedBox(width: 1.h,),
                      AppText(
                          text: "Edit Profile",
                          fontSize: 10.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor, fontFamily: AppFonts.medium,)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  auth.signOut().whenComplete(() {
                    Get.offAll(()=>LoginScreen());
                  },);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppIcons.logout2Icon,
                        height: 15,
                        colorFilter: const ColorFilter.mode(textColor, BlendMode.srcIn),),
                      SizedBox(width: 1.h,),
                      AppText(
                          text: "Log Out",
                          fontSize: 10.sp, fontWeight: FontWeight.w600,
                          isTextCenter: false, textColor: textColor, fontFamily: AppFonts.medium,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );}
    );
  }

  Widget _buildNotificationList() {
    return SizedBox(
      width: 50.w,
      height: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                    text: "Notifications",
                    fontSize: 12.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: textColor,
                    fontFamily: AppFonts.semiBold,
                ),
                TextButton(
                  onPressed: () {
                    // Clear all functionality
                  },
                  child: AppText(
                    text: "Clear All",
                    fontSize: 10.sp, fontWeight: FontWeight.w500,
                    isTextCenter: false, textColor: Colors.grey,
                    fontFamily: AppFonts.semiBold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          SizedBox(height: 8.sp,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                  text: "New Payment",
                  fontSize: 10.sp, fontWeight: FontWeight.w500,
                  isTextCenter: false, textColor: themeColor,
                  fontFamily: AppFonts.medium
              ),
              AppText(
                  text: "New Register",
                  fontSize: 10.sp, fontWeight: FontWeight.w500,
                  isTextCenter: false, textColor: textColor,
                  fontFamily: AppFonts.medium,
              ),
            ],
          ),
          SizedBox(height: 8.sp,),
          Expanded(
            child: ListView.builder(
              itemCount: 6, // Number of notifications
              itemBuilder: (context, index) {
                return _notificationItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationItem() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage(AppAssets.profileImage), // Replace with user image
        radius: 24,
      ),
      title: AppText(
          text: "Tarvis Tramble",
          fontSize: 10.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: textColor
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
              text: "Sent a amount of \$210 of his apointment",
              fontSize: 10.sp, fontWeight: FontWeight.w500,
              isTextCenter: false, textColor: Colors.grey
          ),
          const SizedBox(height: 4),
          AppText(
              text: "Dr.John",
              fontSize: 10.sp, fontWeight: FontWeight.w500,
              isTextCenter: false, textColor: themeColor
          ),
        ],
      ),
      trailing: AppText(
          text: "8:30pm",
          fontSize: 6.sp, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: textColor
      ),
      isThreeLine: true,
      onTap: () {
        // Handle notification tap
      },
    );
  }
}
