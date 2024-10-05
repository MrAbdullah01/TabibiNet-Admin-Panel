import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../../../../Model/Res/Constants/app_fonts.dart';
import '../../../../Model/Res/Constants/app_colors.dart';

class TableChart {
  const TableChart();

  // Method to build a pw.Widget (pw.Table)
  pw.Widget build() {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(16.0),
      child: pw.Table(
        border: pw.TableBorder.all(color: PdfColors.grey),
        columnWidths: const <int, pw.TableColumnWidth>{
          0: pw.FlexColumnWidth(1),
          1: pw.FlexColumnWidth(1),
          2: pw.FlexColumnWidth(1),
        },
        children: [
          pw.TableRow(
            decoration: pw.BoxDecoration(
              color: PdfColors.grey, // Grey background for header
            ),
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  'Description',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  'Patient Quantity',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  'Total Payment',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  'Heart Checkup',
                  style: pw.TextStyle(
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  '1',
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                  ),
                ),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(
                  '220 MAD',
                  textAlign: pw.TextAlign.right,
                  style: pw.TextStyle(
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
