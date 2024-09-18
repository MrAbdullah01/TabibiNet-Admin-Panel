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
          ],),
        SizedBox(height: 2.w,),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                mainAxisExtent: 35.h,
                crossAxisSpacing: 20,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return const RequestCard(
                doctorName: "Dr Jenifer",
                doctorSpeciality: "Cardiologist",
                doctorImage: AppAssets.doctorImage,
              );
            },
        )
      ],
    );
  }
}
