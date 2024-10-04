import 'package:flutter/material.dart';

import 'design.dart';

enum ButtonType {
  validButton,
  cancelButton,
  selectedButton,
}

class CustomButtonStyle {
  CustomButtonStyle._();

  static final WidgetStateProperty<Color> backgroundColorStatesSelectedButton =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colours.shadowHideMenu;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colours.colorsButtonMenu;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colours.colorsButtonMenu;
      }
      return Colours.primaryPalette;
    },
  );

  static final WidgetStateProperty<Color> backgroundColorStatesValidButton =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colours.shadowHideMenu;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colours.primaryPalette;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colours.primaryPalette;
      }
      return Colours.colorsButtonMenu;
    },
  );

  static final WidgetStateProperty<Color> foregroundColorStatesValidButton =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colours.shadowHideMenu;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colours.colorsButtonMenu;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colours.colorsButtonMenu;
      }
      return Colours.white;
    },
  );

  static final WidgetStateProperty<Color> foregroundColorStateSelectedButton =
      WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) {
        return Colours.shadowHideMenu;
      }
      if (states.contains(WidgetState.pressed)) {
        return Colours.white;
      }
      if (states.contains(WidgetState.hovered)) {
        return Colours.white;
      }
      return Colours.colorsButtonMenu;
    },
  );

  static const EdgeInsetsGeometry paddingIconSmall =
      EdgeInsets.symmetric(horizontal: 10, vertical: 10);
  static const borderColor = Colours.colorsButtonMenu;

  static ButtonStyle customButtonStyle({
    required ButtonType type,
    required bool isSelected,
  }) {
    WidgetStateProperty<Color>? backgroundColor;
    WidgetStateProperty<Color>? foregroundColor;
    switch (type) {
      case ButtonType.validButton:
        backgroundColor = backgroundColorStatesValidButton;
        foregroundColor = foregroundColorStatesValidButton;
        break;
      case ButtonType.cancelButton:
        backgroundColor = backgroundColorStatesSelectedButton;
        foregroundColor = foregroundColorStateSelectedButton;
        break;
      case ButtonType.selectedButton:
        backgroundColor = WidgetStateProperty.all(
            isSelected ? Colours.colorsButtonMenu : Colours.primaryPalette);
        foregroundColor = WidgetStateProperty.all(
            isSelected ? Colours.white : Colours.colorsButtonMenu);
        break;
    }
    return ButtonStyle(
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(paddingIconSmall),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Units.radiusXXLarge),
          side: const BorderSide(color: borderColor),
        ),
      ),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
