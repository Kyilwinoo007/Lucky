import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

AppBar luckyAppbar({
  required String title,
  List<Widget>? actions,
  PreferredSizeWidget? bottomWidget,
  Widget? leading,
  required BuildContext context,
}) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    ResponsiveWidgets.init(
      context,
      height: 800,
      width: 480,
      allowFontScaling: true,
    );
  } else {
    ResponsiveWidgets.init(
      context,
      width: 800,
      height: 480,
      allowFontScaling: true,
    );
  }
  if (leading == null) {
    leading = InkWell(
      onTap: () {
        // FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back,
        size: 25.0,
        color: Colors.white,
      ),
    );
  }

  return AppBar(
    title: Text(
      title.isEmpty ? " " : title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    ),
    leading: leading,
    centerTitle: true,
    actions: actions,
    bottom: bottomWidget,
  );
}
