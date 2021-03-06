import 'package:ankev928/pages/omnomcom/purchase_page.dart';
import 'package:ankev928/shared/styling/flushbar.dart';
import 'package:flushbar/flushbar.dart';
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
          if(qrText.contains("https://www.proto.utwente.nl/qr")) {
            Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new PurchasePage(qrText)));
          } else {
            this.controller.resumeCamera();
            getFlushbar(context, "QR code was not recognized as an omnomcom QR code, please try again", 10, Theme.of(context).errorColor);
          }
        }
      });
    });
  }
}
