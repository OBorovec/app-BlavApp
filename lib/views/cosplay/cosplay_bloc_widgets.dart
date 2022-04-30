import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CosplayRecordUpvote extends StatelessWidget {
  final CosplayRecord record;
  const CosplayRecordUpvote({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        return Container(
          color: state.userData.myVoting[record.id] != null &&
                  state.userData.myVoting[record.id]!
              ? Theme.of(context).focusColor
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<UserDataBloc>(context).add(
                  UserDataVoteCosplay(
                    voteRef: record.voteRef,
                    cosplayRef: record.id,
                    vote: true,
                  ),
                );
              },
              child: const Center(
                child: Icon(
                  Icons.thumb_up_alt,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CosplayRecordDownvote extends StatelessWidget {
  final CosplayRecord record;
  const CosplayRecordDownvote({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        return Container(
          color: state.userData.myVoting[record.id] != null &&
                  !state.userData.myVoting[record.id]!
              ? Theme.of(context).focusColor
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<UserDataBloc>(context).add(
                  UserDataVoteCosplay(
                    voteRef: record.voteRef,
                    cosplayRef: record.id,
                    vote: false,
                  ),
                );
              },
              child: const Center(
                child: Icon(
                  Icons.thumb_down_alt,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CosplayRecordNeutral extends StatelessWidget {
  final CosplayRecord record;
  const CosplayRecordNeutral({
    Key? key,
    required this.record,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        return Container(
          color: !state.userData.myVoting.containsKey(record.id) ||
                  state.userData.myVoting[record.id] == null
              ? Theme.of(context).focusColor
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<UserDataBloc>(context).add(
                  UserDataVoteCosplay(
                    voteRef: record.voteRef,
                    cosplayRef: record.id,
                    vote: null,
                  ),
                );
              },
              child: Center(
                child: Text(
                  '-',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
