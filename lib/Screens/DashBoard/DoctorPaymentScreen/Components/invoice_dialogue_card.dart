import 'package:flutter/material.dart';
import 'package:printing/printing.dart'; // For PDF preview and download
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html; // For web downloads
import '../../../../Model/Res/Constants/app_colors.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_icons.dart';
import '../../../../Model/Res/Widgets/app_text_widget.dart';
import '../../../../Model/Res/Widgets/submit_button.dart';
import 'package:tabibinet_admin_panel/Provider/DashBoard/dash_board_provider.dart';

class InvoiceDialogueCard extends StatefulWidget {
  const InvoiceDialogueCard({super.key});

  @override
  State<InvoiceDialogueCard> createState() => _InvoiceDialogueCardState();
}

class _InvoiceDialogueCardState extends State<InvoiceDialogueCard> {
  Uint8List? pdfData; // To store the generated PDF for preview

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<DashBoardProvider>(context);

    return Scaffold(
      backgroundColor: greyColor,
      body: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "View Invoice",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  isTextCenter: false,
                  textColor: textColor,
                  fontFamily: AppFonts.semiBold,
                ),
                InkWell(
                  onTap: () {
                    pro.setSelectedIndex(5);
                  },
                  child: const Icon(Icons.close, size: 30), // Close button
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: greyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  AppText(
                    text: "9 June, 2024",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    isTextCenter: false,
                    textColor: textColor,
                    fontFamily: AppFonts.semiBold,
                  ),
                  const Spacer(),
                  SubmitButton(
                    width: 10.w,
                    title: "Generate PDF",
                    press: () async {
                      Uint8List generatedPdf = await generatePdfForWeb();
                      setState(() {
                        pdfData = generatedPdf; // Store generated PDF
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            pdfData != null
                ? Expanded(
              // Show PDF Preview using PdfPreview
              child: PdfPreview(
                build: (format) => pdfData!,
              ),
            )
                : const Expanded(
              child: Center(
                child: Text("No PDF generated yet."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Generates the PDF and returns Uint8List for preview and download
  Future<Uint8List> generatePdfForWeb() async {
    final pdf = pw.Document();
    final customColoR = PdfColor.fromInt(0xff0596DE);
    final customColoOr = PdfColor.fromInt(0xffFFAB00);
// Load the custom font
    final ttf = await rootBundle.load("assets/fonts/DejaVuSans.ttf");
    final font = pw.Font.ttf(ttf);

    // Load PNG image (after converting SVG to PNG)
    final Uint8List imageData = await rootBundle
        .load("assets/images/pLogo.png")
        .then((data) => data.buffer.asUint8List());

    final image = pw.MemoryImage(imageData);
    final customColor = const PdfColor(0.0, 0.5, 0.8); // Custom PDF color

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColor.fromHex("#CCCCCC")),
              borderRadius: pw.BorderRadius.circular(15),
              color: PdfColor.fromHex("#F7F7F7"),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 35),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                   pw.Row(
                     mainAxisAlignment: pw.MainAxisAlignment.start,
                     children: [
                       pw.Image(image,width: 50),
                       pw.RichText(
                         text: pw.TextSpan(
                           children: [
                             pw.TextSpan(
                               text: 'Tabibi ', // First word
                               style: pw.TextStyle(
                                 color: customColoR, // Color for 'Tabibi'
                                 fontSize: 24,
                                 font: font,// You can adjust font size here
                               ),
                             ),
                             pw.TextSpan(
                               text: 'Net', // Second word
                               style: pw.TextStyle(
                                 color: customColoOr, // Different color for 'Net'
                                 fontSize: 24,
                                 font: font,// Same font size for consistency
                               ),
                             ),
                           ],
                         ),
                       ),
                     ]
                   ),
                    pw.Column(
                      children: [
                        const RowText(text1: "Invoice No: ", text2: "#123456")
                            .build(),
                        const RowText(text1: "Issued Date: ", text2: "11 June")
                            .build(),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    const ColumnText(
                      headingText: "Billing From",
                      text1: "Mian Uzair",
                      text2: "New York, America",
                      text3: "",
                    ).build(),
                    const ColumnText(
                      headingText: "Billing To",
                      text1: "Dr. John",
                      text2: "New York, America",
                      text3: "",
                    ).build(),

                    const ColumnText(
                      headingText: "Payment Method",
                      text1: "Debit Card",
                      text2: "xxxxxxxxxx-251",
                      text3: "HDFC Bank",
                    ).build(),
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text("Invoice Details", style: const pw.TextStyle(fontSize: 14)),
                pw.SizedBox(height: 10),
                TableChart().build(),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Note: ",
                          style: pw.TextStyle(fontSize: 10,font: font,),
                        ),
                        pw.SizedBox(width: 1.w,),
                        pw.SizedBox(
                          width: 250,
                          child: pw.Text(
                            "An account of the present illness, "
                                "which includes the circumstances surrounding "
                                "the onset of recent health changes.",
                            style: pw.TextStyle(
                              fontSize: 9,
                              font: font,
                            ),
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        const RowText(text1: "Subtotal: ", text2: "220 MAD").build(),
                        const RowText(text1: "Discount: ", text2: "-10%").build(),
                        const RowText(text1: "Total: ", text2: "205 MAD").build(),
                      ],
                    ),
                  ]
                )
              ],
            ),
          );
        },
      ),
    );

    // Save PDF as Uint8List
    return await pdf.save();
  }
}

class RowText {
  const RowText({
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  pw.Widget build() {
    return pw.Row(
      children: [
        pw.Text(
          text1,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.black,
          ),
        ),
        pw.SizedBox(width: 10),
        pw.Text(
          text2,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey,
          ),
        ),
      ],
    );
  }
}

class ColumnText {
  const ColumnText({
    required this.headingText,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  final String headingText;
  final String text1;
  final String text2;
  final String text3;

  pw.Widget build() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          headingText,
          style: pw.TextStyle(
            fontSize: 16,
              color: PdfColors.black,
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          text1,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey,
          ),
        ),
        pw.Text(
          text2,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey,
          ),
        ),
        pw.Text(
          text3,
          style: pw.TextStyle(
            fontSize: 10,
            color: PdfColors.grey,
          ),
        ),
      ],
    );
  }
}

class TableChart {
  pw.Widget build() {
    return pw.Table.fromTextArray(
      headerDecoration: pw.BoxDecoration(
        color: PdfColors.grey.shade(0.1),
      ),
      headers: ["Description", "Patient Quantity", "Total Payment"],
      data: [
        ["Heart Checkup", "1",  "200 MAD"],
      ],
    );
  }
}
