import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frazex/cubits/home/homestate.dart';
import 'package:frazex/models/image_model.dart';
import 'package:frazex/services/data_service.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState());

  TextEditingController searchQueryController = TextEditingController();

  void clearText() {
    searchQueryController.clear();
  }

  showSnackbar(BuildContext context) {
    SnackBar snackBar = SnackBar(content: Text("Axtarış mətni boş ola bilməz"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future getData() async {
    if (searchQueryController.text.isEmpty) {
      emit(NoTextState());
    } else {
      emit(LoadingState());
      DataService dataService = DataService();
      try {
        List<ImageModel> images =
            await dataService.getInfo(searchQueryController.text);
        emit(SuccessState(images));
        print("successed");
      } catch (e) {
        emit(ErrorState());
        print(e);
      }
    }
  }
}
