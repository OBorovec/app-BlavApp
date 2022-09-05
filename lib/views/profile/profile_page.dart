import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/profile/user_profile/user_profile_bloc.dart';
import 'package:blavapp/components/dialogs/info_dialog.dart';
import 'package:blavapp/components/pages/page_root.dart';
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          // TODO: make it ro restart and toggle user nickname textfield
        },
        child: RootPage(
          titleText: AppLocalizations.of(context)!.contProfileTitle,
          body: BlocListener<UserProfileBloc, UserProfileState>(
            listener: userProfileNotifications,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _ProfileImage(),
                  const _UserProfileInfo(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Column(
                      children: const [
                        // NOTE: Uncomment when user event ticket system is ready
                        // SizedBox(height: 8),
                        // _ShowTicketshButton(),
                        // NOTE: Uncomment when user support ticket system is ready
                        // SizedBox(height: 8),
                        // _ShowSupportTicketshButton(),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: const [
                        SizedBox(height: 8),
                        Divider(),
                        SizedBox(height: 8),
                        _SignOutButton(),
                        // NOTE: Uncomment sure all functionality is ready
                        // SizedBox(height: 8),
                        // _AccoutOptionsButton(),
                        SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void userProfileNotifications(BuildContext context, UserProfileState state) {
    if (state.status == UserProfileStatus.signedOut) {
      Navigator.popAndPushNamed(context, RoutePaths.welcome);
    }
    switch (state.notification) {
      case UserProfileNotification.emailVerificationSent:
        Toasting.notifyToast(
          context,
          AppLocalizations.of(context)!.contProfileTEmailVerificationSent,
        );
        break;
      case UserProfileNotification.emailVerificationVerified:
        Toasting.notifyToast(
          context,
          AppLocalizations.of(context)!.contProfileTEmailVerified,
        );
        break;
      case UserProfileNotification.emailVerificationFailed:
        Toasting.notifyToast(
          context,
          '${AppLocalizations.of(context)!.contProfileTEmailVerificationFailed}: ${state.message}',
        );
        break;
      case UserProfileNotification.passwordEmailSent:
        Toasting.notifyToast(
          context,
          AppLocalizations.of(context)!.contProfileTPasswordEmailSent,
        );
        break;
      case UserProfileNotification.passwordEmailFailedSent:
        Toasting.notifyToast(
          context,
          '${AppLocalizations.of(context)!.contProfileTPasswordEmailFailedSent}: ${state.message}',
        );
        break;
      default:
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
          // TODO: Uncomment when user profile image is implemented
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: IconButton(
          //     icon: const Icon(Icons.edit),
          //     onPressed: () => showModalBottomSheet(
          //       context: context,
          //       builder: (_) {
          //         return _ProfileImageModalSelector(
          //           onTapCamera: () {
          //             context
          //                 .read<UserProfileBloc>()
          //                 .add(const UserEditPictureTake());
          //             Navigator.pop(context);
          //           },
          //           onTapImage: () {
          //             context
          //                 .read<UserProfileBloc>()
          //                 .add(const UserEditPictureLoad());
          //             Navigator.pop(context);
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _ProfileImageModalSelector extends StatelessWidget {
  final Function() _onTapCamera;
  final Function() _onTapImage;

  const _ProfileImageModalSelector({
    required Function() onTapCamera,
    required Function() onTapImage,
    Key? key,
  })  : _onTapCamera = onTapCamera,
        _onTapImage = onTapImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: _onTapCamera,
              icon: const Icon(Icons.photo_camera),
            ),
            IconButton(
              onPressed: _onTapImage,
              icon: const Icon(Icons.image),
            ),
          ],
        ),
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
        _UserProfileNickName(),
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
            // NOTE: Uncomment when user email verification is useful
            // suffixIcon: IconButton(
            //   icon: Icon(
            //     state.user.emailVerified
            //         ? Icons.verified_user
            //         : Icons.outgoing_mail,
            //   ),
            //   onPressed: state.user.emailVerified
            //       ? null
            //       : () {
            //           context.read<UserProfileBloc>().add(
            //                 const UserEmailVerification(),
            //               );
            //         },
            // ),
          ),
        );
      },
    );
  }
}

class _UserProfileNickName extends StatefulWidget {
  const _UserProfileNickName({Key? key}) : super(key: key);

  @override
  State<_UserProfileNickName> createState() => _UserProfileNickNameState();
}

class _UserProfileNickNameState extends State<_UserProfileNickName> {
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
                    icon: const Icon(Icons.restart_alt),
                    onPressed: () {
                      context
                          .read<UserProfileBloc>()
                          .add(const UserEditNicknameReset());
                    },
                  ),
                IconButton(
                  icon: Icon(
                    state.editingNickname ? Icons.check : Icons.edit,
                  ),
                  onPressed: () {
                    context
                        .read<UserProfileBloc>()
                        .add(UserEditNicknameToggle(context: context));
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
      child: Row(
        children: [
          const Icon(Icons.qr_code),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.contProfileBtnProfileTickets,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _ShowSupportTicketshButton extends StatelessWidget {
  const _ShowSupportTicketshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.pushNamed(context, RoutePaths.mySupportTickets),
      child: Row(
        children: [
          const Icon(Icons.contact_support),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
                AppLocalizations.of(context)!.contProfileBtnSupportTickets,
                textAlign: TextAlign.center),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<UserProfileBloc>().add(const UserSignOut());
      },
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return Row(
            children: [
              const Icon(Icons.logout),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                    state.isSigningOut
                        ? AppLocalizations.of(context)!.genProcessing
                        : AppLocalizations.of(context)!.contProfileBtnSignOut,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(width: 8),
            ],
          );
        },
      ),
    );
  }
}

class _AccoutOptionsButton extends StatelessWidget {
  const _AccoutOptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => InfoDialog(
          title: AppLocalizations.of(context)!.contProfileBtnOptions,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _ProfileRefreshButton(),
              _PasswordResetButton(),
              _DeleteAccountButton(),
            ],
          ),
        ),
      ),
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          return Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                child: Text(AppLocalizations.of(context)!.contProfileBtnOptions,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(width: 8),
            ],
          );
        },
      ),
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
