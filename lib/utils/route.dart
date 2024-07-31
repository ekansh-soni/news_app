import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/news_bloc.dart';
import 'package:news/ui/details_screen.dart';
import 'package:news/ui/splash_screen.dart';

import '../ui/home_screen.dart';

dynamic sendRoute(BuildContext context, RoutesName routeName){
  switch(routeName){
    case RoutesName.splash:
      const SplashScreen();
      break;
    case RoutesName.homeScreen:
      sendActivity(context, MultiBlocProvider(
          providers: [
            BlocProvider<NewsModelBloc>(create: (context) => NewsModelBloc(repository: NewsModelRepositoryImpl()),)
          ],
          child: const HomeScreen()));
      break;

    case RoutesName.detailsScreen:
      sendActivity(context, const DetailsScreen());
      break;

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