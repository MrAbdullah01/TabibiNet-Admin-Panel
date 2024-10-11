import 'dart:developer';

import 'package:anchor_scroll_controller/anchor_scroll_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/suggestionContainer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import 'package:tabibinet_admin_panel/Provider/actionProvider/Authen_provider.dart';
import 'package:tabibinet_admin_panel/global_provider.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Provider/HealthCare/health_care_provider.dart';
import '../../../Provider/Patient/patient_provider.dart';
import 'Components/doctor_profile_card.dart';

class HealthCareScreen extends StatefulWidget {
  HealthCareScreen({super.key});

  @override
  State<HealthCareScreen> createState() => _HealthCareScreenState();
}

class _HealthCareScreenState extends State<HealthCareScreen> {
  final searchC = TextEditingController();

  final AnchorScrollController _scrollController = AnchorScrollController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final healthCareProvider = Provider.of<AuthenticationProvider>(context, listen: false);
    healthCareProvider.fetchSpecialties();
    _scrollToSelectedIndex(context);
  }

  final specialty = [
    {
      "id" : "1",
      "name" : "Cardiologist"
    },
    {
      "id" : "1",
      "name" : "Cardiologist"
    },
    {
      "id" : "1",
      "name" : "Cardiologist"
    },
    {
      "id" : "1",
      "name" : "Cardiologist"
    },
    {
      "id" : "1",
      "name" : "Cardiologist"
    },
    {
      "id" : "1",
      "name" : "Cardiologist"
    }

  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthCareProvider>(context);
    final providerP = Provider.of<AuthenticationProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context,listen: false);
    _scrollToSelectedIndex(context);
    return Scaffold(
      backgroundColor: greyColor,
      body: ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              SizedBox(
                  width: 20.w,
                  child: AppTextField2(
                    inputController: searchC,
                    hintText: "Search by Name",
                    prefixIcon: Icons.search,
                    onChanged: (value) {
                      patientProvider.setDocSearchQuery(
                          value); // Update search query in provider
                    },
                  )),
              // SizedBox(
              //   width: 2.h,
              // ),
              // SizedBox(
              //     width: 20.w,
              //     child: AppTextField2(
              //       inputController: searchC,
              //       hintText: "Search by Categories",
              //       prefixIcon: Icons.search,
              //     )),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),


          // Use the fetched specialties
          SizedBox(
            width: 100.w,
            height: 50,
            child: providerP.specialties.isEmpty
                ? const Center(child: CircularProgressIndicator()) // Show loader if list is empty
                : ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: providerP.specialties.length,
              itemBuilder: (context, index) {
                final isSelected = provider.selectIndex == index;
                final specialty = providerP.specialties[index];

                return SuggestionContainer(
                  text: specialty["specialty"],
                  bgColor: isSelected ? themeColor : bgColor,
                  textColor: isSelected ? bgColor : themeColor,
                  radius: 6,
                  width: 16.w,
                  onTap: () {
                    log("Selected specialty id is: ${specialty['id']}");
                    provider.setIndex(index);
                    provider.setSelectedSpecialty(
                      specialty["id"],
                      specialty["specialty"],
                    );
                    _scrollToSelectedIndex(context);
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),


          // Container(
          //   width: 100.w,
          //   height: 50,
          //   child: ListView.separated(
          //     controller: _scrollController,
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     itemCount: specialty.length,
          //     itemBuilder: (context, index) {
          //       final isSelected = provider.selectIndex == index;
          //       final specialties = specialty[index]['name'];
          //       final specialtyId = specialty[index]['id'];
          //
          //       return  AnchorItemWrapper(
          //         index: index,
          //         controller: _scrollController,
          //         child: SuggestionContainer(
          //           text: specialties.toString(),
          //           bgColor: isSelected ? themeColor : bgColor,
          //           textColor: isSelected ? bgColor : themeColor,
          //           radius: 6,
          //           width: 16.w,
          //           onTap: () {
          //             log("doctor id is:: $specialtyId");
          //             provider.setIndex(index);
          //             provider.setSelectedSpecialty(
          //               specialties.toString(),
          //               specialties.toString()  ,
          //             );
          //
          //             _scrollToSelectedIndex(context);
          //
          //           },
          //         ),
          //       );
          //     },
          //     separatorBuilder: (context, index) => const SizedBox(
          //       width: 20,
          //     ),
          //   ),
          // ),

          SizedBox(
            height: 2.h,
          ),
            StreamBuilder<QuerySnapshot>(
              stream: provider.selectedSpecialtyId ==null ?
              FirebaseFirestore.instance
                  .collection('users')
                  .where('userType', isEqualTo: "Health Professional")
                  .snapshots() :

                  provider.name == "All" ?
                  FirebaseFirestore.instance
                      .collection('users')
                      .where('userType', isEqualTo: "Health Professional")
                      .snapshots() :

              FirebaseFirestore.instance
                  .collection('users')
                  .where('userType', isEqualTo: "Health Professional")
                  .where('specialityId', isEqualTo: provider.selectedSpecialtyId)

                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found'));
                }
                patientProvider.setDocs(snapshot.data!.docs);
                return Consumer<PatientProvider>(
                    builder: (context, provider, child) {
                  final filteredDocs = provider.filteredDoc;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 305),
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final users = filteredDocs[index];
                      return DoctorProfileCard(
                        users: users,
                      );
                    },
                  );
                });
              },
            ),
        ],
      ),
    );
  }

  void _scrollToSelectedIndex(BuildContext context) {
    final healthCareP = Provider.of<HealthCareProvider>(context, listen: false);

    _scrollController.scrollToIndex(index: healthCareP.selectIndex);

  //   log("Running ScrollToSelectedIndex ");
  //   log("Index:: ${healthCareP.selectIndex}");
  //
  //
  //
  //   if (_scrollController.hasClients) {
  //     // Dynamically calculate the item width and spacing
  //     double itemWidth = 16.w;  // Width of each item
  //     double spacing = 20.0;   // Space between items
  //
  //     // Calculate the scroll position
  //     double scrollOffset = (itemWidth + spacing) * healthCareP.selectIndex;
  //
  //     // Animate to the new position
  //     _scrollController.animateTo(
  //       scrollOffset,
  //       duration: Duration(milliseconds: 300), // Animation duration
  //       curve: Curves.easeInOut, // Scroll animation curve
  //     );
  //   }
  // }
}

  }
