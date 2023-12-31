
import 'package:flutter/material.dart';
import 'package:receipts_bayanatz/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {Key? key,
      this.widget,
      required this.textAppBar,
      required this.elevationAppBar,
      required this.showenCenterText,
      required this.actionsAppBar, this.leadingAppBar})
      : super(key: key);

  final String textAppBar;
  final double elevationAppBar;
  final List<Widget> actionsAppBar;
  final bool showenCenterText;
  final Widget? leadingAppBar;

  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: ColorsApp.AppBarColor,
      title: Text(
        textAppBar,
        style: Styles.textStyle20,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: widget ?? Container(),
      ),
      elevation: elevationAppBar,
      shadowColor: Colors.deepOrangeAccent,
      centerTitle: showenCenterText,
      actions: actionsAppBar,
      leading: leadingAppBar,
    );
  }
}
