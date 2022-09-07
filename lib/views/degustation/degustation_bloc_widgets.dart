import 'package:blavapp/bloc/user_data/local_user_data/local_user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DegustationFavoriteSwitch extends StatelessWidget {
  final String itemRef;
  const DegustationFavoriteSwitch({
    Key? key,
    required this.itemRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        return FavoriteSwitch(
          isOn: state.userData.favoriteSamples.contains(itemRef),
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context)
                .add(UserDataDegustationFavorite(itemRef: itemRef));
          },
        );
      },
    );
  }
}

class DegustationTastedSwitch extends StatelessWidget {
  final String itemRef;
  const DegustationTastedSwitch({
    Key? key,
    required this.itemRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalUserDataBloc, LocalUserDataState>(
      builder: (context, state) {
        return CheckBoxSwitch(
          isOn: state.tastedDegustations.contains(itemRef),
          onPressed: () {
            BlocProvider.of<LocalUserDataBloc>(context)
                .add(LocalToggleDegustationSample(itemRef: itemRef));
          },
        );
      },
    );
  }
}
