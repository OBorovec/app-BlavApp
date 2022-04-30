import 'package:blavapp/bloc/contacts/data_contacts/contacts_bloc.dart';
import 'package:blavapp/components/page_content/detail_not_found.dart';
import 'package:blavapp/components/pages/page_side.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/model/contacts.dart';
import 'package:blavapp/utils/app_heros.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:blavapp/views/story/story_bloc_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (entity.images.isNotEmpty) _EntityImage(entity: entity),
            _EntityName(entity: entity),
            _EntityContacts(entity: entity),
            _EntityDetails(entity: entity),
            if (entity.storyEntityRef.isNotEmpty)
              _EntityStoryEntities(entity: entity),
          ],
        ),
      ),
    );
  }
}

class _EntityImage extends StatelessWidget {
  const _EntityImage({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final ContactEntity entity;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: contactImgHeroTag(entity),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 128,
          backgroundImage: NetworkImage(
            entity.images[0],
          ),
        ),
      ),
    );
  }
}

class _EntityName extends StatelessWidget {
  const _EntityName({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final ContactEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          entity.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        if (entity.sDesc != null)
          Text(
            t(entity.sDesc!, context),
            style: Theme.of(context).textTheme.subtitle1,
          ),
      ],
    );
  }
}

class _EntityContacts extends StatelessWidget {
  const _EntityContacts({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final ContactEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (entity.tel != null)
          _buildContact(
            Icons.phone,
            entity.tel!,
            context,
            () async {
              launchUrl(Uri.parse('tel:${entity.tel!}'));
            },
          ),
        if (entity.email != null)
          _buildContact(
            Icons.email,
            entity.email!,
            context,
            () async {
              launchUrl(Uri.parse('mailto:${entity.email!}'));
            },
          ),
      ],
    );
  }

  Widget _buildContact(
    IconData icon,
    String text,
    BuildContext context,
    Function()? onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _EntityDetails extends StatelessWidget {
  const _EntityDetails({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final ContactEntity entity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (entity.desc != null)
            Text(
              t(entity.desc!, context),
            ),
        ],
      ),
    );
  }
}

class _EntityStoryEntities extends StatelessWidget {
  final ContactEntity entity;
  const _EntityStoryEntities({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TitleDivider(
            title: AppLocalizations.of(context)!.contContactEntryStory),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: entity.storyEntityRef.map((storyEntityRef) {
              return StoryEntityAvatar(entityRef: storyEntityRef);
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class ContactDetailsArguments {
  final String entityRef;

  ContactDetailsArguments({required this.entityRef});
}
