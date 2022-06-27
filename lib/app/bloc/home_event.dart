part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class FetchCryptoList extends HomeEvent {}

class PeriodicCheck extends HomeEvent {}
