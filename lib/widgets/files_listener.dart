import 'dart:io';

import 'package:flutter/material.dart';

import 'image_viewer.dart';
import 'pdf_viewer.dart';
import 'text_viewer.dart';

class FilesListener extends StatelessWidget {
  const FilesListener({
    Key? key,
    required this.editMode,
    required this.watchDirectoryPath,
  }) : super(key: key);
  final bool editMode;
  final String watchDirectoryPath;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileSystemEvent>(
      stream: Directory(watchDirectoryPath).watch(
        events: FileSystemEvent.create,
      ),
      builder: (context, snap) {
        // print('===================');
        if (snap.hasError) {
          if (snap.error.toString().contains('path = ' '')) {
          } else {
            return Center(
              child: Text(
                '(${snap.error}) :حدث خطأ ما',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        }

        var file = File(snap.data!.path);
        if (snap.hasData) {
          Widget widg = const Center(child: Text('لا يوجد شيء'));
          return FutureBuilder(
            future: () async {
              await Future.delayed(
                const Duration(milliseconds: 750),
              );

              final fileExt = file.path.split('.').last;
              // print('fileExt $fileExt');
              if (fileExt == 'txt') {
                widg = Column(
                  children: [
                    // Text(
                    //   'العملية رقم: ${editMode ? ometa!.opNumber : OperationViewModel().opNumber}',
                    // ),
                    TextViewer(file.path),
                  ],
                );
              } else if (fileExt == 'pdf') {
                widg = Column(
                  children: [
                    // Text(
                    //   'العملية رقم: ${editMode ? ometa!.opNumber : OperationViewModel().opNumber}',
                    // ),
                    Expanded(
                      child: PDFViewer(file.path),
                    ),
                  ],
                );
              } else if (fileExt == 'jpg') {
                widg = Column(
                  children: [
                    // Text(
                    //   'العملية رقم: ${OperationViewModel().opNumber}', ),
                    Expanded(
                      child: ImageViewer(
                        file.path,
                        false,
                      ),
                    ),
                  ],
                );
              } else {
                print('Deleting File');
              }
            }(),
            builder: (context, snap2) {
              print(snap2.error);
              print(snap2.stackTrace);
              return widg;
            },
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Text(
              //     'العملية رقم: ${editMode ? ometa?.opNumber : OperationViewModel().opNumber}'),
              Text(
                'في انتظار مسح المستند',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              Icon(Icons.timelapse, size: 40),
            ],
          ),
        );
      },
    );
  }

  Widget loadingAssetWidget(String assetName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //     'العملية رقم: ${editMode ? ometa!.opNumber : OperationViewModel().opNumber}'),
          const Text(
            'جاري تحميل المستند',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            assetName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
