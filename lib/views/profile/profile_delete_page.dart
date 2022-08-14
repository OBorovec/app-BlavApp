import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfileDeletePage extends StatelessWidget {
  const UserProfileDeletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      titleText: AppLocalizations.of(context)!.contProfileDeleteTitle,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.contProfileDeleteText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              _PasswordTextField(),
              ElevatedButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.genDelete),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  String value = '';
  bool _valueVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => value = value,
      obscureText: !_valueVisible,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.genPassword,
        hintText: AppLocalizations.of(context)!.genPassword,
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
