import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/programme/filter_programme/filter_programme_bloc.dart';
import 'package:blavapp/components/control/button_switch.dart';
import 'package:blavapp/model/programme.dart';
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
            Row(
              children: [
                const Expanded(child: _TextSearchLine()),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () => _showSearchOptions(context, state),
                  iconSize: 48,
                ),
              ],
            ),
            const SizedBox(height: 4),
            _buildActiveSearchTagWrap(state, context),
          ],
        );
      },
    );
  }

  Widget _buildActiveSearchTagWrap(
    FilterProgrammeState state,
    BuildContext context,
  ) {
    return Wrap(
      children: [
        ...state.dateFilter.map((e) => _ProgrammeDateSearchTag(date: e)),
        ...state.entryTypeFilter.map((e) => _ProgrammeTypeSearchTag(type: e)),
        ...state.entryPlacesFilter
            .map((e) => _ProgrammePlaceSearchTag(placeRef: e)),
      ],
    );
  }
}

Future<dynamic> _showSearchOptions(
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
                  AppLocalizations.of(context)!.contProgrammeListSearchPredef,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 8),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!
                      .contProgrammeListSearchAvailableDates,
                  Icons.access_time_outlined,
                ),
                Wrap(
                  children: state.availableDates
                      .map((e) => _ProgrammeDateSearchTag(date: e))
                      .toList(),
                ),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!
                      .contProgrammeListSearchAvailableCategs,
                  Icons.place_outlined,
                ),
                Wrap(
                  children: state.availableEntryTypes
                      .map((e) => _ProgrammeTypeSearchTag(type: e))
                      .toList(),
                ),
                _buildModalSubtitle(
                  context,
                  AppLocalizations.of(context)!
                      .contProgrammeListSearchAvailablePlaces,
                  Icons.category_outlined,
                ),
                Wrap(
                  children: state.availableEntryPlaces
                      .map((e) => _ProgrammePlaceSearchTag(placeRef: e ?? ''))
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

Padding _buildModalSubtitle(
  BuildContext context,
  String text,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    ),
  );
}

class _TextSearchLine extends StatefulWidget {
  const _TextSearchLine({
    Key? key,
  }) : super(key: key);

  @override
  State<_TextSearchLine> createState() => __TextSearchLineState();
}

class __TextSearchLineState extends State<_TextSearchLine> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.addListener(_textSearchLineChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.contProgrammeListSearchHint,
          suffixIcon: IconButton(
            icon: _textController.text.isEmpty
                ? const Icon(Icons.search)
                : const Icon(Icons.cancel),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _textController.clear();
              }
            },
          ),
        ),
      ),
    );
  }

  void _textSearchLineChange() {
    BlocProvider.of<FilterProgrammeBloc>(context)
        .add(ProgrammeTextFilter(_textController.text));
    setState(() {
      // Just to trigger rebuild of icons
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
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
              color: Theme.of(context).focusColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 1.0,
                horizontal: 4,
              ),
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

class _ProgrammeTypeSearchTag extends _ProgrammeSearchTag {
  final ProgEntryType type;
  _ProgrammeTypeSearchTag({
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

class _ProgrammePlaceSearchTag extends _ProgrammeSearchTag {
  final String placeRef;
  _ProgrammePlaceSearchTag({
    Key? key,
    required this.placeRef,
  }) : super(key: key, onPressedEvent: ProgrammePlaceFilter(placeRef));

  @override
  String _getLabelText(BuildContext context) {
    ProgrammeState prgState = BlocProvider.of<ProgrammeBloc>(context).state;
    ProgPlace? place = prgState.programmePlaces[placeRef];
    return place != null ? t(place.name, context) : '?$placeRef';
  }

  @override
  bool _isOn(FilterProgrammeState state) {
    return !state.entryPlacesFilter.contains(placeRef);
  }
}
