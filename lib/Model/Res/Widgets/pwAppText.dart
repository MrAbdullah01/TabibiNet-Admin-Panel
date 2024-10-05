// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart'; // For loading fonts
// import 'dart:typed_data'; // For loading custom font
//
// class AppText  {
//   final String text;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Color textColor; // Flutter Color
//   final String fontFamily; // Font family for PDF
//   final bool isPdf; // Flag to check if rendering for PDF
//   final int? maxLines; // Optional max lines
//
//   const AppText({
//     required this.text,
//     required this.fontSize,
//     required this.fontWeight,
//     required this.textColor,
//     required this.fontFamily,
//     this.isPdf = false, // Default to false
//     this.maxLines,
//   }) ;
//
//   pw.Widget build() {
//     if (isPdf) {
//       return pw.Text(
//         text,
//         style: pw.TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight == FontWeight.w400
//               ? pw.FontWeight.normal
//               : pw.FontWeight.bold, // Adjust based on your needs
//           color: pw.PdfColor(
//             textColor.red / 255,
//             textColor.green / 255,
//             textColor.blue / 255,
//           ),
//           font: pw.Font.ttf(
//             // Load your custom font here
//             _loadFont(fontFamily), // Assuming you have a method to load the font
//           ),
//         ),
//         maxLines: maxLines, // Optional: if you want to limit lines in PDF
//       );
//     } else {
//       return Text(
//         text,
//         style: TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           color: textColor,
//         ),
//         maxLines: maxLines,
//         overflow: TextOverflow.ellipsis, // Flutter handles max lines
//       );
//     }
//   }
//
//   // Method to load the font
//   Future<Uint8List> _loadFont(String fontFamily) async {
//     final byteData = await rootBundle.load('assets/fonts/$fontFamily.ttf');
//     return byteData.buffer.asUint8List();
//   }
// }
