import 'package:blavapp/bloc/admin/voting_data/voting_data_bloc.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/admin/vote_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VotingDataBloc, VotingDataState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == VotingDataStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case VotingDataStatus.loaded:
            return SidePage(
              titleText: AppLocalizations.of(context)!.adminVotingTitle,
              body: _VotingList(state: state),
            );
          case VotingDataStatus.initial:
            return const DataLoadingPage();
          case VotingDataStatus.error:
            return DataErrorPage(message: state.message);
        }
      },
    );
  }
}

class _VotingList extends StatelessWidget {
  final VotingDataState state;
  const _VotingList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: state.data.keys
            .map(
              (String key) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.adminVotingResults,
                    arguments: VoteResultsArguments(voteRef: key),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(
                      key,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
