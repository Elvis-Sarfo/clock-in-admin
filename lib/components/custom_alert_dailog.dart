import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title, descriptions;
  final Widget? dialogIcon;
  final List<Widget>? actionsButtons;

  const CustomAlertDialog({
    Key? key,
    @required this.title,
    this.descriptions,
    this.actionsButtons,
    this.dialogIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, Size size) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          constraints: BoxConstraints(
            maxWidth: Responsive.isMobile(context)
                ? double.infinity
                : size.width * 0.3,
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[700] ?? Styles.primaryColor,
                offset: Offset(0, 3),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                descriptions ?? '',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: actionsButtons ?? [],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Constants.avatarRadius,
                  ),
                ),
                child: dialogIcon ?? Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 15;
  static const double avatarRadius = 45;
}
