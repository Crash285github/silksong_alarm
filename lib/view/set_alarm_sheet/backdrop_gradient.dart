part of 'set_alarm_sheet.dart';

class _BackdropGradient extends StatelessWidget {
  const _BackdropGradient();

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(.2),
            Colors.red.withOpacity(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )),
      );
}
