import 'dart:io';
import 'dart:typed_data';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer(this.path, this.scan, {Key? key}) : super(key: key);
  final String path;
  final bool scan;

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

String lastPath = '';
late ImageProvider imageProvider;
Uint8List? imageBytes;

class _ImageViewerState extends State<ImageViewer> {
  // GlobalKey renderRepaintBoundaryKey = GlobalKey();
  // final double multiplier = 2.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        print('-----------------------');
        if (widget.path != lastPath || widget.scan) {
          // try {
          lastPath = widget.path;
          File imageFile = File(widget.path);
          // imageFile.
          imageBytes = await imageFile.readAsBytes();
          // print(imageBytes.length);
          // } catch (e, s) {
          //   print(e);
          //   File('$documentsPath/Errors/error-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}'
          //           .toString())
          //       .writeAsStringSync('Error: \n $e \n StackTrace: \n $s');
          //   return e;
          // }
          try {
            imageProvider = Image.memory(imageBytes!).image;
          } catch (e, s) {
            print(e);

            // File('$documentsPath/Errors/error-${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}'
            //         .toString())
            //     .writeAsStringSync('Error: \n $e \n StackTrace: \n $s');
          }
        } else {
          print('File Accessed');
        }
        return imageProvider;
      }(),
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(
            child: Text(snap.error.toString()),
          );
        }
        if (snap.hasData) {
          return EasyImageView(
            imageProvider: imageProvider,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
