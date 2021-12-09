import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/main/main_state.dart';
import 'package:frazex/screens/explore.dart';
import 'package:frazex/screens/home.dart';
import 'package:frazex/screens/profile.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(PageState(0));

  List<Widget> pages = const [
    Home(),
    Explore(),
    Profile(),
  ];

  void changePages(selectedPage) {
    emit(PageState(selectedPage));
  }
}
