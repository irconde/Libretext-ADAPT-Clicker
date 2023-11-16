import 'package:adapt_clicker/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colors.dart';
import 'dimens.dart';


class IIcons
{

  ///Global
  //Password Left Icons
  static const Icon password =  Icon(
    Icons.lock_outline,
  );

  static const Icon close = Icon(
    Icons.close,
    color: CColors.tertiaryColor,
  );

  //Visible Icons Creator
  static Semantics toggleVisIcon({required bool visible,required void Function() onTap}) {
    return Semantics(
      label: visible
          ? Strings
          .passwordToggleShowingSemanticsLabel
          : Strings
          .passwordToggleNotShowingSemanticsLabel,
      child: InkWell(
        onTap: () => onTap(),
        focusNode: FocusNode(skipTraversal: true),
        child: Icon(
         visible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: Dimens.tfIconSize,
        ),
      ),
    );
  }

  ///AppBar
  //Menu
  static const Icon menu = Icon(Icons.menu);
  static const Icon notification = Icon(
    Icons.notifications,
  );

  ///Drawer Icons
  //Courses
  static Icon drawerCourse({required bool selected})
  {
    return Icon(
      Icons.menu_book,
      color: selected
          ? CColors.primaryColor
          : CColors.secondaryColor,
      size: Dimens.drawerIconSize,
    );
  }
  //Profile
  static Icon drawerProfile({required bool selected})
  {
    return Icon(
      Icons.person_sharp,
      color: selected
          ? CColors.primaryColor
          : CColors.secondaryColor,
      size: Dimens.drawerIconSize,
    );
  }

  //Password
  static Icon drawerPassword({required bool selected})
  {
    return Icon(
      Icons.lock_rounded,
      color: selected
          ? CColors.primaryColor
          : CColors.secondaryColor,
      size: Dimens.drawerIconSize,
    );
  }

  //Contact Us
  static Icon drawerContact({required bool selected})
  {
    return Icon(
      Icons.send_sharp,
      color: selected
          ? CColors.primaryColor
          : CColors.secondaryColor,
      size: Dimens.drawerIconSize,
    );
  }
  ///Course List
  //Floating Action Button
  static const Icon floating = Icon(
    Icons.add,
    color: CColors.primaryBackground,
    size: Dimens.floatingActionButtonIconSize,
  );

  ///Update Profile and Create Account
  //First and Last Name
  static const Icon profileName = Icon(
    Icons.person_outline,
  );

  //Student ID
  static const Icon studentID = Icon(
    Icons.school_outlined,
  );

  //Email
  static const Icon email = Icon(
    Icons.email_outlined,
  );

  ///Notification
  //Back Button
  static const Icon back = Icon(
    Icons.arrow_back,
  );

  ///Assignment Grid
  static const Icon completedAssignmentCheck = Icon(
    Icons.check_circle_outline,
    color: CColors.success,
    size: Dimens.smallIconSize,
  );

  ///Assignment Screen
  static Icon info(bool visible) {
    return Icon(
      visible
          ? Icons.info
          : Icons.info_outline,
      color: CColors.primaryColor,
    );
  }

  static const Icon dateRange = Icon(
    Icons.date_range,
    color: CColors.primaryBackground,
  );

  ///Assignment Stat Container

  static const FaIcon statIcon = FaIcon(
    FontAwesomeIcons.brain,
    color: CColors.primaryColor,
    size: 16,
  );

}