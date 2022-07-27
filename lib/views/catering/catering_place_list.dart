import 'package:blavapp/bloc/catering/places_catering/places_catering_bloc.dart';
import 'package:blavapp/views/catering/catering_place_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CateringPlaceList extends StatelessWidget {
  const CateringPlaceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double aspectRation = width / height;
    return BlocBuilder<PlacesCateringBloc, PlacesCateringState>(
      builder: (context, state) {
        return CarouselSlider(
          items: state.places
              .map((CateringPlaceInfo info) => CateringPlaceCard(
                    cateringPlaceInfo: info,
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
