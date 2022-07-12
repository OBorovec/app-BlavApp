import 'package:blavapp/bloc/auth/auth_bloc.dart';
import 'package:blavapp/bloc/user_profile/user_profile_bloc.dart';
import 'package:blavapp/components/_pages/root_page.dart';
import 'package:blavapp/components/user/user_avatar.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootPage(
        titleText: AppLocalizations.of(context)!.profTitle,
        body: BlocProvider(
          create: (context) => UserProfileBloc(
            user: (context.read<AuthBloc>().state as UserAuthenticated).user,
            authRepo: context.read<AuthRepo>(),
            storageRepo: context.read<StorageRepo>(),
          ),
          child: BlocListener<UserProfileBloc, UserProfileState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: listenUserProfileBlocStatus,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const _ProfileImage(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            _ProfileEmail(),
                            SizedBox(height: 16),
                            _ProfileNickName(),
                          ],
                        ),
                        Column(
                          children: const [
                            _ProfileRefresh(),
                            SizedBox(height: 8),
                            _PasswordResetButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Column(
                    children: const [
                      _SignOutButton(),
                      SizedBox(height: 8),
                      _DeleteAccountButton(),
                      SizedBox(height: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void listenUserProfileBlocStatus(context, userEditState) {
    if (userEditState.status == UserEditStatus.ready) {
      return;
    } else if (userEditState.status == UserEditStatus.error) {
      Toasting.notifyToast(
        context,
        userEditState.errorMessage ??
            AppLocalizations.of(context)!.profUnknownErrro(
              userEditState.errorMessage,
            ),
      );
    } else if (userEditState.status == UserEditStatus.emailVerificationSent) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.profToastingEmailVerificationSent,
      );
    } else if (userEditState.status ==
        UserEditStatus.emailVerificationVerified) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.profToastingEmailVerified,
      );
    } else if (userEditState.status == UserEditStatus.emailVerificationFailed) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.profToastingEmailVerificationFailed(
          userEditState.errorMessage,
        ),
      );
    } else if (userEditState.status == UserEditStatus.passwordEmailSent) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.profToastingPasswordEmailSent,
      );
    } else if (userEditState.status == UserEditStatus.passwordEmailFailedSent) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.profToastingPasswordEmailFailedSent(
          userEditState.errorMessage,
        ),
      );
    }
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: 128,
      child: Stack(
        children: [
          Positioned.fill(
            child: BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return UserAvatar(imageUrl: state.user.photoURL);
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileEmail extends StatelessWidget {
  const _ProfileEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return TextField(
          readOnly: true,
          controller: TextEditingController(text: state.user.email),
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.profEmail,
            icon: const Icon(Icons.mail),
            suffixIcon: IconButton(
              icon: Icon(
                state.user.emailVerified
                    ? Icons.verified_user
                    : Icons.outgoing_mail,
              ),
              onPressed: state.user.emailVerified
                  ? null
                  : () {
                      context.read<UserProfileBloc>().add(
                            const UserEmailVerification(),
                          );
                    },
            ),
          ),
        );
      },
    );
  }
}

class _ProfileNickName extends StatelessWidget {
  const _ProfileNickName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, editState) {
            return TextField(
              readOnly: !editState.editingNickname,
              controller: TextEditingController(text: editState.nickname),
              onChanged: (value) =>
                  context.read<UserProfileBloc>().add(UserNicknameOnChange(
                        nickname: value,
                      )),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.profNick,
                icon: const Icon(Icons.perm_identity),
                suffixIcon: IconButton(
                  icon: Icon(
                    editState.editingNickname ? Icons.save : Icons.edit,
                  ),
                  onPressed: () {
                    context.read<UserProfileBloc>().add(
                          const UserEditNicknameToggle(),
                        );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ProfileRefresh extends StatelessWidget {
  const _ProfileRefresh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserProfileBloc>().add(const UserProfileRefresh());
      },
      child: Text(AppLocalizations.of(context)!.profBtnProfileRefresh),
    );
  }
}

class _PasswordResetButton extends StatelessWidget {
  const _PasswordResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserProfileBloc>().add(const UserPasswordReset());
      },
      child: Text(AppLocalizations.of(context)!.profBtnResetPsw),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthBloc>().add(const UserAuthSignOut());
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).popAndPushNamed(RoutePaths.signIn);
        });
      },
      child: Text(AppLocalizations.of(context)!.profBtnSignOut),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutePaths.profileDelete);
      },
      child: Text(AppLocalizations.of(context)!.profBtnDeleteAccount),
    );
  }
}
