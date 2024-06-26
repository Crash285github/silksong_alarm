part of 'set_alarm_sheet.dart';

class _VolumeChanger extends StatefulWidget {
  const _VolumeChanger();

  @override
  State<_VolumeChanger> createState() => _VolumeChangerState();
}

class _VolumeChangerState extends State<_VolumeChanger> {
  double value = .5;
  static bool playing = false;

  void toggleAudio() {
    setState(() {
      playing = !playing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                value > .8
                    ? Icons.volume_up_sharp
                    : value > .5
                        ? Icons.volume_down_sharp
                        : Icons.volume_mute_sharp,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Slider(
                  value: value,
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
              )
            ],
          ),
          Material(
            type: MaterialType.transparency,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: toggleAudio,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  playing ? Icons.pause : Icons.play_arrow,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
