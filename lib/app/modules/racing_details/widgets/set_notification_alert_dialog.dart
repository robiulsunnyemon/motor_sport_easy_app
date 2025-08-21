

// class SetNotificationAlertDialog extends StatelessWidget {
//   final String eventId;
//   final String raceId;
//   final String eventName;
//   final DateTime eventDate;
//   final int hour;
//
// SetNotificationAlertDialog({super.key, required this.eventId, required this.raceId, required this.eventName, required this.eventDate, required this.hour});
//
//   final _controller = Get.put(RacingDetailsController());
//    final List<int> selectedTimes = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       title: const Text('Set notification'),
//       content: SizedBox(
//         height: 250,
//         width: double.maxFinite,
//         child: Obx(()=>Column(
//           spacing: 8,
//           children: [
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFF3F4F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     '8 Hour before race',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Switch(
//                     value: _controller.is8Hour.value,
//                     activeColor: Colors.red,
//                     onChanged: (bool value) {
//                       selectedTimes.add(8);
//                       _controller.set8Hour(
//                           eventName:eventName,
//                           date: eventDate, hour: 8
//                       );
//
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFF3F4F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     '6 Hour before race',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Switch(
//                     value: _controller.is6Hour.value,
//                     activeColor: Colors.red,
//                     onChanged: (bool value) {
//                       selectedTimes.add(6);
//                       _controller.set6Hour(
//                         eventName: eventName,
//                         date: eventDate,
//                         hour: 6,
//
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFF3F4F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     '3 Hour before race',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   Switch(
//                     value: _controller.is3Hour.value,
//                     activeColor: Colors.red,
//                     onChanged: (bool value) {
//                       selectedTimes.add(3);
//                       _controller.set3Hour(
//                           eventName:eventName, date: eventDate, hour: 3);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: ShapeDecoration(
//                 color: const Color(0xFFF3F4F6),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 30,
//                     child: IconButton(
//                       onPressed: () {
//                         _controller.decreaseSetHour();
//                       },
//                       icon: Icon(Icons.arrow_back_ios),
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStatePropertyAll<Color>(
//                           Colors.white,
//                         ),
//                         elevation: WidgetStatePropertyAll<double>(0.2),
//                         shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '${_controller.setHour.value} Hour',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 30,
//                     child: IconButton(
//                       onPressed: () {
//                         _controller.increaseSetHour();
//                       },
//                       icon: Icon(Icons.arrow_forward_ios),
//                       style: ButtonStyle(
//                         backgroundColor: WidgetStatePropertyAll<Color>(
//                           Colors.white,
//                         ),
//                         elevation: WidgetStatePropertyAll<double>(0.2),
//                         shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),)
//       ),
//       actions: <Widget>[
//         CustomElevatedButton(
//           level: "Save",
//           onTap: (){
//             Get.back();
//             selectedTimes.add(_controller.setHour.value);
//             _controller.sendNotificationToApi(eventName: eventName, date: eventDate, hour: _controller.setHour.value);
//           },
//         )
//       ],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     );
//   }
// }
