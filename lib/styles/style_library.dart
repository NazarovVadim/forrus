import 'package:flutter/material.dart';

class StyleLibrary{
  static final padding = StylePadding();
  static final font = StyleFonts();
  static final color = StyleColor();


}


class StyleFonts{

  final header = TextStyle(
    fontSize: 28,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  final body = TextStyle(
    fontSize: 20,
    color: Colors.black
  );
  final body2 = TextStyle(
    fontSize: 16,
    color: Colors.black
  );

  final small = TextStyle(
    fontSize: 8,
    color: Colors.black,
  );

}

class StyleColor{
  final Color primary = const Color.fromARGB(255, 244, 198, 6);
}

class StylePadding{

  static double height = 20;
  static double weight = 15;

  final allContentPadding = EdgeInsets.symmetric(
      vertical: height,
      horizontal: weight
  );
  final onlyHorizontalPadding = EdgeInsets.symmetric(
    horizontal: weight
  );
  final onlyVerticalPadding = EdgeInsets.symmetric(
      vertical: height
  );

  final fieldPadding = const EdgeInsets.symmetric(horizontal: 5, vertical: 8);

  final contentDivider = SizedBox(height: height);

}