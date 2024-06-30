import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/days_enum.dart';
import 'package:silksong_alarm/viewmodel/alarm_storage_vm.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

class AlarmItem extends StatefulWidget {
  final Alarm alarm;
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

  String get timeLeft {
    final difference = widget.alarm.nextDateTime.difference(DateTime.now());

    final days = difference.inDays;
    if (days > 1) return "in $days days";
    if (days == 1) return "in a day";

    final hours = difference.inHours;
    if (hours > 1) return "in $hours hours";
    if (hours == 1) return "in an hour";

    return "soon 🤡";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        onDismissed: (_) async => await AlarmStorageVM().remove(widget.alarm),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(32),
            bottomLeft: Radius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 2.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timeLeft,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.5),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat("HH:mm").format(widget.alarm.dateTime),
                        style: TextStyle(
                          fontSize: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    ...DaysEnum.values.map(
                      (final day) => Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: BeveledCard(
                            borderRadius: BorderRadius.circular(512),
                            color: Theme.of(context).colorScheme.primary,
                            borderWidth: .5,
                            child: ImageFiltered(
                              imageFilter: ColorFilter.mode(
                                widget.alarm.days.contains(day.index)
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                BlendMode.difference,
                              ),
                              child: Center(
                                child: Text(
                                  day.name[0].toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
