import 'package:flutter/material.dart';

import 'app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptionsProd.currentPlatform,

  // );

  // await Supabase.initialize(
  //   url: AppConsts.instance.supabaseUrl,
  //   anonKey: AppConsts.instance.anonKey,
  //   authOptions: const FlutterAuthClientOptions(),
  // );
  runApp(const AppWidget());
}
