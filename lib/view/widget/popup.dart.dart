import 'package:flutter/material.dart';
import 'package:silksong_alarm/view/widget/beveled_card.dart';

bool _showing = false;

Future<void> showPopupWidget(
  BuildContext context, {
  required String text,
}) async {
  if (_showing) return;

  _showing = true;
  await showDialog(
    context: context,
    barrierDismissible: true,
    useRootNavigator: true,
    useSafeArea: true,
    builder: (context) => _PopupWidget(text: text),
  );

  _showing = false;
}

class _PopupWidget extends StatefulWidget {
  final String text;
  const _PopupWidget({required this.text});

  @override
  State<_PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<_PopupWidget> {
  bool inited = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() => inited = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
          duration: Durations.medium1,
          opacity: inited ? 1 : 0,
          child: AnimatedAlign(
            duration: Durations.medium1,
            curve: Curves.decelerate,
            alignment: inited ? const Alignment(0, .7) : const Alignment(0, 1),
            child: BeveledCard(
              borderRadius: BorderRadius.circular(32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * .8,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 8.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: BeveledCard(
                          borderRadius: BorderRadius.circular(512),
                          color: Theme.of(context).colorScheme.tertiary,
                          onTap: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "OK",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
