part of 'set_alarm_sheet.dart';

class _SetVolume extends StatefulWidget {
  const _SetVolume({
    required this.onChanged,
  });
  final Function(double value)? onChanged;

  @override
  State<_SetVolume> createState() => _SetVolumeState();
}

class _SetVolumeState extends State<_SetVolume> {
  double? systemVolumeAtInit;
  double localValue = .75;
  bool playing = false;
  final AudioPlayer _player = AudioPlayer();

  Future<void> toggleAudio() async {
    setState(() => playing = !playing);

    if (playing) {
      await _player.play();
    } else {
      await _player.stop();
    }
  }

  Future<void> setupAudioPlayer() async {
    await _player.setFilePath(SilksongNews.path);
    await _player.load();

    systemVolumeAtInit = await VolumeController().getVolume();
    if (systemVolumeAtInit == null || systemVolumeAtInit! < .75) {
      VolumeController().setVolume(.75, showSystemUI: false);
    }

    setState(() => localValue = max(.75, systemVolumeAtInit ?? .75));

    widget.onChanged?.call(localValue);
  }

  @override
  void initState() {
    super.initState();
    setupAudioPlayer();
  }

  @override
  void dispose() {
    _player.stop().whenComplete(() => _player.dispose());
    if (systemVolumeAtInit != null) {
      VolumeController().setVolume(systemVolumeAtInit!, showSystemUI: false);
    }
    super.dispose();
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
                color: Theme.of(context).colorScheme.tertiary,
              ),
              Expanded(
                child: Slider(
                  value: localValue,
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  thumbColor: Theme.of(context).colorScheme.onBackground,
                  onChanged: (value) async {
                    setState(() => localValue = value);

                    VolumeController().setVolume(value, showSystemUI: false);
                    widget.onChanged?.call(localValue);
                  },
                ),
              )
            ],
          ),
          BeveledCard(
            onTap: toggleAudio,
            borderRadius: BorderRadius.circular(512),
            color: Theme.of(context).colorScheme.tertiary,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                playing ? Icons.pause : Icons.play_arrow,
                size: 32,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
