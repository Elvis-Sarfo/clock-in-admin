import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.title,
    required this.tapEvent,
    required this.color,
    this.textColor,
    this.iconData,
    this.isLoading,
    this.disabled,
  }) : super(key: key);

  final String title;
  final GestureTapCallback tapEvent;
  final Color color;
  final Color? textColor;
  final IconData? iconData;
  final bool? isLoading, disabled;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: 50.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: iconData == null
            ? ElevatedButton(
                onPressed: tapEvent,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                  ),
                ),
                child: isLoading != null && isLoading!
                    ? SpinKitFadingCircle(
                        color: Colors.white,
                        size: 20.0,
                      )

                    // Image.asset(
                    //     'assets/images/spinner.gif',
                    //     width: 19.0,
                    //     height: 19.0,
                    //   )
                    : Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              )
            : ElevatedButton.icon(
                onPressed: tapEvent,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                  ),
                ),
                icon: Icon(iconData),
                label: isLoading != null && isLoading!
                    ? SpinKitFadingCircle(
                        color: Colors.white,
                        size: 20.0,
                      )
                    : Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
      ),
    );
  }
}
