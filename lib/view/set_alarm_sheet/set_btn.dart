part of 'set_alarm_sheet.dart';

class _SetBtn extends StatelessWidget {
  const _SetBtn({required this.onTap});

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BeveledCard(
        borderColor: Theme.of(context).colorScheme.tertiary,
        borderWidth: .5,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Text(
            "Set Alarm",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
        ),
      ),
    );
  }
}
