import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {}

class PageState extends MainState {
  final int page;

  PageState(this.page);
  @override
  List<Object?> get props => [page];
}
