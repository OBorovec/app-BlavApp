import 'package:blavapp/bloc/admin/admin_ticket_checker/ticket_checker_bloc.dart';
import 'package:blavapp/components/page_hierarchy/side_page.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class TicketValidationPage extends StatelessWidget {
  const TicketValidationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicketCheckerBloc(
        dataRepo: context.read<DataRepo>(),
      ),
      child: SidePage(
        titleText: AppLocalizations.of(context)!.adminTicketCheckerTitle,
        body: BlocBuilder<TicketCheckerBloc, TicketCheckerState>(
          builder: (context, state) {
            switch (state.status) {
              case TicketCheckerStatus.scanning:
                return const _QRScanner();
              case TicketCheckerStatus.ready:
                return _TicketDetails(ticketState: state);
              case TicketCheckerStatus.failed:
                return _TicketFailed(ticketState: state);
            }
          },
        ),
      ),
    );
  }
}

class _TicketDetails extends StatelessWidget {
  final TicketCheckerState ticketState;

  const _TicketDetails({
    Key? key,
    required this.ticketState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                _InfoRow(
                  keyText:
                      AppLocalizations.of(context)!.adminTicketCheckerEventName,
                  value: t(ticketState.event!.name, context),
                ),
                _InfoRow(
                  keyText: AppLocalizations.of(context)!
                      .adminTicketCheckerEventOwnerMail,
                  value: ticketState.ticket!.ownerMail,
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Divider(),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  context.read<TicketCheckerBloc>().add(const TicketRedeem());
                },
                child: Text(
                    AppLocalizations.of(context)!.adminTicketCheckerBtnRedeem),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<TicketCheckerBloc>().add(const ScanNextTicket());
                },
                child: Text(
                    AppLocalizations.of(context)!.adminTicketCheckerBtnNext),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String keyText;
  final String value;

  const _InfoRow({
    Key? key,
    required this.keyText,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(keyText),
        Text(value),
      ],
    );
  }
}

class _QRScanner extends StatelessWidget {
  const _QRScanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      allowDuplicates: false,
      onDetect: (barcode, args) {
        context
            .read<TicketCheckerBloc>()
            .add(TicketScanned(barcodeValue: barcode.rawValue));
      },
    );
  }
}

class _TicketFailed extends StatelessWidget {
  final TicketCheckerState ticketState;

  const _TicketFailed({
    Key? key,
    required this.ticketState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(ticketState.message),
              ],
            ),
          ),
          Column(
            children: [
              const Divider(),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  context.read<TicketCheckerBloc>().add(const ScanNextTicket());
                },
                child: Text(
                    AppLocalizations.of(context)!.adminTicketCheckerBtnNext),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
