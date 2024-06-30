part of 'set_alarm_sheet.dart';

class _DaysSelector extends StatefulWidget {
  final Set<int> days;
  const _DaysSelector(this.days);

  @override
  State<_DaysSelector> createState() => _DaysSelectorState();
}

class _DaysSelectorState extends State<_DaysSelector> {
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
                  color: Theme.of(context).colorScheme.tertiary,
                  borderWidth: .5,
                  onTap: () {
                    setState(() {
                      if (!widget.days.add(day.index)) {
                        widget.days.remove(day.index);
                      }
                    });
                  },
                  child: ImageFiltered(
                    imageFilter: ColorFilter.mode(
                      widget.days.contains(day.index)
                          ? Theme.of(context).colorScheme.tertiary
                          : Colors.transparent,
                      BlendMode.difference,
                    ),
                    child: Center(
                      child: Text(
                        day.name[0].toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: isToday(day.index)
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
