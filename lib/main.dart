import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supa_chat/view/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print("MIRAAA ${Config.supabaseUrl}");
    await Supabase.initialize(
      url: Config.supabaseUrl,
      anonKey: Config.supabaseAnonKey,
    );
  } else {
    await dotenv.load(fileName: ".env");
    await Supabase.initialize(
      url: dotenv.env['URL'] ?? '',
      anonKey: dotenv.env['SUPA_KEY'] ?? '',
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUPACHAT',
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}
