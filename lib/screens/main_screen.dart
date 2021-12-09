import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/main/main_cubit.dart';
import 'package:frazex/cubits/main/main_state.dart';
import 'package:frazex/screens/home.dart';
import 'package:frazex/screens/profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'explore.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(builder: (context, state) {
      List<Widget> pages = context.read<MainCubit>().pages;
      int page = state.props.first as int;
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            onTap: (page) {
              context.read<MainCubit>().changePages(page);
            },
            currentIndex: page,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.photo),
                  label: AppLocalizations.of(context)!.findpage),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search),
                  label: AppLocalizations.of(context)!.explorepage),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: AppLocalizations.of(context)!.profilepage)
            ]),
        body: IndexedStack(
          index: page,
          children: pages,
        ),
      );
    });
  }
}
