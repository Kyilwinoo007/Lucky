import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucky/Utils/Colors.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class Utils{
   static String getCurrentDate(){
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

   static dismissDialog(BuildContext context){
     Navigator.of(context, rootNavigator: true).pop();
   }
   static successDialog(BuildContext context,String title,String content){
     return showDialog(context: context,
         barrierDismissible: false,
         useSafeArea: false,
         builder: (BuildContext context){
           return Dialog(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16),
             ),
             elevation: 0.0,
             backgroundColor: Colors.transparent,
             child: Stack(
               children: <Widget>[
                 Container(
                   padding: EdgeInsets.only(
                     top: 46,
                     bottom: 16,
                     left: 16,
                     right:16,
                   ),
                   margin: EdgeInsets.only(top: 30),
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.rectangle,
                     borderRadius: BorderRadius.circular(16),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black26,
                         blurRadius: 10.0,
                         offset: const Offset(0.0, 10.0),
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min, // To make the card compact
                     children: <Widget>[
                       Text(
                         title,
                         style: TextStyle(
                           fontSize: 18.0,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                       SizedBox(height: 14.0),
                       Text(
                         content,
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           fontSize: 16.0,
                         ),
                       ),
                       SizedBox(height: 24.0),
                       Align(
                         alignment: Alignment.bottomRight,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[
                             FlatButton(
                               onPressed: () {
                                 Navigator.of(context).pop();
                               },
                               child: Text("OK"),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   left: 16,
                   right: 16,
                   child: CircleAvatar(
                     radius: 30,
                     backgroundColor: Colors.green,
                     child: Icon(Icons.check,color: Colors.white),
                   ),
                 ),
               ],
             ),
           );
         });
   }

   static showLoaderDialog(BuildContext context){
     AlertDialog alert=AlertDialog(
       shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.all(Radius.circular(20.0))
       ),
       content: new Row(
         children: [
           CircularProgressIndicator(),
           SizedBox(width: 4,),
           Container(margin: EdgeInsets.only(left: 7),child:Text("Loading ...")),
         ],),
     );
     showDialog(barrierDismissible: false,
       context:context,
       builder:(BuildContext context){
         return alert;
       },
     );
   }
   static errorDialog(BuildContext context, String message, {String title = "Sorry!"}) {
     return showDialog(
         context: context,
         barrierDismissible: false,
         useSafeArea: false,
         builder: (BuildContext context){
           return Dialog(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8),
             ),
             elevation: 0.0,
             backgroundColor: Colors.transparent,
             child: Stack(
               children: <Widget>[
                 Container(
                   padding: EdgeInsets.only(
                     top: 24,
                     bottom: 8,
                     left: 8,
                     right:8,
                   ),
                   margin: EdgeInsets.only(top: 30),
                   decoration: new BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.rectangle,
                     borderRadius: BorderRadius.circular(8),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black26,
                         blurRadius: 10.0,
                         offset: const Offset(0.0, 10.0),
                       ),
                     ],
                   ),
                   child: Column(
                     mainAxisSize: MainAxisSize.min, // To make the card compact
                     children: <Widget>[
                       Text(
                         title,
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: 20.0,
                         ),
                       ),
                       SizedBox(height: 24.0),
                       Text(
                         message,
                         textAlign: TextAlign.center,
                         style: TextStyle(
                           fontSize: 16.0,
                         ),
                       ),
                       SizedBox(height: 16.0),
                       Align(
                         alignment: Alignment.bottomRight,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: <Widget>[
                             FlatButton(
                               onPressed: () {
                                 Navigator.of(context).pop();
                               },
                               child: Text("OK"),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 Positioned(
                   top: 5,
                   left: 16,
                   right: 16,
                   child: CircleAvatar(
                     radius: 20,
                     backgroundColor: Colors.red,
                     child: Icon(Icons.clear,color: Colors.white,),
                     // child: Text('i',style: TextStyle(color: Colors.white,fontSize: 40),),
                   ),
                 ),
               ],
             ),
           );
         });
   }
  static buildLoading() {
     return Center(
       child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(LuckyColors.splashScreenColors),),
     );
   }

 static  buildEmptyView({
     required IconData icon,
     required String title,
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
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Icon(
             icon,
             size: 80.0,
             color: LuckyColors.splashScreenColors,
           ),
           SizedBoxResponsive(height: 20.0,),
           Text(
             title,
             style: TextStyle(
               fontSize: 18.0,
               color: LuckyColors.splashScreenColors,
               fontWeight: FontWeight.bold,
             ),
           ),
         ],
       ),
     );
   }



}