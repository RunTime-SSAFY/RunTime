import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_android/src/service/theme_service.dart';
import 'package:front_android/theme/components/bottom_navigation.dart';
import 'package:front_android/theme/components/svg_icon.dart';
import 'package:front_android/util/lang/generated/l10n.dart';

class RecordView extends ConsumerWidget {
  const RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          S.current.record,
          style: ref.typo.appBarMainTitle,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: SvgIcon(
              'bell',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          // onDateChange: (date) {
          //   // New date selected
          //   setState(() {
          //     _selectedValue = date;
          //   });
          // },
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
