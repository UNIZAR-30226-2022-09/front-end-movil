import 'package:alejandria/themes/app_theme.dart';
import 'package:alejandria/widgets/bottom_line_appbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatelessWidget {
  const PDFScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final String user = arguments['user'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Post de $user',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary)),
        bottom: BottomLineAppBar(), //Color.fromRGBO(68, 114, 88, 1),
      ),
      body: SfPdfViewer.network(
        arguments['pdf'],
        canShowScrollHead: false,
      ),
    );
  }
}
