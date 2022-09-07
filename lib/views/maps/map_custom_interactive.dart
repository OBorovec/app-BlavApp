import 'dart:math';

import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/utils/model_icons.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// TODO: icon size scaling with zoom

class CustomMap extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final MapRecord mapRecord;
  final String? pointRefZoom;

  const CustomMap({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.mapRecord,
    this.pointRefZoom,
  }) : super(key: key);

  double get initVerticalScale => screenHeight / mapRecord.h;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final TransformationController _mapTransformationController =
      TransformationController();
  Animation<Matrix4> _mapMatrixAnimation =
      AlwaysStoppedAnimation(Matrix4.identity());
  late final AnimationController _mapAnimationController;

  final CarouselController _carouselController = CarouselController();

  double _currentScale = 1.0;
  bool _isAnimating = false;
  int _displayIndex = 0;

  @override
  void initState() {
    _mapTransformationController.value =
        Matrix4.identity() * widget.initVerticalScale;
    super.initState();
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(_mapAnimationListener);
    if (widget.pointRefZoom != null) {
      List<MapPoint> points = widget.mapRecord.points
          .where((MapPoint p) => p.id == widget.pointRefZoom)
          .toList();
      if (points.isNotEmpty) {
        MapPoint point = points.first;
        final int index = widget.mapRecord.points.indexOf(point);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _animateMove(point);
          _carouselController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
          );
          _displayIndex = index;
        });
      }
    }
  }

  void _mapAnimationListener() {
    _mapTransformationController.value = _mapMatrixAnimation.value;
  }

  Future<void> _animateMove(MapPoint point) async {
    _mapMatrixAnimation = Matrix4Tween(
      begin: _mapTransformationController.value,
      end: Matrix4.translationValues(
        -point.x + widget.screenWidth / 2,
        -point.y + widget.screenHeight / 2,
        0,
      ),
    ).animate(_mapAnimationController);
    await _mapAnimationController.forward(from: 0);
  }

  Future<void> onPointTap(int index, MapPoint point) async {
    _animateMove(widget.mapRecord.points[index]);
    setState(() {
      _isAnimating = true;
      _displayIndex = index;
    });
    await _carouselController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    setState(() {
      _isAnimating = false;
    });
  }

  void onCarouselChange(index, reason) {
    if (!_isAnimating) {
      _animateMove(widget.mapRecord.points[index]);
      setState(() {
        _displayIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MapPoint highlightPoint = widget.mapRecord.points[_displayIndex];
    return Stack(
      alignment: Alignment.center,
      children: [
        InteractiveViewer(
          transformationController: _mapTransformationController,
          constrained: false,
          minScale: widget.initVerticalScale,
          // onInteractionUpdate: (ScaleUpdateDetails details) {
          //   _currentScale = details.scale;
          // },
          child: Stack(
            children: [
              widget.mapRecord.image.startsWith('assets')
                  ? Image.asset(
                      widget.mapRecord.image,
                    )
                  : AppNetworkImage(url: widget.mapRecord.image),
              ...widget.mapRecord.points.map(
                (MapPoint p) {
                  final int index = widget.mapRecord.points.indexOf(p);
                  return Positioned(
                    left: p.x.toDouble() - _MapMarker.offset,
                    top: p.y.toDouble() - _MapMarker.offset,
                    child: _MapMarker(
                      mapPoint: p,
                      onTap: () => onPointTap(index, p),
                      isSelected: _displayIndex == index,
                    ),
                  );
                },
              ),
              Positioned(
                left: highlightPoint.x.toDouble() - _MapMarker.offset,
                top: highlightPoint.y.toDouble() - _MapMarker.offset,
                child: _MapMarker(
                  mapPoint: highlightPoint,
                  onTap: () => onPointTap(_displayIndex, highlightPoint),
                  isSelected: true,
                  scale: max(1, 2 - _currentScale),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: CarouselSlider(
              carouselController: _carouselController,
              items: widget.mapRecord.points
                  .map(
                    (MapPoint p) => _CarouselMapPointCard(
                      mapPoint: p,
                      onLongPress: () => null,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: widget.screenHeight * 0.1,
                enlargeCenterPage: true,
                // aspectRatio: 6.0,
                viewportFraction: 0.7,
                onPageChanged: onCarouselChange,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapAnimationController.dispose();
    _mapTransformationController.dispose();
    super.dispose();
  }
}

class _MapMarker extends StatelessWidget {
  final MapPoint mapPoint;
  final Function() onTap;
  final bool isSelected;
  final double scale;

  static double offset = 50;

  const _MapMarker({
    Key? key,
    required this.mapPoint,
    required this.onTap,
    required this.isSelected,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: scale * _MapMarker.offset * 2,
            height: scale * _MapMarker.offset * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(isSelected ? 0.7 : 0.2),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                mapPointTypeIcon(mapPoint.type),
                color:
                    isSelected ? Theme.of(context).colorScheme.secondary : null,
                size: isSelected
                    ? scale * _MapMarker.offset * 2 - 4
                    : scale * _MapMarker.offset - 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselMapPointCard extends StatelessWidget {
  final MapPoint mapPoint;
  final Function() onLongPress;

  const _CarouselMapPointCard({
    Key? key,
    required this.mapPoint,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onLongPress: onLongPress,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(mapPointTypeIcon(mapPoint.type)),
                const VerticalDivider(),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      t(mapPoint.name, context),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
