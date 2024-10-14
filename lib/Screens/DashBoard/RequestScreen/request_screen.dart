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
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];

                return RequestCard(
                  withdrawId: doctor['withdrawID'],
                  doctorId: doctor['userUID'],
                  doctorName: doctor['name'],
                  withdrawAmount: doctor['amount'],
                  doctorSpeciality: doctor["speciality"],
                  doctorImage: doctor["profile"] ?? Image.asset(AppAssets.doctorImage),
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
        .collection('withdrawRequests')
        .where('status', isEqualTo: 'pending')  // filter for pending accounts
        .snapshots();
  }
}
