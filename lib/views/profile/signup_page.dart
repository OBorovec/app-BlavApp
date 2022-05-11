import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nicknameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusNickname = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: AppLocalizations.of(context)!.registrationTitle,
      body: BlocProvider(
        create: (context) => UserSignUpBloc(
          authRepo: context.read<AuthRepo>(),
          dataRepo: context.read<DataRepo>(),
        ),
        child: BlocConsumer<UserSignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              Toasting.notifyToast(context, state.message);
            } else if (state is SignUpSuccessful) {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(RoutePaths.profile);
            }
          },
          builder: (context, state) {
            if (state is SignUpLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return _buildForm(context);
            }
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormFieldNickname(
            focusNode: _focusNickname,
            textController: _nicknameTextController,
          ),
          const SizedBox(height: 8.0),
          TextFormFieldEmail(
            readOnly: false,
            focusNode: _focusEmail,
            textController: _emailTextController,
          ),
          const SizedBox(height: 8.0),
          TextFormFieldPassword(
            focusNode: _focusPassword,
            textController: _passwordTextController,
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SignUpButton(
                onPressed: () => _registerUser(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser(BuildContext context) async {
    _focusNickname.unfocus();
    _focusEmail.unfocus();
    _focusPassword.unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<UserSignUpBloc>().add(
            UserSignUpEvent(
              _emailTextController.text,
              _nicknameTextController.text,
              _passwordTextController.text,
            ),
          );
    }
  }
}
