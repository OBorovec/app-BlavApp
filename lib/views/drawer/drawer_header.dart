import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/components/user/user_avatar.dart';
import 'package:blavapp/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlavDrawerHeader extends StatelessWidget {
  const BlavDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isAuthenticated = state.status == AuthStatus.authenticated;
        return InkWell(
          onTap: () {
            Navigator.popAndPushNamed(
              context,
              isAuthenticated ? RoutePaths.profile : RoutePaths.signIn,
            );
          },
          child: isAuthenticated
              ? UserAvatar(imageUrl: state.user!.photoURL)
              : const Icon(
                  Icons.login,
                  size: 100,
                ),
        );
      },
    );
  }
}
