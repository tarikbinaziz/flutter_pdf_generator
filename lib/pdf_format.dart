import 'dart:io';

import 'package:flutter_pdf_generate/model/payment_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PaymentPDFGenerator {
  static Future<void> generateAndSavePDF(PaymentStatement data) async {
    final pdf = pw.Document();

    final logo = await networkImage('https://picsum.photos/200/300');

    pdf.addPage(
      pw.MultiPage(
        build:
            (context) => [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(logo, height: 50),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Payment Statement',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      pw.Text('January 2025'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Payment Summary',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                columnWidths: {
                  0: pw.FlexColumnWidth(2),
                  1: pw.FlexColumnWidth(1),
                },
                children: [
                  _summaryRow("QR Code Booking Earnings", "\$0.00"),
                  _summaryRow(
                    "Online Booking Earnings",
                    "\$${data.onlineBookingEarnings.toStringAsFixed(2)}",
                  ),
                  _summaryRow(
                    "Total Earnings",
                    "\$${data.totalEarnings.toStringAsFixed(2)}",
                    isBold: true,
                    color: PdfColors.green,
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Booking Details',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: ['Booking ID', 'Items', 'Amount', 'Source', 'Status'],
                data:
                    data.bookings.map((item) {
                      return [
                        item.id,
                        item.items.toString(),
                        "\$${item.amount.toStringAsFixed(2)}",
                        item.source,
                        item.status,
                      ];
                    }).toList(),
                headerStyle: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                cellStyle: pw.TextStyle(fontSize: 10),
                cellAlignment: pw.Alignment.centerLeft,
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              ),
            ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/payment_statement.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);

    print('PDF saved: ${file.path}');
  }

  static pw.TableRow _summaryRow(
    String title,
    String value, {
    bool isBold = false,
    PdfColor? color,
  }) {
    return pw.TableRow(
      children: [
        pw.Text(title),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }
}

final Map<String, dynamic> sampleApiData = {
  'onlineBookingEarnings': 466.28,
  'totalEarnings': 466.28,
  'bookings': [
    {
      'id': '677487dcc7d315803e82943',
      'items': 3,
      'amount': 12.00,
      'source': 'Online',
      'status': 'paid',
    },
    {
      'id': '67749c32c7d315803e829ba',
      'items': 8,
      'amount': 32.00,
      'source': 'Online',
      'status': 'paid',
    },
    // ... add the rest
  ],
};

/// Call the function to generate and save the PDF

// PaymentPDFGenerator.generateAndSavePDF(sampleApiData);
