import 'dart:async';

import 'package:driver/features/auth/injection/auth_injection.dart';
import 'package:driver/features/invoice/injection/invoice_injection.dart';
import 'package:get_it/get_it.dart';

import 'features/app/injections/injection_network.dart';
import 'features/app/injections/injection_services.dart';
import 'features/history/injections/history_injection.dart';
import 'features/profile/injection/profile_injection.dart';
import 'features/support/injection/support_injection.dart';

final si = GetIt.instance;

class Injections {
  static Future<void> init() async {
    NetworkInjection.dependencies();
    await InjectionServices.dependencies();
    AuthInjection.dependencies();
    ProfileInjection.dependencies();
    HistoryInjection.dependencies();
    SupportInjection.dependencies();
    InvoiceInjection.dependencies();
  }
}
