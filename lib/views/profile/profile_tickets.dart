import 'package:blavapp/bloc/profile/user_tickets/user_tickets_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/dialogs/qr_scanner_dialog.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileMyTicketsPage extends StatelessWidget {
  const ProfileMyTicketsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserTicketsBloc(
        tickets: context.read<UserDataBloc>().state.userData.tickets,
        dataRepo: context.read<DataRepo>(),
      ),
      child: SidePage(
        titleText: AppLocalizations.of(context)!.contProfileTicketsTitle,
        body: BlocBuilder<UserTicketsBloc, UserTicketsState>(
          builder: (context, state) {
            if (state.tickets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(AppLocalizations.of(context)!
                        .contProfileTicketsNoTickets),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.tickets.length,
                itemBuilder: (BuildContext context, int index) {
                  TicketData ticketData = state.tickets[index];
                  return _TicketCard(
                    ticketData: ticketData,
                    onTap: () => null,
                  );
                },
              );
            }
          },
        ),
        actions: [
          IconButton(
              onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => QRScannerDialog(
                      onScanned: () => Navigator.pop(context),
                    ),
                  ),
              icon: const Icon(Icons.photo_camera))
        ],
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final TicketData ticketData;
  final Function() onTap;
  const _TicketCard({
    Key? key,
    required this.ticketData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
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
      ),
    );
  }
}
