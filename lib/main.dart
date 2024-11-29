/*import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/auth/mainpage.dart';
import 'package:hii/control/firebase_Services/firebase_Api_messaging.dart';
import 'package:hii/control/firebase_Services/firebase_options.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/StoriesPage%20.dart';
import 'package:hii/views/screens/UploadStoryPage%20.dart';
import 'package:hii/views/screens/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  // ignore: unused_field
  static Locale _locale = const Locale('en');

  const MyApp({super.key});

  static void changeLanguage(String languageCode) {
    _locale = Locale(languageCode); // Update the locale
    // Notify the app to rebuild with the new locale
    // You might need to use a method to trigger a rebuild, such as using a ValueNotifier or a similar approach.
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentTheme, child) {
          return MaterialApp(localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            
          
            title: 'Light and Dark Mode',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: currentTheme,
            debugShowCheckedModeBanner: false,
            home: const ScreenUtilInit(
              designSize: Size(360, 740),
              child: MainPage(),
            ),
            routes: {
              '/notification_screen': (context) => const NotificationPage(),
              '/upload_story': (context) => UploadStoryPage(),
              '/stories': (context) => StoriesPage(),
            },
            navigatorKey: navigatorKey,
          );
        });
  }
}*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hii/control/auth/mainpage.dart';
import 'package:hii/control/firebase_Services/firebase_Api_messaging.dart';
import 'package:hii/control/firebase_Services/firebase_options.dart';
import 'package:hii/generated/l10n.dart';
import 'package:hii/views/screens/StoriesPage%20.dart';

import 'package:hii/views/screens/UploadStoryPage%20.dart';

import 'package:hii/views/screens/notification_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotification();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // ValueNotifier to manage theme and locale changes
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  
  // Using a ValueNotifier for Locale changes
  static final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  const MyApp({super.key});

  // Method to change language
  static void changeLanguage(String languageCode) {
    localeNotifier.value = Locale(languageCode); // Update the locale
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier, // Rebuild when locale changes
      builder: (context, currentLocale, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier, // Rebuild when theme changes
          builder: (context, currentTheme, child) {
            return MaterialApp(
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: currentLocale, // Set the current locale
              title: 'Light and Dark Mode',
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: currentTheme,
              debugShowCheckedModeBanner: false,
              home: const ScreenUtilInit(
                designSize: Size(360, 740),
                child: MainPage(),
              ),
              routes: {
                '/notification_screen': (context) => const NotificationPage(),
                '/upload_story': (context) => UploadStoryPage(),
                '/stories': (context) => StoriesPage(),
              },
              navigatorKey: navigatorKey,
            );
          },
        );
      },
    );
  }
}

