// import 'package:flutter/material.dart';
// import 'package:recase/recase.dart';

// class StocksHelper {
//   void addRowsToList(
//     List<Container> tileRow,
//     String ticker,
//   ) {
//     tileRow.add(
//       Container(
//         margin: EdgeInsets.only(top: 30),
//         height: 80,
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 241, 241, 251),
//           borderRadius: BorderRadius.all(
//             Radius.circular(30),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20, top: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     child: Text(
//                       stockName.titleCase,
//                       style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 16, 228, 169),
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                     ),
//                     padding: EdgeInsets.fromLTRB(7, 2, 7, 2),
//                     child: Text(
//                       'Units: ' + quantity,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Container(
//                     child: Text(
//                       date,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey[600],
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             DefaultTextStyle(
//               style: TextStyle(
//                   // color: Colors.black,
//                   color: Color.fromARGB(255, 4, 151, 110),
//                   fontWeight: FontWeight.bold),
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: Center(
//                         child: Text(
//                           type.titleCase,
//                           style: TextStyle(
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: Center(
//                         child: Text(
//                           '@',
//                           style: TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: Text(
//                         'Rs.' + amount,
//                         style: TextStyle(
//                           fontSize: 25,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
