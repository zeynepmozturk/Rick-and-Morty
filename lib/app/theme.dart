import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();//private hale geldi. Başka nesne oluşturmasına izin verilmiyor bu isimde.
  static ThemeData get lightTheme => ThemeData(
    fontFamily: 'Inter',
    scaffoldBackgroundColor: Colors.white,//arka plan rengi
    colorScheme:const ColorScheme.light(
      primary: Color(0xFF42B4CA),//BU RENKLERİ FİGMADAN ALDIK 
      secondary: Color(0xFFD5E9ED),
      surface: Colors.white,//arka plan rengi
      onSurface: Color(0xFF414A4C),//beyaz üzerine yazıların görüneceği renk 
      error: Color(0xFFEA7979),//HATA RENGİMİZ
      tertiary: Color(0XFFB5C4C7),//ÜÇÜNCÜL RENK
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
           foregroundColor:const Color(0xFF42B4CA),
      )
    ),
  );//Karanlık tema için kullanacaz
}

