import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_admin_panel/Model/Res/Constants/app_colors.dart';

import '../../../../Model/Res/Constants/app_fonts.dart';

class TableChart extends StatelessWidget {
  const TableChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: const [
          TableRow(
            decoration: BoxDecoration(
              color: greyColor, // Grey background for header
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: AppFonts.medium),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Patient Quantity',
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: AppFonts.medium),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Total Payment',
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: AppFonts.medium),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Heart Checkup',
                  style: TextStyle(
                      fontFamily: AppFonts.medium
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFonts.medium
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '220 MAD',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: AppFonts.medium
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
