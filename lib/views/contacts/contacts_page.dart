import 'package:blavapp/bloc/contacts/data_contacts/contacts_bloc.dart';
import 'package:blavapp/components/page_hierarchy/data_error_page.dart';
import 'package:blavapp/components/page_hierarchy/data_loading_page.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/utils/toasting.dart';
import 'package:blavapp/views/contacts/contact_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactsBloc, ContactsState>(
      listenWhen: (previous, current) => previous.message != current.message,
      listener: (context, state) {
        if (state.status == DataStatus.error) {
          Toasting.notifyToast(context, state.message);
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case DataStatus.loaded:
            return Builder(builder: (context) {
              return RootPage(
                  titleText: AppLocalizations.of(context)!.contContactsTitle,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        _ContactsList(state: state),
                      ],
                    ),
                  ));
            });
          case DataStatus.error:
            return DataErrorPage(message: state.message);
          case DataStatus.initial:
            return const DataLoadingPage();
        }
      },
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
