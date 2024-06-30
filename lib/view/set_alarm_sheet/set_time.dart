part of 'set_alarm_sheet.dart';

class _SetTime extends StatelessWidget {
  const _SetTime({
    required this.onTap,
    required this.dateTime,
  });

  final Function()? onTap;

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BeveledCard(
        onTap: onTap,
        color: Theme.of(context).colorScheme.tertiary,
        borderWidth: .5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            DateFormat("HH:mm").format(dateTime),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
        ),
      ),
    );
  }
}
