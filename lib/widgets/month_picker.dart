import 'package:flutter/material.dart';
import 'package:updater/updater.dart' as updater;

class MonthPicker extends StatelessWidget {
  final void Function(String value) onChanged;
  MonthPicker({
    super.key,
    required this.onChanged,
    required this.selectedYear,
    required this.selectedMonth,
  }) {
    for (var i = 1990; i < 2101; i++) {
      years.add(i);
    }
    for (var i = 1; i < 13; i++) {
      months.add(i);
    }
    // print(years);
    // print(months);
  }

  final List<int> years = [];
  final List<int> months = [];
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return updater.UpdaterBlocWithoutDisposer(
      updater: ThisPageUpdater(
        init: '',
        updateForCurrentEvent: true,
      ),
      update: (context, s) {
        return SizedBox(
          width: 300,
          child: Row(
            children: [
              Expanded(
                child: DropdownButton(
                  value: selectedYear,
                  items: [
                    ...years.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        onTap: () {
                          selectedYear = e;
                          onChanged(DateTime(
                            selectedYear,
                            selectedMonth,
                            2,
                          ).toString());
                          ThisPageUpdater().add('');
                        },
                        child: Text('$e'),
                      );
                    }).toList(),
                  ],
                  onChanged: (v) {},
                ),
              ),
              Expanded(
                child: DropdownButton(
                  value: selectedMonth,
                  items: [
                    ...months.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        onTap: () {
                          selectedMonth = e;
                          onChanged(DateTime(
                            selectedYear,
                            selectedMonth,
                            2,
                          ).toString());
                          ThisPageUpdater().add('');
                        },
                        child: Text('$e'),
                      );
                    }).toList(),
                  ],
                  onChanged: (v) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ThisPageUpdater extends updater.Updater {
  ThisPageUpdater({
    init,
    bool updateForCurrentEvent = false,
  }) : super(init, updateForCurrentEvent: updateForCurrentEvent);
}
