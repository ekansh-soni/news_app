import 'package:flutter/material.dart';
import 'package:news/ui/details_screen.dart';

dynamic sendRoute(BuildContext context, RoutesName routeName,{bool isreplace = false,
bool clearstack = false,
Function? onrefresh,
Map<String, dynamic>? data}){
  switch(routeName){
    case RoutesName.detailsScreen:
      sendActivity(context, const DetailsScreen());
      break;

    default:
      Text("No Page Found");

  }
}

enum RoutesName{
  splash,
  homeScreen,
  detailsScreen
}


sendActivity(BuildContext context, Widget funcs,
    {bool isreplace = false, Function? onrefresh, bool clearstack = false}) {
  if (clearstack) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => funcs),
            (route) => false);
  } else if (isreplace) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => funcs),
    ).then((value) => {
      if (onrefresh != null) {onrefresh()}
    });
  } else {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => funcs),
    ).then((value) => {
      if (onrefresh != null) {onrefresh()}
    });
  }
}