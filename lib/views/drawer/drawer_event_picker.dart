// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class DrawerEventPicker extends StatelessWidget {
//   const DrawerEventPicker({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => EventsBloc(
//         dataRepo: context.read<DataRepo>(),
//       )..add(LoadEvents()),
//       child: BlocConsumer<EventsBloc, EventsState>(
//         listener: (context, state) {
//           if (state is EventsFailState) {
//             Toasting.notifyToast(context, state.message);
//           }
//         },
//         builder: (context, state) {
//           if (state is EventsLoadedState) {
//             return _buildEventPickerList(context, state.events);
//           }
//           return const Center(
//             child: LoadingIndicator(),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEventPickerList(BuildContext context, List<Event> events) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Center(
//         child: ListView.builder(
//           itemCount: events.length,
//           itemBuilder: (BuildContext context, int index) {
//             return DrawerEventCard(
//               event: events[index],
//               onTapHandler: () => {
//                 context.read<EventFocusBloc>().add(
//                       EventFocusChanged(eventID: events[index].eventID),
//                     )
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
