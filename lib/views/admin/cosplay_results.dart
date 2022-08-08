import 'package:blavapp/bloc/admin/cosplay_voting_results/cosplay_voting_results_bloc.dart';
import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/components/bloc_pages/bloc_error_page.dart';
import 'package:blavapp/components/bloc_pages/bloc_loading_page.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CosplayResults extends StatelessWidget {
  final String eventRef;
  final String voteRef;
  const CosplayResults({
    Key? key,
    required this.eventRef,
    required this.voteRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CosplayVotingResultsBloc(
        dataRepo: context.read<DataRepo>(),
        cosplayBloc: context.read<CosplayBloc>(),
        eventRef: eventRef,
        voteRef: voteRef,
      ),
      child: BlocBuilder<CosplayVotingResultsBloc, CosplayVotingResultsState>(
        builder: (context, state) {
          switch (state.status) {
            case CosplayVotingResultsStatus.ready:
              return SidePage(
                titleText:
                    AppLocalizations.of(context)!.adminCosplayResultsTitle,
                body: _CosplayResultsList(state: state),
              );
            case CosplayVotingResultsStatus.initial:
              return const BlocLoadingPage();
            case CosplayVotingResultsStatus.error:
              return BlocErrorPage(message: state.message);
          }
        },
      ),
    );
  }
}

class _CosplayResultsList extends StatelessWidget {
  final CosplayVotingResultsState state;

  const _CosplayResultsList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () =>
                        BlocProvider.of<CosplayVotingResultsBloc>(context).add(
                      const ChangeSort(
                        sort: CosplayVotingResultsSort.upVote,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!
                          .adminCosplayResultsClmUpVote,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () =>
                        BlocProvider.of<CosplayVotingResultsBloc>(context).add(
                      const ChangeSort(
                        sort: CosplayVotingResultsSort.downVote,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!
                          .adminCosplayResultsClmDownVote,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () =>
                        BlocProvider.of<CosplayVotingResultsBloc>(context).add(
                      const ChangeSort(
                        sort: CosplayVotingResultsSort.score,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.adminCosplayResultsClmScore,
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.votingResults.length,
              itemBuilder: (context, index) {
                final VotingResult result = state.votingResults[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            t(result.record.name, context),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${result.upVotes}',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${result.downVotes}',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '${result.scoreVotes}',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CosplayVotingResultsArguments {
  final String eventRef;
  final String voteRef;

  CosplayVotingResultsArguments({
    required this.eventRef,
    required this.voteRef,
  });
}
