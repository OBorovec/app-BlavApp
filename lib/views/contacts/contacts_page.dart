import 'package:blavapp/bloc/contacts/data_contacts/contacts_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/components/dialogs/support_dialog.dart';
import 'package:blavapp/components/page_content/data_error_page.dart';
import 'package:blavapp/components/page_content/data_loading_page.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/contacts/contact_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        switch (state.status) {
          case ContactsStatus.loaded:
            return RootPage(
                titleText: AppLocalizations.of(context)!.contContactsTitle,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _RequestHelp(state: state),
                            if (state.contacts.instruction != null) ...[
                              const SizedBox(width: 16),
                              _ContactsInstructions(state: state),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        _ContactsList(state: state),
                      ],
                    ),
                  ),
                ));
          case ContactsStatus.error:
            return DataErrorPage(message: state.message);
          case ContactsStatus.initial:
            return const DataLoadingPage();
        }
      },
    );
  }
}

class _RequestHelp extends StatelessWidget {
  final ContactsState state;
  const _RequestHelp({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => SupportDialog(
                title: AppLocalizations.of(context)!.contContactsDiagHelp,
                onSubmit: (title, message) =>
                    BlocProvider.of<UserDataBloc>(context).add(
                  UserSupportTicket(
                    title: title,
                    message: message,
                  ),
                ),
              ),
            ),
            icon: const Icon(Icons.help),
            iconSize: 64,
          ),
          Text(AppLocalizations.of(context)!.contContactsReqHelp),
        ],
      ),
    );
  }
}

class _ContactsInstructions extends StatelessWidget {
  final ContactsState state;
  const _ContactsInstructions({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(
        t(state.contacts.instruction!, context),
      ),
    );
  }
}

class _ContactsList extends StatelessWidget {
  final ContactsState state;
  const _ContactsList({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleDivider(
          title: AppLocalizations.of(context)!.contContactsList,
        ),
        Column(
          children: state.contactEntities.entries.map((e) {
            return Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                    context, RoutePaths.contactEntity,
                    arguments: ContactDetailsArguments(entityRef: e.key)),
                title: Text(e.value.name),
                subtitle: Text(t(
                  e.value.type,
                  context,
                )),
                leading: e.value.images.isNotEmpty
                    ? Hero(
                        tag: contactImgHeroTag(e.value),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            e.value.images[0],
                          ),
                        ),
                      )
                    : null,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
