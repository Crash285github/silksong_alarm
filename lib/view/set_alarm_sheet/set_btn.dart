part of 'set_alarm_sheet.dart';

class _SetBtn extends StatelessWidget {
  const _SetBtn({required this.onTap});

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        type: MaterialType.transparency,
        shape: BeveledRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.elliptical(24, 512),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          overlayColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.tertiary.withOpacity(.2),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 32.0,
            ),
            child: Text(
              "Set Alarm",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
