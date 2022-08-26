import 'package:blavapp/bloc/contacts/data_contacts/contacts_bloc.dart';
import 'package:blavapp/components/page_content/detail_not_found.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/model/contacts.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactDetails extends StatelessWidget {
  final String entityRef;
  const ContactDetails({
    Key? key,
    required this.entityRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactsBloc, ContactsState>(
      builder: (context, state) {
        ContactEntity? entity = state.contactEntities[entityRef];
        if (entity != null) {
          return SidePage(
            titleText: entity.name,
            body: _ContactDetailContent(entity: entity),
          );
        } else {
          return DetailNotFoundPage(
            message:
                '${AppLocalizations.of(context)!.contContactDetailNotFound} - entityRef: $entityRef',
          );
        }
      },
    );
  }
}

class _ContactDetailContent extends StatelessWidget {
  final ContactEntity entity;
  const _ContactDetailContent({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (entity.images.isNotEmpty)
            Hero(
              tag: contactImgHeroTag(entity),
              child: CircleAvatar(
                radius: 128,
                backgroundImage: NetworkImage(
                  entity.images[0],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ContactDetailsArguments {
  final String entityRef;

  ContactDetailsArguments({required this.entityRef});
}
