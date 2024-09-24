import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:flutter_to_do_app/providers/language_provider.dart';
import 'package:flutter_to_do_app/providers/tasks_Provider.dart'; 
import 'package:flutter_to_do_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(create: (_) => TasksProvider()),
        ChangeNotifierProvider<DarkModeProvider>(create: (_) => DarkModeProvider()),
        ChangeNotifierProvider<languageProvider>(create: (_) => languageProvider()),

      ],
    child: Consumer<DarkModeProvider>(
      builder: (context,darkModeProvider,_) {
        return Consumer<languageProvider>(
          builder: (context, language,_) {
            language.get();
            darkModeProvider.getMode();
            return MaterialApp(
              locale: Locale(language.language??"es"),
              localizationsDelegates: const  [
                AppLocalizations.delegate, 
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('es'), // Spanish
                Locale('ar'), // arabic
              ],
              theme:ThemeData(
                dividerTheme: DividerThemeData(
                  color: darkModeProvider.isDark ? Colors.white24 : Colors.black26,
                ),
                tabBarTheme: TabBarTheme(
                    labelColor:
                        darkModeProvider.isDark ? Colors.white : Colors.red),
                appBarTheme: const AppBarTheme(
                    centerTitle: true, backgroundColor: Colors.red),
                drawerTheme: DrawerThemeData(
                    backgroundColor:
                        darkModeProvider.isDark ? Colors.black : Colors.white,
                        ),
                    
                scaffoldBackgroundColor:
                    darkModeProvider.isDark ? Colors.black : Colors.white,
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                useMaterial3: false,
              ),
              home: HomeScreen());
          }
        );
      }
    ),
  ));
}



