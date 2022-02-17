part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBotNavState extends NewsState {}

class BusinessLoadingState extends NewsState {}

class BusinessSuccessState extends NewsState {}

class BusinessErrorState extends NewsState {}

class SportsLoadingState extends NewsState {}

class SportsSuccessState extends NewsState {}

class SportsErrorState extends NewsState {}

class ScienceLoadingState extends NewsState {}

class ScienceSuccessState extends NewsState {}

class ScienceErrorState extends NewsState {}
