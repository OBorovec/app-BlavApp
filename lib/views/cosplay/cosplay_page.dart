import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_error_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_loading_page.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CosplayPage extends StatelessWidget {
  const CosplayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CosplayBloc, CosplayState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == CosplayStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case CosplayStatus.loaded:
            return Builder(builder: (context) {
              return RootPage(
                titleText: AppLocalizations.of(context)!.cospTitle,
                body: Center(
                  child: Text(AppLocalizations.of(context)!.cospTitle),
                ),
              );
            });
          case CosplayStatus.error:
            return BlocErrorPage(message: state.message);
          case CosplayStatus.initial:
            return const BlocLoadingPage();
        }
      },
    );
  }
}
