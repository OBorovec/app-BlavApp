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
      titleText: AppLocalizations.of(context)!.profileDeleteTitle,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.profileDeleteText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const UserAuthDelete());
                },
                child:
                    Text(AppLocalizations.of(context)!.profileDeleteBtnConfirm),
              )
            ],
          ),
        ),
      ),
    );
  }
}
