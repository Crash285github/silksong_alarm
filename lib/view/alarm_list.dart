import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silksong_alarm/model/alarm_notifier.dart';
import 'package:silksong_alarm/model/persistence.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AlarmNotifier(),
      builder: (context, child) => ListView.builder(
        itemCount: Persistence.alarms.length,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 48,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        DateFormat("yyyy-MM-dd HH:mm").format(
                          Persistence.alarms[index].dateTime,
                        ),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () async {
                    await Alarm.stop(Persistence.alarms[index].id);

                    AlarmNotifier().notify();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
