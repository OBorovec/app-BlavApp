/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';

class $AssetsFlareGen {
  const $AssetsFlareGen();

  /// File path: assets/flare/WitcherWolf.flr
  FlareGenImage get witcherWolf =>
      const FlareGenImage('assets/flare/WitcherWolf.flr');
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  $AssetsIconsCateringGen get catering => const $AssetsIconsCateringGen();
  $AssetsIconsProgrammeGen get programme => const $AssetsIconsProgrammeGen();
}

class $AssetsMapsGen {
  const $AssetsMapsGen();

  /// File path: assets/maps/tabor_mlyn.png
  AssetGenImage get taborMlyn =>
      const AssetGenImage('assets/maps/tabor_mlyn.png');
}

class $AssetsRiveGen {
  const $AssetsRiveGen();

  /// File path: assets/rive/BlaviconIcon.riv
  String get blaviconIcon => 'assets/rive/BlaviconIcon.riv';

  /// File path: assets/rive/BlaviconIconDark.riv
  String get blaviconIconDark => 'assets/rive/BlaviconIconDark.riv';

  /// File path: assets/rive/BlaviconIconLight.riv
  String get blaviconIconLight => 'assets/rive/BlaviconIconLight.riv';
}

class $AssetsIconsCateringGen {
  const $AssetsIconsCateringGen();

  /// File path: assets/icons/catering/gluten-free.png
  AssetGenImage get glutenFree =>
      const AssetGenImage('assets/icons/catering/gluten-free.png');

  /// File path: assets/icons/catering/vegan.png
  AssetGenImage get vegan =>
      const AssetGenImage('assets/icons/catering/vegan.png');

  /// File path: assets/icons/catering/vegetarian.png
  AssetGenImage get vegetarian =>
      const AssetGenImage('assets/icons/catering/vegetarian.png');
}

class $AssetsIconsProgrammeGen {
  const $AssetsIconsProgrammeGen();

  /// File path: assets/icons/programme/concert.png
  AssetGenImage get concert =>
      const AssetGenImage('assets/icons/programme/concert.png');

  /// File path: assets/icons/programme/cosplay.png
  AssetGenImage get cosplay =>
      const AssetGenImage('assets/icons/programme/cosplay.png');

  /// File path: assets/icons/programme/crafting.png
  AssetGenImage get crafting =>
      const AssetGenImage('assets/icons/programme/crafting.png');

  /// File path: assets/icons/programme/degustation.png
  AssetGenImage get degustation =>
      const AssetGenImage('assets/icons/programme/degustation.png');

  /// File path: assets/icons/programme/discussion.png
  AssetGenImage get discussion =>
      const AssetGenImage('assets/icons/programme/discussion.png');

  /// File path: assets/icons/programme/gaming.png
  AssetGenImage get gaming =>
      const AssetGenImage('assets/icons/programme/gaming.png');

  /// File path: assets/icons/programme/lecture.png
  AssetGenImage get lecture =>
      const AssetGenImage('assets/icons/programme/lecture.png');

  /// File path: assets/icons/programme/show.png
  AssetGenImage get show =>
      const AssetGenImage('assets/icons/programme/show.png');

  /// File path: assets/icons/programme/storyline.png
  AssetGenImage get storyline =>
      const AssetGenImage('assets/icons/programme/storyline.png');

  /// File path: assets/icons/programme/tournament.png
  AssetGenImage get tournament =>
      const AssetGenImage('assets/icons/programme/tournament.png');
}

class Assets {
  Assets._();

  static const $AssetsFlareGen flare = $AssetsFlareGen();
  static const String icLauncher = 'assets/ic_launcher.zip';
  static const AssetGenImage icon = AssetGenImage('assets/icon.png');
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const AssetGenImage launcher = AssetGenImage('assets/launcher.png');
  static const $AssetsMapsGen maps = $AssetsMapsGen();
  static const $AssetsRiveGen rive = $AssetsRiveGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class FlareGenImage {
  const FlareGenImage(this._assetName);

  final String _assetName;

  FlareActor flare({
    String? boundsNode,
    String? animation,
    BoxFit fit = BoxFit.contain,
    Alignment alignment = Alignment.center,
    bool isPaused = false,
    bool snapToEnd = false,
    FlareController? controller,
    FlareCompletedCallback? callback,
    Color? color,
    bool shouldClip = true,
    bool sizeFromArtboard = false,
    String? artboard,
    bool antialias = true,
  }) {
    return FlareActor(
      _assetName,
      boundsNode: boundsNode,
      animation: animation,
      fit: fit,
      alignment: alignment,
      isPaused: isPaused,
      snapToEnd: snapToEnd,
      controller: controller,
      callback: callback,
      color: color,
      shouldClip: shouldClip,
      sizeFromArtboard: sizeFromArtboard,
      artboard: artboard,
      antialias: antialias,
    );
  }

  String get path => _assetName;
}
