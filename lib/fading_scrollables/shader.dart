part of 'fading_scrollables.dart';

class _FadingScrollableShader extends StatefulWidget {
  /// The default frame rate for all the shaders.
  static int defaultFrameRate = 60;

  /// The contoller for the scrollable.
  final ScrollController controller;

  /// The size of the gradient.
  final double gradientSize;

  /// The offset at which the gradient starts.
  final double startOffset;

  /// The offset at which the gradient ends.
  final double endOffset;

  /// Whether the start of the scrollable should fade.
  final bool startFade;

  /// Whether the end of the scrollable should fade.
  final bool endFade;

  /// The child scrollable widget.
  final Widget child;

  /// Whether the gradient should be reversed.
  final bool reverse;

  /// The direction of the scrollable.
  final Axis scrollDirection;

  /// The frame rate for the shader instance.
  final int? frameRate;

  const _FadingScrollableShader({
    required this.controller,
    required this.startFade,
    required this.endFade,
    required this.gradientSize,
    required this.child,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.startOffset = 0,
    this.endOffset = 0,
    this.frameRate,
  })  : assert(
          startFade != false || endFade != false,
          'At least one side must fade',
        ),
        assert(
          frameRate == null || frameRate > 0,
          'Frame rate must be positive',
        ),
        assert(
          frameRate == null || frameRate <= 1000,
          'Frame rate must be less than or equal to 1000',
        );

  @override
  State<_FadingScrollableShader> createState() =>
      _FadingScrollableShaderState();
}

class _FadingScrollableShaderState extends State<_FadingScrollableShader> {
  /// The size of the gradient at the start of the scrollable.
  double startGradientSize = 0.0;

  /// The size of the gradient at the end of the scrollable.
  late double endGradientSize = widget.gradientSize;

  /// The scroll controller for the scrollable.
  ScrollController get _scrollController => widget.controller;

  /// Updates the gradient sizes.
  void updateGradient() {
    final newStartGradientSize = min(
      widget.gradientSize,
      _scrollController.offset,
    );
    final newEndGradientSize = min(
      widget.gradientSize,
      _scrollController.position.maxScrollExtent - _scrollController.offset,
    );

    if ((widget.startFade && newStartGradientSize != startGradientSize) ||
        (widget.endFade && newEndGradientSize != endGradientSize)) {
      if (mounted) {
        setState(
          () {
            startGradientSize = newStartGradientSize;
            endGradientSize = newEndGradientSize;
          },
        );
      }
    }
  }

  /// The duration between each refresh.
  Duration get refreshDuration => Duration(
        milliseconds: 1000 ~/
            (widget.frameRate ?? _FadingScrollableShader.defaultFrameRate),
      );

  @override
  void initState() {
    super.initState();

    Timer.periodic(refreshDuration, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (mounted) updateGradient();
    });
  }

  /// Whether the scrollable is vertical or horizontal.
  bool get _isVertical => widget.scrollDirection == Axis.vertical;

  /// The stop value for the gradient at the start of the scrollable.
  double get _startStop => widget.reverse ? endGradientSize : startGradientSize;

  /// The stop value for the gradient at the end of the scrollable.
  double get _endStop => widget.reverse ? startGradientSize : endGradientSize;

  /// The alignment for the gradient at the start of the scrollable.
  Alignment get _begin =>
      _isVertical ? Alignment.topCenter : Alignment.centerLeft;

  /// The alignment for the gradient at the end of the scrollable.
  Alignment get _end =>
      _isVertical ? Alignment.bottomCenter : Alignment.centerRight;

  /// The size of the scrollable's scrollable axis.
  double _rectSize(final Rect rect) => _isVertical ? rect.height : rect.width;

  @override
  Widget build(BuildContext context) => ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (final rect) => LinearGradient(
          tileMode: TileMode.decal,
          begin: _begin,
          end: _end,
          colors: [
            if (widget.startFade) ...[
              const Color.fromARGB(255, 0, 0, 0),
              const Color.fromARGB(0, 0, 0, 0),
            ],
            if (widget.endFade) ...[
              const Color.fromARGB(0, 0, 0, 0),
              const Color.fromARGB(255, 0, 0, 0),
            ]
          ],
          stops: [
            if (widget.startFade) ...[
              0,
              _startStop / _rectSize(rect),
            ],
            if (widget.endFade) ...[
              1 - (_endStop / _rectSize(rect)),
              1,
            ]
          ],
        ).createShader(
          Rect.fromLTRB(
            _isVertical ? 0 : widget.startOffset,
            _isVertical ? widget.startOffset : 0,
            rect.width + (_isVertical ? 0 : widget.endOffset),
            rect.height + (_isVertical ? widget.endOffset : 0),
          ),
        ),
        child: widget.child,
      );
}
