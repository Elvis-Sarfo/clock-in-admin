// import 'package:clock_in_admin/responsive.dart';
// import 'package:clock_in_admin/styles/styles.dart';
// import 'package:flutter/material.dart';

// class TableHeader extends StatelessWidget {
//   final String title;
//   final List<Widget?> actions;
//   TableHeader({
//     Key? key,
//     this.title = '',
//     actions,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             this.title,
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           Row(
//             children: [
//               ElevatedButton.icon(
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Styles.defaultPadding * 1.5,
//                     vertical: Styles.defaultPadding /
//                         (Responsive.isMobile(context) ? 2 : 1),
//                   ),
//                 ),
//                 onPressed: () {},
//                 icon: Icon(Icons.add),
//                 label: Text("Add New"),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
