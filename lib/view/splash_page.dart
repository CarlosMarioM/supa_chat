import 'package:flutter/material.dart';
import 'package:supa_chat/constants.dart';
import 'package:supa_chat/view/home_page.dart';
import 'register_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    final session = supabase.auth.currentSession;
    if (session == null) {
      _navigateToRegisterPage();
    } else {
      _navigateToHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
  

  void _navigateToHomePage() {
    Navigator.of(context)
        .pushAndRemoveUntil(HomePage.route(), (route) => false);
  }

  void _navigateToRegisterPage() => Navigator.of(context)
      .pushAndRemoveUntil(RegisterPage.route(), (route) => false);
}
