import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LanguageState extends Equatable {}

class LoadedState extends LanguageState {
  final Locale locale;

  LoadedState(this.locale);
  @override
  List<Object?> get props => [locale];
}
