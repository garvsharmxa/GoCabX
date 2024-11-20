// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class qrScanner extends StatelessWidget {
//   const qrScanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         String qrCode = await FlutterBarcodeScanner.scanBarcode(
//           '#C62828',
//           'Cancel',
//           true,
//           ScanMode.QR,
//         );
//       },
//       child: const Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.qr_code, size: 150, color: Colors.grey),
//           SizedBox(height: 8),
//           Text('स्कैन क्रेन',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
// }
