part of 'home_page.dart';

class ShowAlarmSheetButton extends StatelessWidget {
  const ShowAlarmSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BeveledCard(
      borderRadius: BorderRadius.circular(16),
      onTap: () async => await showSetAlarmBottomSheet(context),
      color: Theme.of(context).colorScheme.tertiary,
      borderWidth: .5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          Icons.alarm_add,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
