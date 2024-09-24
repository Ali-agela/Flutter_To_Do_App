import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:flutter_to_do_app/providers/language_provider.dart';
import 'package:provider/provider.dart';

class DraweerTile extends StatelessWidget {
  const DraweerTile({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<languageProvider>(builder: (context, language, _) {
      return Consumer<DarkModeProvider>(
          builder: (context, darkModeProvider, _) {
        return Container(
          decoration: BoxDecoration(
              color: darkModeProvider.isDark ? Colors.black : Colors.white),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon,
                      color: darkModeProvider.isDark
                          ? Colors.white
                          : Colors.black),
                  Text(
                    text,
                    style: TextStyle(
                        color: darkModeProvider.isDark
                            ? Colors.white
                            : Colors.black),
                  ),
                  Switch(
                      value: darkModeProvider.isDark,
                      onChanged: (check) {
                        darkModeProvider.switchMode();
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: GestureDetector(
                  onTap: () {
                    language.store("ar");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        "Arabic",
                        style: TextStyle(
                            color: darkModeProvider.isDark
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: GestureDetector(
                  onTap: () {
                    language.store("es");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "spanish",
                        style: TextStyle(
                            color: darkModeProvider.isDark
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: GestureDetector(
                  onTap: () {
                    language.store("en");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "English",
                        style: TextStyle(
                            color: darkModeProvider.isDark
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
    });
  }
}
