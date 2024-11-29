import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hii/control/cubits/settings_cubit/settings_cubit.dart';
import 'package:hii/control/cubits/settings_cubit/settings_state.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              S.of(context).settings), // Using localized string for 'Settings'
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S
                    .of(context)
                    .toggleTheme, // Localized string for 'Toggle Theme'
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  bool isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

                  return Switch(
                    value: isDarkMode,
                    onChanged: (isDarkMode) {
                      MyApp.themeNotifier.value =
                          isDarkMode ? ThemeMode.dark : ThemeMode.light;
                      context.read<SettingsCubit>().toggleTheme(isDarkMode);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              LanguageToggleButton(), // Language toggle button
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).popAndPushNamed(
                    '/login', // Replace with your actual login route
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                    S.of(context).signOut), // Localized string for 'Sign Out'
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Get the current locale
        final currentLocale = Localizations.localeOf(context);
        // Determine the new locale
        final newLocale = currentLocale.languageCode == 'en' ? 'ar' : 'en';

        // Change the locale using MyApp's method to trigger the rebuild
        MyApp.changeLanguage(newLocale);
      },
      child: Text(
        Localizations.localeOf(context).languageCode == 'en'
            ? S
                .of(context)
                .switchToArabic // Localized string for 'Switch to Arabic'
            : S
                .of(context)
                .switchToEnglish, // Localized string for 'Switch to English'
      ),
    );
  }
}

/*class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).settings), // Using localized string for 'Settings'
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).toggleTheme, // Localized string for 'Toggle Theme'
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  bool isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;

                  return Switch(
                    value: isDarkMode,
                    onChanged: (isDarkMode) {
                      MyApp.themeNotifier.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
                      context.read<SettingsCubit>().toggleTheme(isDarkMode);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              LanguageToggleButton(), // Language toggle button
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Get the current locale
        final currentLocale = Localizations.localeOf(context);
        // Determine the new locale
        final newLocale = currentLocale.languageCode == 'en' ? 'ar' : 'en';

        // Change the locale using MyApp's method to trigger the rebuild
        MyApp.changeLanguage(newLocale);
      },
      child: Text(
        Localizations.localeOf(context).languageCode == 'en' 
          ? S.of(context).switchToArabic // Localized string for 'Switch to Arabic'
          : S.of(context).switchToEnglish, // Localized string for 'Switch to English'
      ),
    );
  }
}*/









