import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.loginTitle,
      body: BlocProvider(
        create: (context) => SignInBloc(
          authRepo: context.read<AuthRepo>(),
        ),
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is LoginFailState) {
              Toasting.notifyToast(context, state.message);
            } else if (state is LoginSuccessState) {}
          },
          builder: (context, state) {
            if (state is LoginLoadingState) {
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
              SignInButton(onPressed: () => _loginUser(context)),
              SignUpButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RoutePaths.registration),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loginUser(BuildContext context) async {
    _focusEmail.unfocus();
    _focusPassword.unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(
            UserSignInEvent(
              _emailTextController.text,
              _passwordTextController.text,
            ),
          );
    }
  }
}
