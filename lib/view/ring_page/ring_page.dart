import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/services/alarm_storage_vm.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

class RingPage extends StatelessWidget {
  final Alarm alarm;
  const RingPage({
    super.key,
    required this.alarm,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Silksong News???"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: 1,
                    activeColor: Theme.of(context).colorScheme.primary,
                    thumbColor: Theme.of(context).colorScheme.secondary,
                    onChanged: (value) {},
                  ),
                  Text(
                    "0:00 / 1:33",
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .4,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Card(
                    elevation: 4,
                    shadowColor: Theme.of(context).colorScheme.tertiary,
                    surfaceTintColor: Theme.of(context).colorScheme.tertiary,
                    shape: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: .5,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      overlayColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.tertiary.withOpacity(.2),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: FittedBox(
                          child: Text(
                            "Snooze\n(5m)",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .5,
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BeveledCard(
                    borderRadius: BorderRadius.circular(double.infinity),
                    color: Theme.of(context).colorScheme.primary,
                    onTap: () async {
                      await AlarmStorageVM().remove(alarm);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Text(
                        "Stop",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
