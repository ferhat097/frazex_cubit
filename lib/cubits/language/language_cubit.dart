import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/language/language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LoadedState(Locale("az")));

  void changeLanguage(localeCode) {
    Locale locale = Locale(localeCode);
    emit(LoadedState(locale));
  }
}
