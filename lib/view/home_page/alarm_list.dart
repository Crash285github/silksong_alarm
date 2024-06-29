// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/services/alarm_notifier.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

class AlarmList extends StatelessWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AlarmNotifier(),
      builder: (context, child) => SliverList.builder(
        itemCount: Persistence.alarms.length,
        itemBuilder: (context, index) => AlarmItem(
          alarm: Persistence.alarms[index],
        ),
      ),
    );
  }
}

class AlarmItem extends StatefulWidget {
  final AlarmSettings alarm;
  const AlarmItem({
    super.key,
    required this.alarm,
  });

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  bool reached = false;

  final key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await Alarm.stop(widget.alarm.id);
          AlarmNotifier().notify();
        },
        onUpdate: (details) {
          if (details.reached != reached) {
            setState(() => reached = details.reached);
          }
        },
        background: const SizedBox.shrink(),
        secondaryBackground: AnimatedOpacity(
          duration: Durations.medium1,
          opacity: reached ? 1 : .2,
          child: const _DeleteBg(),
        ),
        child: BeveledCard(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  DateFormat("yyyy-MM-dd HH:mm").format(widget.alarm.dateTime),
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DeleteBg extends StatelessWidget {
  const _DeleteBg();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Delete",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
