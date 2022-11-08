import 'package:flutter/material.dart';

import 'colours.dart';

class TextStyles {
  static TextStyle bigTitle = TextStyle(
      color: Colours.textColor90,
      fontWeight: FontWeight.w400,
      fontSize: 22,
      decoration: TextDecoration.none);

  static TextStyle bigBoldTitle = TextStyle(
      color: Colours.textColor90,
      fontWeight: FontWeight.w600,
      fontSize: 26,
      decoration: TextDecoration.none);

  static TextStyle title = TextStyle(
    color: Colours.textColor90,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle listTitle = TextStyle(
    color: Colours.textColor90,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle subTitle = TextStyle(
    color: Colours.textColor60,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static TextStyle listSubTitle = TextStyle(
    color: Colours.textColor60,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textBlackS18 =
      TextStyle(color: Colours.textColor90, fontSize: 18);

  static TextStyle textBlackS12W200 =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w200);

  static TextStyle textThemeS15W400 = TextStyle(
      color: Colours.themeColor, fontSize: 15, fontWeight: FontWeight.w400);

  static TextStyle textb30S15W400 = TextStyle(
      color: Colours.textColor30, fontSize: 15, fontWeight: FontWeight.w400);
}

class ButtonStyles {
  static ButtonStyle nonePadding =
      ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(0)));
}
