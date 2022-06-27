part of 'home_bloc.dart';

class HomeState {
  final marketData;
  final bool isloading;
  HomeState({this.marketData, this.isloading = true});
  HomeState copyWith({List? marketData, bool? isLoading}) {
    return HomeState(
        marketData: marketData ?? this.marketData,
        isloading: isLoading ?? this.isloading);
  }
}
