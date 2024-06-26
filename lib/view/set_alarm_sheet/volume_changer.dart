part of 'set_alarm_sheet.dart';

class _VolumeChanger extends StatefulWidget {
  const _VolumeChanger({
    required this.onChanged,
  });
  final Function(double value)? onChanged;

  @override
  State<_VolumeChanger> createState() => _VolumeChangerState();
}

class _VolumeChangerState extends State<_VolumeChanger> {
  double localValue = .5;
  static bool playing = false;
  static final AudioPlayer _player = AudioPlayer();

  Future<void> toggleAudio() async {
    await _player.stop();
    await _player.setFilePath(await SilksongNews.path);
    await _player.setVolume(localValue);
    await _player.play();

    setState(() => playing = _player.playing);
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
                localValue > .8
                    ? Icons.volume_up_sharp
                    : localValue > .5
                        ? Icons.volume_down_sharp
                        : Icons.volume_mute_sharp,
                color: Theme.of(context).colorScheme.primary,
              ),
              Expanded(
                child: Slider(
                  value: localValue,
                  onChanged: (value) {
                    setState(() => localValue = value);
                    widget.onChanged?.call(localValue);
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
