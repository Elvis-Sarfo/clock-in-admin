import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';

class DateTimeWidget extends StatelessWidget {
  final double? width, heigth;
  final bool showDate;
  const DateTimeWidget(
      {Key? key, this.heigth, this.width, this.showDate = true})
      : super(key: key);

  // var _clockBoxDeco = BoxDecoration(
  //   color: Color(0xFF003256).withOpacity(0.8),
  //   borderRadius: BorderRadius.circular(5),
  // );

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(const Duration(seconds: 1),
        builder: (context) {
      String hour = DateTime.now().hour.toString();
      String min = DateTime.now().minute.toString();
      String sec = DateTime.now().second.toString();
      String date =
          DateFormat('EEE, dd MMM, yyyy').format(DateTime.now()).toString();

      // final screenHeight = MediaQuery.of(context).size.height;
      // final screenWidth = MediaQuery.of(context).size.width;
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(3.0),
            height: heigth ?? 100,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 0,
                  // blurRadius: 10,
                ),
                BoxShadow(
                  color: Colors.white,
                  // offset: Offset(10, 10),
                  blurRadius: 3,
                  spreadRadius: -3,
                )
              ],
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(width: 0.5, color: Colors.black12),
            ),
            child: Container(
              // margin: EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(5.0),
              height: double.infinity,
              decoration: BoxDecoration(
                boxShadow: const [
                  // BoxShadow(
                  //   color: Colors.black38,
                  //   blurRadius: 1.0,
                  //   spreadRadius: 1,
                  //   // offset: Offset(2.2, 2.2)
                  // )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      flex: 1,
                      child: _buildTimeValueCard(
                          hour.length > 1 ? hour : '0$hour', 'Hours')),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: _buildTimeValueCard(
                          min.length > 1 ? min : '0$min', 'Minutes')),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: _buildTimeValueCard(
                          sec.length > 1 ? sec : '0$sec', 'Seconds')),
                ],
              ),
            ),
          ),
          if (showDate)
            Text(
              date,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
        ],
      );
    });
  }

  Widget _buildTimeValueCard(String? value, String? type) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 3.0,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.fill,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                value ?? '',
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w600,
                  fontSize: 70,
                  color: Colors.black87.withOpacity(0.6),
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            top: -5,
            child: Text(
              type ?? '',
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
