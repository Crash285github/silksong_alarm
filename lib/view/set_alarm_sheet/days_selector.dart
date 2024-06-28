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
                child: BeveledCard(
                  borderRadius: BorderRadius.circular(512),
                  borderColor: Theme.of(context).colorScheme.tertiary,
                  borderWidth: .5,
                  onTap: () {},
                  child: Center(
                    child: Text(
                      day[0],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
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
