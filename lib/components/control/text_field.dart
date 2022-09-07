import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailTextField extends StatelessWidget {
  final Function(String) onChange;
  final bool isValid;

  const EmailTextField({
    Key? key,
    required this.onChange,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      onChanged: onChange,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.genEmail,
        hintText: AppLocalizations.of(context)!.genEmail,
        errorText: !isValid
            ? AppLocalizations.of(context)!.contSignUpEmailError
            : null,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        icon: const Icon(Icons.mail),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final Function(String) onChange;
  final bool isValid;

  const PasswordTextField({
    Key? key,
    required this.onChange,
    required this.isValid,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _valueVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      onChanged: widget.onChange,
      obscureText: !_valueVisible,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.genPassword,
        hintText: AppLocalizations.of(context)!.genPassword,
        errorText: !widget.isValid
            ? AppLocalizations.of(context)!.contSignUpPswError
            : null,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        icon: const Icon(Icons.security),
        suffixIcon: IconButton(
          icon: Icon(
            _valueVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _valueVisible = !_valueVisible;
            });
          },
        ),
      ),
    );
  }
}

class NickTextField extends StatelessWidget {
  final Function(String) onChange;
  final bool isValid;

  const NickTextField({
    Key? key,
    required this.onChange,
    required this.isValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.genNick,
        hintText: AppLocalizations.of(context)!.genNick,
        errorText:
            !isValid ? AppLocalizations.of(context)!.contSignUpNickError : null,
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        icon: const Icon(Icons.perm_identity),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final Function(String) onChange;
  const SearchTextField({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      enableSuggestions: false,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.genSearch,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }
}
