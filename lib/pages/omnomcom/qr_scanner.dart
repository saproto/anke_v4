import 'file:///C:/Users/Marloes%20ten%20Hage/Documents/commisies/beheer/saproto_final_really/lib/pages/omnomcom/purchase_page.dart';
import 'package:ankev928/shared/launcURL.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatefulWidget {
  @override
  _QrScannerPage createState() => _QrScannerPage();
}

class _QrScannerPage extends State<QrScannerPage> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Theme.of(context).primaryColor,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              onQRViewCreated: _onQRViewCreate,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        this.controller.pauseCamera();
        if (qrText != null) {
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new PurchasePage(qrText)));
        }
      });
    });
  }
}
