import 'package:fitnessapp/providers/workout_provider.dart';
import 'package:fitnessapp/routes.dart';
import 'package:fitnessapp/utils/app_colors.dart';
import 'package:fitnessapp/view/dashboard/dashboard_screen.dart';
import 'package:fitnessapp/view/workout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutProvider(prefs: prefs)),
      ],
      child: MaterialApp(
        title: 'Fitness',
        debugShowCheckedModeBanner: false,
        routes: routes,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 119, 142, 255),
          useMaterial3: true,
          fontFamily: "Poppins"
        ),
        home: WorkoutScreen(),
      ),
    );
  }
}
