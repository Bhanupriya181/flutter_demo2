import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:async';
import 'common/colors.dart';

class PDFViewerScreen extends StatefulWidget {
  final String path;

  const PDFViewerScreen({Key? key, required this.path}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int totalPages = 0;
  int currentPage = 0;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    debugPrint("PDF Path ::::::::::::::: ${widget.path}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: colorPrimary),
          title: Text('PDF View',style:
          TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize:18 ),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),),
            shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(22),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              PDFView(
                filePath: widget.path,
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: false,
                onRender: (pages) {
                  setState(() {
                    totalPages = pages!;
                    isReady = true;
                  });
                },
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onPageChanged: (int? page, int? total) {
                  setState(() {
                    currentPage = page!;
                  });
                  print('page change: $currentPage/$totalPages');
                },
              ),
              !isReady
                  ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorPrimary),
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
