import 'package:flutter/material.dart';

class SetAlarmButton extends StatelessWidget {
  const SetAlarmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async => await _setAlarm(context),
      child: const Icon(Icons.alarm_add),
    );
  }
}

Future<void> _setAlarm(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (context) => const _SetAlarmSheet(),
  );
}

class _SetAlarmSheet extends StatefulWidget {
  const _SetAlarmSheet();

  @override
  State<_SetAlarmSheet> createState() => _SetAlarmSheetState();
}

class _SetAlarmSheetState extends State<_SetAlarmSheet> {
  DateTime dateTime = DateTime.now().add(
    const Duration(minutes: 5),
  );

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              controller: scrollController,
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Time:\n${dateTime.toString().split('.')[0]}",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 10,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Save",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}