import 'package:blavapp/bloc/degustation/place_degustation/place_degustation_bloc.dart';
import 'package:blavapp/views/degustation/degustation_place_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DegustationPlaceList extends StatelessWidget {
  const DegustationPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double aspectRation = width / height;
    return BlocBuilder<PlaceDegustationBloc, PlaceDegustationState>(
      builder: (context, state) {
        return CarouselSlider(
          items: state.places
              .map((DegustationPlaceInfo info) => DegustationPlaceCard(
                    degustationPlaceInfo: info,
                  ))
              .toList(),
          options: CarouselOptions(
            enlargeCenterPage: true,
            scrollDirection: Axis.vertical,
            enableInfiniteScroll: true,
            height: height,
            aspectRatio: aspectRation,
          ),
        );
      },
    );
  }
}
