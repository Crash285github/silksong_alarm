part of 'set_alarm_sheet.dart';

class _DaysSelector extends StatelessWidget {
  const _DaysSelector();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ...DateTimeManager.days.map(
            (final day) => Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    type: MaterialType.transparency,
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(512),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {},
                      overlayColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.primary.withOpacity(.2),
                      ),
                      child: Center(
                        child: Text(day[0]),
                      ),
                    ),
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
