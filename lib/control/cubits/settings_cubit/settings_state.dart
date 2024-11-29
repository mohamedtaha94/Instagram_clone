import 'package:flutter/material.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsThemeChanged extends SettingsState {
  final ThemeMode themeMode;

  SettingsThemeChanged(this.themeMode);
}