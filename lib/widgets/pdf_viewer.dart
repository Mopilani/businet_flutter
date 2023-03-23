import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart' as pdfx;

class PDFViewer extends StatefulWidget {
  const PDFViewer(this.path, {Key? key}) : super(key: key);
  final String path;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late pdfx.PdfController controller;

  @override
  void initState() {
    super.initState();
    controller = pdfx.PdfController(
      document: pdfx.PdfDocument.openFile(widget.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pdfx.PdfView(controller: controller);
  }
}
