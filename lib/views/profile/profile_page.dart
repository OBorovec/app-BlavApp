import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/profile/user_profile/user_profile_bloc.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/user/user_avatar.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileBloc(
        user: (context.read<AuthBloc>()).state.user!,
        authRepo: context.read<AuthRepo>(),
        storageRepo: context.read<StorageRepo>(),
      ),
      child: RootPage(
        titleText: AppLocalizations.of(context)!.contProfileTitle,
        body: BlocListener<UserProfileBloc, UserProfileState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: listenUserProfileBlocStatus,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const _ProfileImage(),
                const Expanded(
                  child: _UserProfileInfo(),
                ),
                const Divider(),
                Column(
                  children: const [
                    _ShowTicketshButton(),
                    SizedBox(height: 8),
                  ],
                ),
                const Divider(),
                Column(
                  children: const [
                    SizedBox(height: 8),
                    _PasswordResetButton(),
                    SizedBox(height: 8),
                    _SignOutButton(),
                    SizedBox(height: 8),
                    // _DeleteAccountButton(),
                    // SizedBox(height: 32),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listenUserProfileBlocStatus(context, userEditState) {
    if (userEditState.status == UserEditStatus.ready) {
      return;
    } else if (userEditState.status == UserEditStatus.error) {
      Toasting.notifyToast(context, userEditState.errorMessage);
    } else if (userEditState.status == UserEditStatus.emailVerificationSent) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.contProfileTEmailVerificationSent,
      );
    } else if (userEditState.status ==
        UserEditStatus.emailVerificationVerified) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.contProfileTEmailVerified,
      );
    } else if (userEditState.status == UserEditStatus.emailVerificationFailed) {
      Toasting.notifyToast(
        context,
        '${AppLocalizations.of(context)!.contProfileTEmailVerificationFailed}: ${userEditState.errorMessage}',
      );
    } else if (userEditState.status == UserEditStatus.passwordEmailSent) {
      Toasting.notifyToast(
        context,
        AppLocalizations.of(context)!.contProfileTPasswordEmailSent,
      );
    } else if (userEditState.status == UserEditStatus.passwordEmailFailedSent) {
      Toasting.notifyToast(
        context,
        '${AppLocalizations.of(context)!.contProfileTPasswordEmailFailedSent}: ${userEditState.errorMessage}',
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
                return UserAvatar(
                  imageUrl: state.user.photoURL,
                  heroTag: appHeros[AppHeros.userAvatar]!,
                );
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

class _UserProfileInfo extends StatelessWidget {
  const _UserProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _UserProfileInfoEmail(),
        SizedBox(height: 16),
        _UserProfileInfoNickName(),
      ],
    );
  }
}

class _UserProfileInfoEmail extends StatelessWidget {
  const _UserProfileInfoEmail({
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
            labelText: AppLocalizations.of(context)!.genEmail,
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

class _UserProfileInfoNickName extends StatefulWidget {
  const _UserProfileInfoNickName({Key? key}) : super(key: key);

  @override
  State<_UserProfileInfoNickName> createState() =>
      _UserProfileInfoNickNameState();
}

class _UserProfileInfoNickNameState extends State<_UserProfileInfoNickName> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textNickNameChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listenWhen: (previous, current) => previous.nickname != current.nickname,
      listener: (context, state) {
        _textController.text = state.nickname;
        _textController.selection =
            TextSelection.collapsed(offset: state.nickname.length);
      },
      builder: (context, state) {
        return TextField(
          readOnly: !state.editingNickname,
          autocorrect: false,
          enableSuggestions: false,
          controller: _textController,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.genNick,
            icon: const Icon(Icons.perm_identity),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state.editingNickname)
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                    ),
                    onPressed: () {
                      context.read<UserProfileBloc>().add(
                            const UserEditNicknameReset(),
                          );
                    },
                  ),
                IconButton(
                  icon: Icon(
                    state.editingNickname ? Icons.save : Icons.edit,
                  ),
                  onPressed: () {
                    context.read<UserProfileBloc>().add(
                          UserEditNicknameToggle(context: context),
                        );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _textNickNameChange() {
    BlocProvider.of<UserProfileBloc>(context)
        .add(UserNicknameOnChange(nickname: _textController.text));
    setState(() {
      // Just to trigger rebuild of icons
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class _ShowTicketshButton extends StatelessWidget {
  const _ShowTicketshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, RoutePaths.myTickets),
      child: Text(AppLocalizations.of(context)!.contProfileBtnProfileTickets),
    );
  }
}

class _ProfileRefreshButton extends StatelessWidget {
  const _ProfileRefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserProfileBloc>().add(const UserProfileRefresh());
      },
      child: Text(AppLocalizations.of(context)!.contProfileBtnProfileRefresh),
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
      child: Text(AppLocalizations.of(context)!.contProfileBtnResetPsw),
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
      child: Text(AppLocalizations.of(context)!.contProfileBtnSignOut),
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
      child: Text(AppLocalizations.of(context)!.contProfileBtnDeleteAccount),
    );
  }
}
