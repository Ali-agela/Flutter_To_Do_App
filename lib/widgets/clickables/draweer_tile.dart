import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/providers/dark_mode_provider.dart';
import 'package:provider/provider.dart';

class DraweerTile extends StatelessWidget {
  const DraweerTile({super.key , required this.icon,required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(
      builder: (context, darkModeProvider,_) {
        return  
        Container(
          decoration: BoxDecoration(
            color: darkModeProvider.isDark ? Colors.black : Colors.white
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon,
                  color :darkModeProvider.isDark ? Colors.white : Colors.black),
                  Text(text,style: TextStyle(
                    color: darkModeProvider.isDark
                          ? Colors.white
                          : Colors.black
                  ),),
                  Switch(value: darkModeProvider.isDark, onChanged:(check){
                      darkModeProvider.switchMode();
                  })
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}