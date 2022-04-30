import 'package:blavapp/bloc/admin/voting_data/voting_data_bloc.dart';
import 'package:blavapp/bloc/admin/voting_results/voting_results_bloc.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VoteResults extends StatelessWidget {
  final String voteRef;
  const VoteResults({
    Key? key,
    required this.voteRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VotingResultsBloc(
        votingDataBloc: context.read<VotingDataBloc>(),
        voteRef: voteRef,
      ),
      child: BlocBuilder<VotingResultsBloc, VotingResultsState>(
        builder: (context, state) {
          return SidePage(
            titleText: AppLocalizations.of(context)!.adminCosplayResultsTitle,
            body: _VoteResultTable(state: state),
          );
        },
      ),
    );
  }
}

class _VoteResultTable extends StatelessWidget {
  final VotingResultsState state;

  const _VoteResultTable({
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
                        BlocProvider.of<VotingResultsBloc>(context).add(
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
                        BlocProvider.of<VotingResultsBloc>(context).add(
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
                        BlocProvider.of<VotingResultsBloc>(context).add(
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
                            result.record,
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

class VoteResultsArguments {
  final String voteRef;

  VoteResultsArguments({
    required this.voteRef,
  });
}
