import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'Screens/DashBoard/PatientPaymentScreen/patientDataProvider/patientDataProvider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GlobalProviderAccess {

  // static SignInProvider? get signPro {
  //   final context = navigatorKey.currentContext;
  //   if (context != null) {
  //     return Provider.of<SignInProvider>(context, listen: false);
  //   }
  //   return null;
  // }
  static PatientDataProvider? get profilePro {

    final context = navigatorKey.currentContext;
    if (context != null) {
      return Provider.of<PatientDataProvider>(context, listen: false);
    }
    return null;
  }

}