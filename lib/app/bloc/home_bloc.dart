import 'dart:async';

import '../repo/market_repo.dart';
import 'package:bloc/bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) async {
      if (event is FetchCryptoList) {
        try {
          final _marketData = await MarketAPI().getCryptoPrices();
          // print('\nl\no\na\nd');
          // print(_marketData.data[0]);
          emit(state.copyWith(marketData: _marketData.data, isLoading: false));
        } catch (e) {
          print(e);
        }
      }
      if (event is PeriodicCheck) {
        add(FetchCryptoList());
        Stream.periodic(const Duration(seconds: 5), (t) => t).listen(
            (_) => add(FetchCryptoList()),
            onError: (error) => print("Do something with $error"));
      }
    });
  }
}
