import 'package:businet_models/businet_models.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'dart:io';

extension ShiftsOverlayes on ProcessesModel {
  Future<void> startDay(DateTime time, BuildContext context) async {
    if (dayStarted) {
      toast(
        'عليك اقفال اليوم السابق اولا',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    businessDay = time.add(const Duration(days: 1));
    dayStarted = true;
    await edit().then((processes) {
      ActionModel.startedDay(processes.businessDay);
      // alert(
      //   context,
      //   AlertType.success,
      //   'تم بدء اليوم',
      //   'اغلاق',
      // );
    });
  }

  Future<void> endDay(BuildContext context) async {
    // print(dayStarted);
    // print(shiftStarted);
    if (!dayStarted) {
      toast(
        'ليم يتم بدء اليوم',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    if (shiftStarted) {
      toast(
        'عليك قفال الوردية المفتوحة حاليا اولا',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    // var subscription = ReceiptModel.backupAndReset();
    // subscription.onError((e) {
    //   alert(
    //     context,
    //     AlertType.error,
    //     'حدث خطأ اثناء اقفال اليوم: $e',
    //     'اغلاق',
    //   );
    // });
    // subscription.onDone(() async {
    //   alert(
    //     context,
    //     AlertType.success,
    //     'تم اقفال اليوم بنجاح',
    //     'اغلاق',
    //   );
    // });
    shiftNumber = 0;
    dayStarted = false;
    await edit().then((processes) {
      ActionModel.endedTheDay(processes.businessDay);
    });

    // businessDay =
    //     DateTime(businessDay.year, businessDay.month, businessDay.day + 1);
    // await edit().then((processes) {
    //   ActionModel.startedDay(processes.businessDay);
    //   // SystemMDBService.repsDb.collection(businessDay.toString());
    // });
  }

  Future<void> startShift(BuildContext context) async {
    if (!dayStarted) {
      toast(
        'ليم يتم بدء اليوم',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    if (shiftStarted) {
      toast(
        'عليك اقفال الوردية $shiftNumber',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    var shiftModel = ShiftModel(
      user: UserModel.stored!,
      number: shiftNumber + 1,
      saledReceiptsIds: <int>[],
      startDateTime: businessDay,
      moneyInventory: <MoneyInventory>[],
    );
    await shiftModel.add().then((_) async {
      shiftStarted = true;
      shiftNumber++;
      await edit().then((processes) {
        ActionModel.startedNewShift(shiftModel, processes.shiftNumber);
      });
    });
  }

  Future<void> endShift(BuildContext context, ShiftModel shiftModel,
      [Function? shiftReportsMakerPrintReport]) async {
    // print(shiftStarted);
    // print(dayStarted);
    if (!shiftStarted) {
      toast(
        'ليم يتم بدء وردية بعد',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    if (!dayStarted) {
      toast(
        'ليم يتم بدء يوم بعد',
        duration: const Duration(seconds: 5),
      );
      return;
    }
    await shiftModel.edit().then((_) async {
      shiftModel.startDateTime = currentDaty;
      shiftStarted = false;
      await edit().then((processes) async {
        // / Print the Shift end report
        try {
          await shiftReportsMakerPrintReport!(shiftModel);
        } catch (e, s) {
          stdout.writeln(e);
          stdout.writeln(s);
        }
        await ActionModel.endedTheShift(
          shiftModel,
          processes.shiftNumber,
        );
        // .then((value) {
        //   alert(
        //     context,
        //     AlertType.success,
        //     'تم اقفال الوردية',
        //     'اغلاق',
        //   );
        // });
      });
    });
  }
}
