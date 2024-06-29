part of '../home_page.dart';

class BackdropGradient extends StatelessWidget {
  const BackdropGradient({super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onPrimary.withOpacity(.2),
            Theme.of(context).colorScheme.onPrimary.withOpacity(0),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
      );
}
