part of '../fading_scrollables.dart';

extension FadingGridView on GridView {
  Widget fade({
    final double gradientSize = 20.0,
    bool startFade = true,
    bool endFade = true,
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
      frameRate: frameRate,
      child: this,
    );
  }
}
