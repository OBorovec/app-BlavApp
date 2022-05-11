import 'package:blavapp/components/_pages/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _editingNickName = false;

  final _focusEmail = FocusNode();
  final _controllerEmail = TextEditingController();

  final _focusNickname = FocusNode();
  final _controllerNickname = TextEditingController();

  @override
  void initState() {
    _editingNickName = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.profTitle,
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
          if (state is StandardNotificationState) {
            if (state.notification == EditNotification.verified) {
              Toasting.notifyToast(
                context,
                AppLocalizations.of(context)!.toastProfileVerified,
              );
            }
            if (state.notification == EditNotification.verificationSent) {
              Toasting.notifyToast(
                context,
                AppLocalizations.of(context)!.toastProfileVerificationSent,
              );
            }
          }
          if (state is ErrorNotificationState) {
            Toasting.notifyToast(context, state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _ProfileImage(
                  photoURL: widget.user.photoURL,
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return _ProfileImageModalSelector(
                        onTapCamera: () {
                          context
                              .read<UserProfileBloc>()
                              .add(UserPictureTake());
                        },
                        onTapImage: () {
                          context
                              .read<UserProfileBloc>()
                              .add(UserPictureLoad());
                        },
                      );
                    },
                  ),
                ),
                const _ProfileUID(),
                _ProfileEmail(
                  value: widget.user.email!,
                  switchBool: widget.user.emailVerified,
                  focusNode: _focusEmail,
                  textController: _controllerEmail,
                  onPressed: () {
                    context
                        .read<UserProfileBloc>()
                        .add(UserEmailVerificationPressed());
                  },
                ),
                _ProfileNickname(
                  value: widget.user.displayName!,
                  switchBool: _editingNickName,
                  focusNode: _focusNickname,
                  textController: _controllerNickname,
                  onPressed: () {
                    if (_editingNickName) {
                      context.read<UserProfileBloc>().add(
                            UserNicknameChange(
                              nicknameValue: _controllerNickname.text,
                              context: context,
                            ),
                          );
                    }
                    setState(() {
                      _editingNickName = !_editingNickName;
                    });
                  },
                ),
                Expanded(
                  child: Container(),
                ),
                const Divider(),
                SafeArea(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<UserProfileBloc>()
                              .add(UserPasswordResetPressed());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.profilePageBtnPswReset,
                        ),
                      ),
                      SignOutButton(
                        onPressed: () => context.read<UserBloc>().add(LogOut()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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
    return Padding(
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
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final String? _photoURL;
  final Function() _onPressed;

  const _ProfileImage({
    Key? key,
    required String? photoURL,
    required Function() onPressed,
  })  : _photoURL = photoURL,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: 128,
      child: Stack(
        children: [
          Positioned.fill(child: ProfileAvatar(photoURL: _photoURL)),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileUID extends StatelessWidget {
  const _ProfileUID({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Text('UID'),
      onLongPress: () {
        context.read<UserProfileBloc>().add(UserUIDHold());
      },
    );
  }
}

class _ProfileEmail extends StatelessWidget {
  final String _value;
  final bool _switchBool;
  final FocusNode _focusNode;
  final TextEditingController _textController;
  final Function() _onPressed;

  const _ProfileEmail({
    Key? key,
    required String value,
    required bool switchBool,
    required FocusNode focusNode,
    required TextEditingController textController,
    required Function() onPressed,
  })  : _value = value,
        _switchBool = switchBool,
        _focusNode = focusNode,
        _textController = textController,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormFieldEmail(
            textController: _textController..text = _value,
            focusNode: _focusNode,
          ),
        ),
        EmailVerifiedSwitch(
          isOn: _switchBool,
          onPressed: _onPressed,
        )
      ],
    );
  }
}

class _ProfileNickname extends StatelessWidget {
  final String _value;
  final bool _switchBool;
  final FocusNode _focusNode;
  final TextEditingController _textController;
  final Function() _onPressed;

  const _ProfileNickname({
    Key? key,
    required String value,
    required bool switchBool,
    required FocusNode focusNode,
    required TextEditingController textController,
    required Function() onPressed,
  })  : _value = value,
        _switchBool = switchBool,
        _focusNode = focusNode,
        _textController = textController,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormFieldNickname(
            textController: _textController..text = _value,
            focusNode: _focusNode,
            enabled: _switchBool,
          ),
        ),
        EditSaveSwitch(
          isOn: _switchBool,
          onPressed: _onPressed,
        )
      ],
    );
  }
}
