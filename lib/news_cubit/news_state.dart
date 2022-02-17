part of 'news_cubit.dart';

@immutable
abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBotNavState extends NewsState {}

class BusinessLoadingState extends NewsState {}

class BusinessSuccessState extends NewsState {}

class BusinessErrorState extends NewsState {}
