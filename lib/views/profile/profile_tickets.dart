import 'package:blavapp/bloc/profile/user_tickets/user_tickets_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileMyTicketsPage extends StatelessWidget {
  const ProfileMyTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserTicketsBloc(
        tickets: context.read<UserDataBloc>().state.usedData.tickets,
        dataRepo: context.read<DataRepo>(),
      ),
      child: SidePage(
        titleText: AppLocalizations.of(context)!.profileTicketsTitle,
        body: BlocBuilder<UserTicketsBloc, UserTicketsState>(
          builder: (context, state) {
            switch (state.status) {
              case UserTicketsStatus.ready:
                if (state.tickets.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AppLocalizations.of(context)!
                            .profileTicketsNoTickets),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: state.tickets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _TicketCard(
                          ticketData: state.tickets[index],
                        );
                      });
                }
              case UserTicketsStatus.init:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircularProgressIndicator(),
                      Text(AppLocalizations.of(context)!.loading),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketData ticketData;
  const _TicketCard({
    Key? key,
    required this.ticketData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t(ticketData.event.name, context),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(datetimeToDateShort(
                  ticketData.event.dayStart,
                  context,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
