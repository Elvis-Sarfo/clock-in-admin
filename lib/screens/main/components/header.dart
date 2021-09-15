import 'package:clock_in_admin/controllers/menu.controller.dart';
import 'package:clock_in_admin/controllers/page_route.controller.dart';
import 'package:clock_in_admin/responsive.dart';
import 'package:clock_in_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_builder/timer_builder.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Styles.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 4),
            spreadRadius: 1.0,
            color: Styles.primaryColor.withOpacity(0.10),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Styles.primaryColor,
              ),
              onPressed: context.read<MenuController>().controlMenu,
            ),
          Text(
            context.watch<PageRouteController>().pageTitle,
            style: Theme.of(context).textTheme.headline4,
          ),
          // if (!Responsive.isMobile(context))
          //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          // Expanded(child: SearchField()),
          Spacer(),
          _buildTime(),

          ProfileCard()
        ],
      ),
    );
  }

  _buildTime() {
    var textStyle = GoogleFonts.robotoCondensed(
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Colors.black87.withOpacity(0.6),
    );
    return TimerBuilder.periodic(const Duration(seconds: 1),
        builder: (context) {
      String hour = DateTime.now().hour.toString();
      String min = DateTime.now().minute.toString();
      String sec = DateTime.now().second.toString();
      String date =
          DateFormat('EEE, dd MMM, yyyy').format(DateTime.now()).toString();
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 0.0),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: hour.length > 1 ? hour : '0$hour',
                    style: textStyle,
                  ),
                  TextSpan(
                    text: ":",
                    style: textStyle,
                  ),
                  TextSpan(
                    text: min.length > 1 ? min : '0$min',
                    style: textStyle,
                  ),
                  TextSpan(
                    text: ":",
                    style: textStyle,
                  ),
                  TextSpan(
                    text: sec.length > 1 ? sec : '0$sec',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            Text(
              date,
              style: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.8,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Styles.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: Styles.defaultPadding,
        vertical: Styles.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Styles.border,
      ),
      child: Row(
        children: [
          // Image.asset(
          //   "assets/images/profile_pic.png",
          //   height: 38,
          // ),
          Icon(
            Icons.person,
            size: 28,
            color: Colors.black87,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Styles.defaultPadding / 2),
              child: Text(
                context.watch<PageRouteController>().adminUsername,
              ),
            ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black87,
            size: 24,
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Styles.secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(Styles.defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: Styles.defaultPadding / 2),
            decoration: BoxDecoration(
              color: Styles.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
