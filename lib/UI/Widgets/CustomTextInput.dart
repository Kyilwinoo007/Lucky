import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:lucky/Utils/styles.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CustomTextInput extends StatefulWidget {
  final String? errorMessage;
  final TextEditingController controller;
  final String label;
  final String hintText;
  final Function? onIconPressed;
  // final Function onLeadingIconPressed;
  final VoidCallback? onLeadingIconPressed;
  final Function? onChangeHandler;
  final Widget? trailingIcon;
  final Icon leadingIcon;
  final bool isRequired;
  final bool disable;
  final TextInputType inputType;
  final Function? validator;
  final Color lableColor;

  CustomTextInput({
    Key? key,
    this.errorMessage,
    this.isRequired = false,
    this.disable = false,
    this.validator,
    this.onChangeHandler,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
    required this.hintText,
    this.onIconPressed,
    this.trailingIcon,
     this.leadingIcon = const Icon(null),
     this.onLeadingIconPressed,
    this.lableColor = Colors.grey,
  }) : super(key: key);

  @override
  _MyCustomTextInputState createState() => _MyCustomTextInputState();
}

class _MyCustomTextInputState extends State<CustomTextInput> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
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
    return MyCustomInput(
      errorMessage: this.widget.errorMessage ?? "",
      label: this.widget.label,
      lableColor: this.widget.lableColor,
      isRequired: this.widget.isRequired,
      child: Container(
        child: ListTile(

          horizontalTitleGap: -5.0,
          leading: this.widget.leadingIcon,
          trailing: this.widget.trailingIcon,
          title: TextFormField(
            onChanged: (val) => this.widget.onChangeHandler != null
                ? this.widget.onChangeHandler!(val)
                : null,
            onSaved: (val) => this.widget.controller.text = val!.trim(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: widget.inputType,
            controller: widget.controller,
            enabled: !this.widget.disable,
            decoration: InputDecoration(
              // contentPadding: EdgeInsetsResponsive.all(
              //    2.0,
              // ),
              border:InputBorder.none,
              hintText: widget.hintText,
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 13.0,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 13.0,
              ),
            ),
          ),
        ),
      ),
      // child: TextFormField(
      //   onChanged: (val) => this.widget.onChangeHandler != null
      //       ? this.widget.onChangeHandler!(val)
      //       : null,
      //   onSaved: (val) => this.widget.controller.text = val!.trim(),
      //   style: TextStyle(
      //     fontSize: 15,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   keyboardType: widget.inputType,
      //   controller: widget.controller,
      //   enabled: !this.widget.disable,
      //   decoration: InputDecoration(
      //     isDense: true,
      //     contentPadding: EdgeInsetsResponsive.only(
      //       top: widget.leadingIcon == null && widget.trailingIcon == null
      //           ? 0.0
      //           : 20.0,
      //       left: 10.0,
      //     ),
      //     border: InputBorder.none,
      //     hintText: widget.hintText,
      //     //    labelText: widget.hintText,
      //     labelStyle: TextStyle(
      //       color: Colors.grey,
      //       fontSize: 13.0,
      //     ),
      //     hintStyle: TextStyle(
      //       color: Colors.grey,
      //       fontSize: 13.0,
      //     ),
      //     // Here is key idea
      //     prefixIcon: (widget.leadingIcon == null)
      //         ? null
      //         : Padding(
      //       padding: const EdgeInsets.all(0.0),
      //       child: IconButton(
      //         icon: widget.leadingIcon,
      //         iconSize: 22.0,
      //         onPressed: widget.onLeadingIconPressed,
      //       ),
      //     ),
      //     suffixIcon: this.widget.disable && (widget.trailingIcon == null)
      //         ? ((this.widget.errorMessage ?? "").length > 0)
      //         ? Icon(
      //       LineAwesomeIcons.times_circle,
      //       size: 20.0,
      //       color: Colors.red,
      //     )
      //         : (this.widget.controller.text.length > 0)
      //         ? Icon(
      //       Icons.check_circle,
      //       size: 20.0,
      //       color: Colors.green,
      //     )
      //         : null
      //         : this.widget.trailingIcon,
      //   ),
      // ),
    );
  }
}
class MyCustomInput extends StatefulWidget {
  final String label;
  final bool isRequired;
  final String errorMessage;
  final Widget child;
  final Color lableColor;

