part of 'set_alarm_sheet.dart';

class _SetVibration extends StatelessWidget {
  const _SetVibration({
    required this.vibrate,
    required this.onTap,
  });

  final bool vibrate;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: BeveledCard(
          onTap: onTap,
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(512),
          child: ImageFiltered(
            imageFilter: ColorFilter.mode(
              vibrate
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.transparent,
              BlendMode.difference,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.vibration,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
