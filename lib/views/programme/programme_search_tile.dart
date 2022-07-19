import 'package:blavapp/bloc/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/prog_entry.dart';
import 'package:blavapp/utils/app_themes.dart';
import 'package:blavapp/utils/datetime_formatter.dart';
import 'package:blavapp/utils/model_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgrammeSearchTile extends StatelessWidget {
  const ProgrammeSearchTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterProgrammeBloc, FilterProgrammeState>(
      builder: (context, state) {
        return Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: _buildTextSearchLine(context, state)),
                  const VerticalDivider(),
                  IconButton(
                    icon: const Icon(Icons.manage_search),
                    onPressed: () => _showAvailableSearchTags(context, state),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            _buildActiveSearchTagWrap(state, context),
          ],
        );
      },
    );
  }

  Widget _buildTextSearchLine(
    BuildContext context,
    FilterProgrammeState state,
  ) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          onChanged: (value) {
            BlocProvider.of<FilterProgrammeBloc>(context)
                .add(ProgrammeTextFilter(value));
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.progSearchHint,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => _showAvailableSearchTags(context, state),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showAvailableSearchTags(
    BuildContext context,
    FilterProgrammeState state,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<FilterProgrammeBloc>(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.progSearchPredef,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.progSearchAvailableDates,
                    Icons.access_time_outlined,
                  ),
                  Wrap(
                    children: state.availableDates
                        .map((e) => _ProgrammeDateSearchTag(date: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.progSearchAvailableCategs,
                    Icons.place_outlined,
                  ),
                  Wrap(
                    children: state.availableEntryTypes
                        .map((e) => ProgrammeTypeSearchTag(type: e))
                        .toList(),
                  ),
                  _buildFilterSubtitle(
                    context,
                    AppLocalizations.of(context)!.progSearchAvailablePlaces,
                    Icons.category_outlined,
                  ),
                  Wrap(
                    children: state.availableEntryPlaces
                        .map((e) =>
                            ProgrammePlaceSearchTag(placeRef: e ?? 'Unset'))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding _buildFilterSubtitle(
      BuildContext context, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Icon(icon, size: 16),
        ],
      ),
    );
  }

  Widget _buildActiveSearchTagWrap(
    FilterProgrammeState state,
    BuildContext context,
  ) {
    return Wrap(
      children: [
        ...state.dateFilter.map((e) => _ProgrammeDateSearchTag(date: e)),
        ...state.entryTypeFilter.map((e) => ProgrammeTypeSearchTag(type: e)),
        ...state.entryPlacesFilter
            .map((e) => ProgrammePlaceSearchTag(placeRef: e)),
      ],
    );
  }
}

abstract class _ProgrammeSearchTag extends StatelessWidget {
  final FilterProgrammeEvent onPressedEvent;

  const _ProgrammeSearchTag({
    Key? key,
    required this.onPressedEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterProgrammeBloc, FilterProgrammeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
              color: getAppBarColor(context),
              border: Border.all(color: getAppBarColor(context)),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getLabelText(context)),
                  AddSwitch(
                    isOn: _isOn(state),
                    onPressed: () {
                      BlocProvider.of<FilterProgrammeBloc>(context).add(
                        onPressedEvent,
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isOn(FilterProgrammeState state);

  String _getLabelText(BuildContext context);
}

class _ProgrammeDateSearchTag extends _ProgrammeSearchTag {
  final DateTime date;

  _ProgrammeDateSearchTag({
    Key? key,
    required this.date,
  }) : super(key: key, onPressedEvent: ProgrammeDateFilter(date));

  @override
  String _getLabelText(BuildContext context) {
    return datetimeDayDate(date, context);
  }

  @override
  bool _isOn(FilterProgrammeState state) {
    return !state.dateFilter.contains(date);
  }
}

class ProgrammeTypeSearchTag extends _ProgrammeSearchTag {
  final ProgEntryType type;
  ProgrammeTypeSearchTag({
    Key? key,
    required this.type,
  }) : super(
          key: key,
          onPressedEvent: ProgrammeTypeFilter(type),
        );

  @override
  String _getLabelText(BuildContext context) {
    return tProgEntryType(type, context);
  }

  @override
  bool _isOn(FilterProgrammeState state) {
    return !state.entryTypeFilter.contains(type);
  }
}

class ProgrammePlaceSearchTag extends _ProgrammeSearchTag {
  final String placeRef;
  ProgrammePlaceSearchTag({
    Key? key,
    required this.placeRef,
  }) : super(key: key, onPressedEvent: ProgrammePlaceFilter(placeRef));

  @override
  String _getLabelText(BuildContext context) {
    return placeRef;
  }

  @override
  bool _isOn(FilterProgrammeState state) {
    return !state.entryPlacesFilter.contains(placeRef);
  }
}
