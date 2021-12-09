import 'package:equatable/equatable.dart';
import 'package:frazex/models/image_model.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends HomeState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends HomeState {
  final List<ImageModel> images;

  SuccessState(this.images);

  @override
  List<ImageModel> get props => [...images];
}

class NoTextState extends HomeState {
  @override
  List<Object?> get props => [];
}
