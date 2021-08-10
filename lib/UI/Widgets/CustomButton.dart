import 'package:flutter/material.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class OutlineGreenButton extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback clickHandler;
  final String title;

  const OutlineGreenButton({
    Key? key,
    required this.title,
    required this.clickHandler,
     this.leadingIcon,
     this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return InkWell(
      onTap: clickHandler,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: 14.0,
          bottom: 14.0,
          left: 18.0,
          right: 18.0,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Row(
          mainAxisAlignment:
          this.leadingIcon == null && this.trailingIcon == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (this.leadingIcon != null)
              Icon(
                this.leadingIcon,
                color: Theme.of(context).accentColor,
                size: 20.0,
              ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              ),
            ),
            if (this.leadingIcon != null)
              Icon(
                this.trailingIcon,
                size: 20.0,
                color: Theme.of(context).accentColor,
              )
          ],
        ),
      ),
    );
  }
}

class SolidBlackButton extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback clickHandler;
  final String title;

  const SolidBlackButton(
      {Key? key,
         this.leadingIcon,
         this.trailingIcon,
        required this.clickHandler,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return InkWell(
      onTap: clickHandler,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
          left: 18.0,
          right: 18,
        ),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment:
          this.leadingIcon == null && this.trailingIcon == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              this.leadingIcon,
              color: Colors.white,
              size: 20.0,
            ),
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              ),
            ),
            Icon(
              this.trailingIcon,
              size: 20.0,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class SolidGreenButton extends StatelessWidget {
  final VoidCallback clickHandler;
  final String title;

  const SolidGreenButton(
      {Key? key,
        required this.clickHandler,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return  ElevatedButton(
      onPressed: clickHandler,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        elevation: 5.0,
        padding: EdgeInsets.only(top: 16,bottom: 16,left: 18,right: 18),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 17.0,
        ),
      ),
    );
  }
}
class OutlineGreenElevatedButton extends StatelessWidget {
  final VoidCallback clickHandler;
  final String title;

  const OutlineGreenElevatedButton(
      {Key? key,
        required this.clickHandler,
        required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return  ElevatedButton(
      onPressed: clickHandler,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        side: BorderSide(width:2, color:Theme.of(context).primaryColor), //border width and color
        elevation: 5.0,
        shadowColor: Colors.green,
        padding: EdgeInsets.only(top: 16,bottom: 16,left: 18,right: 18),
      ),
      child: Text(
        title,
        style: TextStyle(
        color: LuckyColors.splashScreenColors,
        fontWeight: FontWeight.w600,
        fontSize: 17.0,
      ),
      ),
    );
  }
}
