import 'package:flutter/material.dart';
import 'package:silksong_alarm/viewmodel/alarm_storage_vm.dart';
import 'alarm_item.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AlarmStorageVM(),
      builder: (context, child) => SliverList.builder(
        itemCount: AlarmStorageVM().alarms.length,
        itemBuilder: (context, index) => AlarmItem(
          alarm: AlarmStorageVM().alarms[index],
        ),
      ),
    );
  }
}
