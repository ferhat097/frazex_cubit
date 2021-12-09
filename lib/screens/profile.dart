import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/language/language_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text(
          "Fərhad",
          style: GoogleFonts.encodeSans(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
      ),
    );
  }

  Widget endDrawer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.6,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              "Dili dəyişmək üçün toxunun",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<LanguageCubit>(context)
                          .changeLanguage("az");
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/azerbaijan.png",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<LanguageCubit>(context)
                          .changeLanguage("tr");
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/turkey.png",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<LanguageCubit>(context)
                          .changeLanguage("en");
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        "assets/united-kingdom.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
