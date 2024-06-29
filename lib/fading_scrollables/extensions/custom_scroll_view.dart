part of '../fading_scrollables.dart';

extension FadingCustomScrollView on CustomScrollView {
  Widget fade({
    final double gradientSize = 20.0,
    bool startFade = true,
    bool endFade = true,
    double startOffset = 0,
    double endOffset = 0,
    int? frameRate,
  }) {
    assert(controller != null);

    return _FadingScrollableShader(
      startFade: startFade,
      endFade: endFade,
      gradientSize: gradientSize,
      reverse: reverse,
      scrollDirection: scrollDirection,
      controller: controller!,
      startOffset: startOffset,
      endOffset: endOffset,
      frameRate: frameRate,
      child: this,
    );
  }
}
