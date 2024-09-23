import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:flutter_to_do_app/providers/tasks_Provider.dart'; 
import 'package:flutter_to_do_app/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TasksProvider>(create: (_) => TasksProvider()),
        ChangeNotifierProvider<DarkModeProvider>(create: (_) => DarkModeProvider()),
      ],
    child: Consumer<DarkModeProvider>(
      builder: (context,darkModeProvider,_) {
        return MaterialApp(
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
    ),
  ));
}



