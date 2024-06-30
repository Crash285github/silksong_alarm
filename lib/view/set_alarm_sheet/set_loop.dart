part of 'set_alarm_sheet.dart';

class _SetLoop extends StatelessWidget {
  const _SetLoop({
    required this.loop,
    required this.onTap,
  });

  final bool loop;
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
              loop
                  ? Theme.of(context).colorScheme.tertiary
                  : Colors.transparent,
              BlendMode.difference,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.loop,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
