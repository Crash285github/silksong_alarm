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
      padding: const EdgeInsets.all(32.0),
      child: Material(
        type: MaterialType.transparency,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: .5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          overlayColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.primary.withOpacity(.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              DateFormat("HH:mm").format(dateTime),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      ),
    );
  }
}
