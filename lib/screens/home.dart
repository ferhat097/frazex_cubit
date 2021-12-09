import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/home/homecubit.dart';
import 'package:frazex/cubits/home/homestate.dart';
import 'package:frazex/cubits/language/language_cubit.dart';
import 'package:frazex/models/image_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, isSliver) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              actions: [],
              centerTitle: true,
              titleSpacing: 0,
              //toolbarHeight: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
              snap: true,
              floating: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200],
                          ),
                          child: TextField(
                            controller: BlocProvider.of<HomeCubit>(context)
                                .searchQueryController,
                            textInputAction: TextInputAction.search,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            style: GoogleFonts.encodeSans(
                              color: Colors.black,
                            ),
                            onSubmitted: (_) {
                              BlocProvider.of<HomeCubit>(context, listen: false)
                                  .getData();
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)!
                                  .findphoto, //"Şəkil axtar",
                              hintStyle: GoogleFonts.encodeSans(
                                color: Colors.black54,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  BlocProvider.of<HomeCubit>(context,
                                          listen: false)
                                      .clearText();
                                  BlocProvider.of<LanguageCubit>(context)
                                      .changeLanguage("az");
                                },
                                child: const Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              BlocProvider.of<HomeCubit>(context, listen: false)
                                  .getData();
                            },
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state == NoTextState()) {
                var snackbar = SnackBar(
                    content: Text(AppLocalizations.of(context)!.textempty));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            builder: (context, state) {
              if (state == InitialState()) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.forfindwrite),
                );
              } else if (state == LoadingState()) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == ErrorState()) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.error),
                );
              } else if (state == NoTextState()) {
                return Center(
                  child: Text(AppLocalizations.of(context)!.textempty),
                );
              } else {
                // List<ImageModel> photos =
                //     context.read<HomeCubit>().state.props as List<ImageModel>; or
                return successState(context, state.props as List<ImageModel>);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget successState(BuildContext context, List<ImageModel> photos) {
    return RefreshIndicator(
      onRefresh: () async {
        await BlocProvider.of<HomeCubit>(context).getData();
      },
      child: GridView.builder(
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          print(photos[index].imageUrl);
          return Image.network(
            photos[index].imageUrl,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
