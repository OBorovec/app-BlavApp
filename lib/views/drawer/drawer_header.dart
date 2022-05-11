import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/components/user/user_avatar.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlavDrawerHeader extends StatelessWidget {
  const BlavDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, RoutePaths.profile);
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is UserAuthenticated) {
          return UserAvatar(imageUrl: state.user.photoURL);
        } else {
          return const Icon(
            Icons.login,
            size: 100,
          );
        }
      }),
    );
  }
}
