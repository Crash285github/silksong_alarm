part of 'set_alarm_sheet.dart';

class _DaysSelector extends StatefulWidget {
  final Function(Set<int> days) onSelect;
  const _DaysSelector(this.onSelect);

  @override
  State<_DaysSelector> createState() => _DaysSelectorState();
}

class _DaysSelectorState extends State<_DaysSelector> {
  final Set<int> _days = {};

  bool isToday(int day) => day == DateTime.now().weekday - 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ...DaysEnum.values.map(
            (final day) => Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: BeveledCard(
                  borderRadius: BorderRadius.circular(512),
                  color: day.index >= 5
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.tertiary,
                  borderWidth: .5,
                  onTap: () {
                    setState(() {
                      if (!_days.add(day.index)) {
                        _days.remove(day.index);
                      }
                    });

                    widget.onSelect(_days);
                  },
                  child: ImageFiltered(
                    imageFilter: ColorFilter.mode(
                      _days.contains(day.index)
                          ? day.index >= 5
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary
                          : Colors.transparent,
                      BlendMode.difference,
                    ),
                    child: Center(
                      child: Text(
                        day.name[0].toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: day.index >= 5
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
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
