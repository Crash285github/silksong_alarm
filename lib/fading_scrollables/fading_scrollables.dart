library fading_collections;

import 'dart:async' show Timer;
import 'dart:math' show min;

import 'package:flutter/widgets.dart'
    show
        Alignment,
        Axis,
        BlendMode,
        BuildContext,
        Color,
        CustomScrollView,
        GridView,
        LinearGradient,
        ListView,
        Rect,
        ScrollController,
        ShaderMask,
        SingleChildScrollView,
        State,
        StatefulWidget,
        TileMode,
        Widget;

part 'extensions/custom_scroll_view.dart';
part 'extensions/grid_view.dart';
part 'extensions/list_view.dart';
part 'extensions/single_child_scroll_view.dart';
part 'shader.dart';

/// Sets the rate at which the fading effect updates.
void setDefaultFrameRate(final int frameRate) {
  assert(frameRate > 0, 'Frame rate must be greater than 0.');
  assert(frameRate <= 1000, 'Frame rate must be less than 1000.');
  _FadingScrollableShader.defaultFrameRate = frameRate;
}
