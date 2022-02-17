import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app_flutter/modules/business.dart';
import 'package:news_app_flutter/modules/science.dart';
import 'package:news_app_flutter/modules/sports.dart';
import 'package:news_app_flutter/network/dio_helper.dart';
import 'package:news_app_flutter/shared/constants.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int botNavCurrentIndex = 0;

  List<BottomNavigationBarItem> botNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> botNavScreens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];

  changeBotNavIndex(int index) {
    botNavCurrentIndex = index;
    emit(NewsBotNavState());
  }

  var businessNews;

  void getBusinessNews() {
    emit(BusinessLoadingState());
    businessNews = DioHelper.getData(queryParams: {
      'country': 'us',
      'category': 'business',
      'apiKey': Constants.API_KEY,
    }).then((value) {
      print(value.data.toString());
      businessNews = value.data;
      emit(BusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(BusinessErrorState());
    });
  }
}
