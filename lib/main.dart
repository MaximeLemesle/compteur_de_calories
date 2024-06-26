import 'package:compteur_cal/blocs/aliment_cubit.dart';
import 'package:compteur_cal/blocs/user_cubit.dart';
import 'package:compteur_cal/repositories/preferences_repository.dart';
import 'package:compteur_cal/ui/screens/add_aliment.dart';
import 'package:compteur_cal/ui/screens/home.dart';
import 'package:compteur_cal/ui/screens/splash_screen.dart';
import 'package:compteur_cal/ui/screens/aliment_details.dart';
import 'package:compteur_cal/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // Pour pouvoir utiliser les SharePreferences avant le runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Instanciation des Cubit
  final AlimentCubit alimentCubit = AlimentCubit(PreferencesRepository());
  final UserCubit userCubit = UserCubit();

  // Chargement des aliments
  alimentCubit.loadAliments();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AlimentCubit>(
        create: (_) => alimentCubit,
      ),
      BlocProvider<UserCubit>(
        create: (_) => userCubit,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculateur de calories',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/home': (context) => const Home(),
        '/add_aliment': (context) => const AddAliment(),
        '/aliment_details': (context) => const AlimentDetails(),
        '/splashScreen': (context) => const SplashScreen(),
      },
      initialRoute: '/splashScreen',
    );
  }
}
