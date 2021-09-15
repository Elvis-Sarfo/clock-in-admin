import 'package:clock_in_admin/components/card_view.dart';
import 'package:clock_in_admin/components/clickable_text.dart';
import 'package:clock_in_admin/controllers/date_picker.dart';
import 'package:flutter/material.dart';

buildSummaryWidget(
  BuildContext context,
  DateRangePicker _pickDateRange,
) {
  return CardView(
      elevation: 1.0,
      margin: EdgeInsets.fromLTRB(7.0, 5.0, 7.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClickableText(
            text1: 'Summary ',
            textStyle1: _buildTextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
            text2: '${_pickDateRange.getEndDate()}',
            textStyle2: _buildTextStyle(color: Colors.grey, fontSize: 14.0),
          ),
          Divider(
            height: 20.0,
          ),
          Column(
            children: [
              //first row (present days)
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRESENT DAYS',
                        style: _buildTextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      SizedBox(height: 5.0),
                      Text('1 Day(s)',
                          style: _buildTextStyle(
                              color: Colors.green[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ABSENT DAYS',
                        style: _buildTextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      SizedBox(height: 5.0),
                      Text('1 Day(s)',
                          style: _buildTextStyle(
                              color: Colors.red[600],
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ],
                  ),

                  // ...List.generate(3, (index) {
                  //   return Expanded(
                  //     flex: 1,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           index == 0
                  //               ? 'PRESENT DAYS'
                  //               : index == 1
                  //                   ? 'WORK HOURS'
                  //                   : 'ABSENT DAYS',
                  //           style: _buildTextStyle(
                  //               color: Colors.grey,
                  //               fontWeight: FontWeight.w500,
                  //               fontSize: 16.0),
                  //         ),
                  //         SizedBox(height: 5.0),
                  //         Text(
                  //             index == 0
                  //                 ? '1 Day(s)'
                  //                 : index == 1
                  //                     ? '00h 02m'
                  //                     : '1 Day(s)',
                  //             style: _buildTextStyle(
                  //                 color: Colors.green[600],
                  //                 fontWeight: FontWeight.w500,
                  //                 fontSize: 16)),
                  //       ],
                  //     ),
                  //   );
                  // })
                ],
              ),

              // SizedBox(height: 30),

              //second row (days worked)

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ...List.generate(2, (index) {
              //       return Expanded(
              //         flex: 1,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               index == 0 ? 'DAYS WORKED' : 'HOURS WORKED',
              //               style: _buildTextStyle(
              //                   color: Colors.grey,
              //                   fontWeight: FontWeight.w500,
              //                   fontSize: 16.0),
              //             ),
              //             SizedBox(height: 5.0),
              //             Text(index == 0 ? '1 Day(s)' : '00h 02m',
              //                 style: _buildTextStyle(
              //                     color: Colors.blue[600],
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 16)),
              //           ],
              //         ),
              //       );
              //     }),
              //   ],
              // )
            ],
          )
        ],
      ));
}

_buildTextStyle(
    {double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    String? fontFamily,
    Color? color}) {
  return TextStyle(
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      color: color);
}
