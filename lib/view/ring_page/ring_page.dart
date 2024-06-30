import 'package:flutter/material.dart';
import 'package:silksong_alarm/model/alarm.dart';
import 'package:silksong_alarm/model/news_background_worker/silksong_news_data.dart';
import 'package:silksong_alarm/model/persistence.dart';
import 'package:silksong_alarm/viewmodel/alarm_storage_vm.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

class RingPage extends StatefulWidget {
  final Alarm alarm;
  const RingPage({
    super.key,
    required this.alarm,
  });

  @override
  State<RingPage> createState() => _RingPageState();
}

class _RingPageState extends State<RingPage> {
  SilksongNewsData? data;

  @override
  void initState() {
    super.initState();
    Persistence.getSilksongNewsData().then(
      (value) => setState(() => data = value),
    );
  }

  String get formattedDuration {
    final duration = data?.seconds;
    if (duration == null) return "";

    int minutes = duration ~/ 60;
    int seconds = duration % 60;

    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedDuration,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TweenAnimationBuilder<double>(
                        duration: Duration(seconds: data?.seconds ?? 0),
                        tween: Tween<double>(
                          begin: 0,
                          end: data?.seconds.toDouble() ?? 0.0,
                        ),
                        builder: (context, value, child) => BeveledCard(
                          child: LinearProgressIndicator(
                            minHeight: 24,
                            value: value / (data?.seconds ?? 1),
                          ),
                        ),
                      ),
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
                          Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(.2),
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
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
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
                        await AlarmStorageVM().stop(widget.alarm);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Text(
                          "Stop",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
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
      ),
    );
  }
}
