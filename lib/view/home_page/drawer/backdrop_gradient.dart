part of '../home_page.dart';

class BackdropGradient extends StatelessWidget {
  const BackdropGradient({super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.red.withOpacity(.2),
            Colors.red.withOpacity(0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
      );
}
