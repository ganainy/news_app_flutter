import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/network/dio_helper.dart';
import 'package:news_app_flutter/shared/my_bloc_observer.dart';

import 'layout/news_layout.dart';
import 'news_cubit/news_cubit.dart';

void main() {
  //initialize dio instance to use it later for api calls
  DioHelper.init();

  //start the logger class for the cubit states
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusinessNews()
        ..getAppTheme(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          print('Newscubit current state: ${state.toString()}');
        },
        builder: (context, state) {
          var newsCubit = NewsCubit.get(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: newsCubit.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData(
              textTheme: const TextTheme(
                  headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24),
                  headline5: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18)),
              primarySwatch: Colors.deepOrange,
              //because body color is originally offwhite so there is slight difference  between  appbar and body
              scaffoldBackgroundColor: const Color(0xff0D1E37),
              appBarTheme: const AppBarTheme(
                //change  color of any icon in appbar
                iconTheme: IconThemeData(color: Colors.white),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color(0xff0D1E37),
                ),
                backgroundColor: Color(0xff0D1E37),
                //text style in appbar
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                backgroundColor: Color(0xff0D1E37),
                unselectedItemColor: Colors.white,
              ),
            ),
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textTheme: const TextTheme(
                  headline6: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 24),
                  headline5: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
              //because body color is originally offwhite so there is slight difference  between  appbar and body
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                //change  color of any icon in appbar
                iconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
                backgroundColor: Colors.white,
                //text style in appbar
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

                elevation: 0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
              ),
            ),
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
