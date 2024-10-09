import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_admin_panel/Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Model/Res/components/suggestionContainer.dart';
import 'package:tabibinet_admin_panel/Provider/Appointment/appointment_provider.dart';
import '../../../Model/Res/Constants/app_colors.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import '../../../Provider/HealthCare/health_care_provider.dart';
import '../../../Provider/Patient/patient_provider.dart';
import 'Components/doctor_profile_card.dart';

class HealthCareScreen extends StatelessWidget {
  HealthCareScreen({super.key});

  final searchC = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HealthCareProvider>(context);
    final patientProvider =
        Provider.of<PatientProvider>(context, listen: false);
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
          SizedBox(
            width: 100.w,
            height: 50,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('doctorsSpecialty')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No Specialty found'));
                }

                final specialty = snapshot.data!.docs;

                return ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: specialty.length,
                  itemBuilder: (context, index) {
                    final isSelected = provider.selectIndex == index;
                    final specialties = specialty[index].data();
                    final specialtyId = specialty[index].id;

                    return  SuggestionContainer(
                      text: specialties["specialty"],
                      bgColor: isSelected ? themeColor : bgColor,
                      textColor: isSelected ? bgColor : themeColor,
                      radius: 6,
                      width: 16.w,
                      onTap: () {
                        log("doctor id is:: $specialtyId");
                        provider.setIndex(index);
                        provider.setSelectedSpecialty(specialties["id"]);
                        _scrollController;
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 2.h,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('userType', isEqualTo: "Health Professional")
                .where('specialityId',
                    isEqualTo: provider.selectedSpecialtyId.toString())
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
}