  const MyCustomInput({
    Key? key,
    required this.isRequired,
    required this.errorMessage,
    required this.label,
    required this.child,
    this.lableColor = Colors.grey,
  }) : super(key: key);

  @override
  MyCustomInputState createState() => MyCustomInputState();
}

class MyCustomInputState extends State<MyCustomInput> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null)
          Row(
            children: <Widget>[
              TextResponsive(
                widget.label,
                style: TextStyle(
                  color: this.widget.lableColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),

              ),
              if (this.widget.isRequired)
                Padding(
                  padding: EdgeInsetsResponsive.only(left: 8.0),
                  child: TextResponsive(
                    "*",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              if ((this.widget.errorMessage).length > 0)
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsResponsive.only(left: 8.0),
                    child: TextResponsive(
                      this.widget.errorMessage,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        if (widget.label.isNotEmpty)
          SizedBoxResponsive(
            height: 5.0,
          ),
        Card(
          elevation: 5,
          child: Container(
            height: 60.0,
            child: this.widget.child,
          ),
        ),
      ],
    );
  }
}

class CustomPasswordInput extends StatefulWidget {
  final TextEditingController userPasswordController;
  final String label;
  final String? hintText;
  final String errorMessage;
  final Color labelColor;

  CustomPasswordInput({
    Key? key,
    required this.userPasswordController,
    required this.label,
    this.hintText,
    this.labelColor = Colors.grey,
    required this.errorMessage,
  }) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool isPasswordInvisible = true;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
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
    return MyCustomInput(
      errorMessage: this.widget.errorMessage,
      label: this.widget.label,
      lableColor: this.widget.labelColor,
      isRequired: true,
      child: Container(
        child: ListTile(
          horizontalTitleGap: -6.0,
          leading: Icon(
            // Based on passwordVisible state choose the icon
            LineAwesomeIcons.lock,
            size: 25.0,
            color: LuckyColors.splashScreenColors,
          ),
          trailing: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              this.isPasswordInvisible
                  ? LineAwesomeIcons.eye_slash
                  : LineAwesomeIcons.eye,
              size: 25.0,
              color: LuckyColors.splashScreenColors,
            ),
            onPressed: () {
              setState(() {
                this.isPasswordInvisible = !this.isPasswordInvisible;
              });
            },
          ),
          title: TextFormField(
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
            keyboardType: TextInputType.text,
            controller: widget.userPasswordController,
            obscureText: this.isPasswordInvisible,
            //This will obscure text dynamically
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText ?? '',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 13.0,
              ),
            ),
          ),
        )
        // child: TextFormField(
        //   style: TextStyle(
        //     fontSize: 15.0,
        //     fontWeight: FontWeight.bold,
        //   ),
        //   keyboardType: TextInputType.text,
        //   controller: widget.userPasswordController,
        //   obscureText: this.isPasswordInvisible,
        //   //This will obscure text dynamically
        //   decoration: InputDecoration(
        //     contentPadding: EdgeInsetsResponsive.only(
        //       top: 20.0,
        //       left: 10.0,
        //     ),
        //     border: InputBorder.none,
        //     hintText: widget.hintText ?? '',
        //     hintStyle: TextStyle(
        //       color: Colors.grey,
        //       fontSize: 13.0,
        //     ),
        //     // Here is key idea
        //     prefixIcon: Icon(
        //       // Based on passwordVisible state choose the icon
        //       LineAwesomeIcons.lock,
        //       size: 20.0,
        //       color: Colors.grey,
        //     ),
        //     suffixIcon: IconButton(
        //       icon: Icon(
        //         // Based on passwordVisible state choose the icon
        //         this.isPasswordInvisible
        //             ? LineAwesomeIcons.eye_slash
        //             : LineAwesomeIcons.eye,
        //         size: 20.0,
        //         color: Colors.grey,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           this.isPasswordInvisible = !this.isPasswordInvisible;
        //         });
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
