import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(const Locale('ar')));
  void toArabic() => emit(LocaleState(const Locale('ar')));
  void toEnglish() => emit(LocaleState(const Locale('en')));

  Future<void> initializeFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedLocale = prefs.getString('language') ?? 'ar';

    if (storedLocale == 'en') {
      toEnglish();
    } else if (storedLocale == 'ar') {
      toArabic();
    }
  }
}
