import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/Res/Constants/app_assets.dart';
import '../../../Model/Res/Widgets/AppTextField.dart';
import 'Components/request_card.dart';

class RequestScreen extends StatelessWidget {
  RequestScreen({super.key});

  final TextEditingController searchC = TextEditingController();

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
          ],
        ),
        SizedBox(height: 2.w,),
        StreamBuilder(
          stream: getDoctorsStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || (snapshot.data as QuerySnapshot).docs.isEmpty) {
              return const Center(child: Text("No requests available"));
            }

            final doctors = (snapshot.data as QuerySnapshot).docs;  // Cast snapshot.data

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                mainAxisExtent: 35.h,
                crossAxisSpacing: 20,
              ),
              itemCount: doctors.length,  // Set the number of items
              itemBuilder: (context, index) {
                final doctor = doctors[index];  // Access individual document

                return RequestCard(
                  doctorId: doctor.id,
                  doctorName: doctor['name'],  // Access 'name' field
                  doctorSpeciality: doctor["speciality"],  // Access 'speciality' field
                  doctorImage: doctor["profileUrl"] ?? Image.asset(AppAssets.doctorImage),  // Handle image field
                );
              },
            );
          },
        )
      ],
    );
  }

  getDoctorsStatus() {
    return FirebaseFirestore.instance
        .collection('users')  // assuming doctors are stored in the 'users' collection
        .where('userType', isEqualTo: 'Health Professional')  // filter for users who are doctors
        .where('accountStatus', isEqualTo: 'pending')  // filter for pending accounts
        .snapshots();
  }
}
