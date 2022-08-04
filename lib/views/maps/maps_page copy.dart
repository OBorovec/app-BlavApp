import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/views/maps/custom_map.dart';
import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  int navigationIndex = 0;
  final cateringPages = [];

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: _getTitle(navigationIndex, context),
      body: CustomMap(
        screenHeight: MediaQuery.of(context).size.height,
        screenWidth: MediaQuery.of(context).size.width,
        mapRecord: const MapRecord(
          id: 'tabor_mlyn',
          name: {
            '@cs': 'Housův mlýn - oblast',
            '@en': 'Housův mlýn - area',
          },
          image: 'assets/maps/tabor_mlyn.png',
          w: 2346,
          h: 1892,
          points: [
            MapPoint(
              id: 'org_entrance',
              type: MapPointType.other,
              x: 400,
              y: 1350,
              name: {'@cs': 'Vstup a kasa', '@en': 'Entrance and register'},
            ),
            MapPoint(
              id: 'programme_podium',
              type: MapPointType.programme,
              x: 630,
              y: 1340,
              name: {'@cs': 'Pódium', '@en': 'Podium'},
            ),
            MapPoint(
              id: 'shop_melitele',
              type: MapPointType.shop,
              x: 740,
              y: 1305,
              name: {
                '@cs': 'Vetešnictví Melitelé',
                '@en': 'Junkshop of Melitele'
              },
            ),
            MapPoint(
              id: 'shop_xzone',
              type: MapPointType.shop,
              x: 760,
              y: 1250,
              name: {'@cs': 'Stánek XZone', '@en': 'XZone spot'},
            ),
            MapPoint(
              id: 'catering_outside_inn',
              type: MapPointType.catering,
              x: 730,
              y: 1220,
              name: {'@cs': 'Venkonví krčma', '@en': 'Outside inn'},
            ),
            MapPoint(
              id: 'catering_freia',
              type: MapPointType.catering,
              x: 480,
              y: 1310,
              name: {'@cs': 'Freina všehochuť', '@en': 'Freia taste mixture'},
            ),
            MapPoint(
              id: 'catering_whisky_tasting',
              type: MapPointType.degustation,
              x: 550,
              y: 1270,
              name: {
                '@cs': 'Pivní speciály a whisky',
                '@en': 'Special beer brews and whisky'
              },
            ),
            MapPoint(
              id: 'catering_inner_inn',
              type: MapPointType.catering,
              x: 590,
              y: 1160,
              name: {
                '@cs': 'Výdej vnitřní krčmy',
                '@en': 'Take out of inner inn'
              },
            ),
            MapPoint(
              id: 'catering_back_inn',
              type: MapPointType.catering,
              x: 645,
              y: 970,
              name: {'@cs': 'Zadní krčma', '@en': 'Back inn'},
            ),
            MapPoint(
              id: 'fun_photo_corner',
              type: MapPointType.other,
              x: 660,
              y: 930,
              name: {'@cs': 'Fotokoutek', '@en': 'Photo corner'},
            ),
            MapPoint(
              id: 'org_step_upper_flor',
              type: MapPointType.other,
              x: 725,
              y: 1140,
              name: {'@cs': 'Schody do heren', '@en': 'Steps to gaming clubs'},
            ),
            MapPoint(
              id: 'degustation_mead_cellar',
              type: MapPointType.degustation,
              x: 540,
              y: 1000,
              name: {'@cs': 'Medovinový sklípek', '@en': 'Mead cellar'},
            ),
          ],
        ),
      ),
      // body: BlocBuilder<EventFocusBloc, EventFocusState>(
      //   builder: (context, state) {
      //     if (state.status == EventFocusStatus.focused) {
      //       return BlocProvider(
      //         create: (context) => MapsBloc(
      //           dataRepo: context.read<DataRepo>(),
      //           eventTag: state.eventTag,
      //         ),
      //         child: cateringPages.elementAt(navigationIndex),
      //       );
      //     } else {
      //       return Container();
      //     }
      //   },
      // ),
    );
  }

  _getTitle(int index, BuildContext context) {
    switch (index) {
      case 0:
        return 'Title 0';
      default:
        return 'Uknown';
    }
  }
}
