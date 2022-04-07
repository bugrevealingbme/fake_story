import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefSelectedLanguageCode = "SelectedLanguageCode";
const String prefSelectedCountryCode = "SelectedCountryCode";

setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("Preference Updated $languageCode");
  prefs.setString(prefSelectedLanguageCode, languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode =
      _prefs.getString(prefSelectedLanguageCode) ?? Platform.localeName;

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode)
      : const Locale('en_US');
}
