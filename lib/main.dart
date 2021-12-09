import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/home/homecubit.dart';
import 'package:frazex/cubits/language/language_cubit.dart';
import 'package:frazex/cubits/language/language_state.dart';
import 'package:frazex/cubits/main/main_cubit.dart';
import 'package:frazex/screens/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => MainCubit(),
        ),
      ],
      child:
          BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.props.first as Locale,
          title: 'Frazex',
          theme: ThemeData(),
          home: BlocProvider(
            create: (context) => HomeCubit(),
            child: const MainScreen(),
          ),
        );
      }),
    );
  }
}
