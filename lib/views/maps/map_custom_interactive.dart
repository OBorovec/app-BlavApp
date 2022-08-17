import 'package:blavapp/components/images/app_network_image.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/utils/model_icons.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  bool animate = true;

  final CarouselController _carouselController = CarouselController();
  int _carouselIndex = 0;

  @override
  void initState() {
    _mapTransformationController.value =
        Matrix4.identity() * widget.initVerticalScale;
    super.initState();
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(_mapAnimationListener);
    if (widget.pointRefZoom != null) {
      List<MapPoint> points = widget.mapRecord.points
          .where((MapPoint p) => p.id == widget.pointRefZoom)
          .toList();
      if (points.isNotEmpty) {
        MapPoint point = points.first;
        final int index = widget.mapRecord.points.indexOf(point);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Center
          _animateMove(point);
          // Set carousel
          _carouselController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
          _carouselIndex = index;
        });
      }
    }
  }

  void _mapAnimationListener() {
    // print(MatrixUtils.transformPoint(_mapMatrixAnimation.value, Offset.zero));
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
    )
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_mapAnimationController);
    await _mapAnimationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        InteractiveViewer(
          transformationController: _mapTransformationController,
          constrained: false,
          minScale: widget.initVerticalScale,
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
                      onTap: () {
                        _animateMove(widget.mapRecord.points[index]);
                        setState(() {
                          animate = false;
                        });
                        _carouselController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                        );
                        setState(() {
                          animate = true;
                        });
                      },
                      isSelected: _carouselIndex == index,
                    ),
                  );
                },
              )
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
                  onPageChanged: (index, reason) {
                    setState(() {
                      _animateMove(widget.mapRecord.points[index]);
                      _carouselIndex = index;
                    });
                  }),
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

  static double offset = 30;

  const _MapMarker({
    Key? key,
    required this.mapPoint,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: _MapMarker.offset * 2,
            height: _MapMarker.offset * 2,
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
                size:
                    isSelected ? _MapMarker.offset * 2 - 2 : _MapMarker.offset,
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
