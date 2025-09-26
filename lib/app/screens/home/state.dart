import 'package:get/get.dart';
import 'package:react_native_test/app/app.dart';

class HomeState {
  Rxn<UserModel> userModel = Rxn<UserModel>();

  RxBool isLoading = false.obs;
  RxBool isHasError = false.obs;
}
