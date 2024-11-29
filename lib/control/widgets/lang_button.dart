import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        // Toggle between English and Arabic
        if (context.locale.languageCode == 'en') {
          context.setLocale(const Locale('ar'));
        } else {
          context.setLocale(const Locale('en'));
        }
      },
      child: Text(
        context.locale.languageCode == 'en' ? 'عربي' : 'English',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
