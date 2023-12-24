import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserDataInheritedWidget extends InheritedWidget {
  final UserData userData;

  const UserDataInheritedWidget({super.key,
    required this.userData,
    required super.child,
  });

  static UserDataInheritedWidget of(BuildContext context) {

      return context.dependOnInheritedWidgetOfExactType<UserDataInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(UserDataInheritedWidget oldWidget) {
    return  userData != oldWidget.userData;
  }
}
