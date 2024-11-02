import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/models/home/user_list_model.dart';
import 'package:getx_mvvm/repository/home_repository/home_repository.dart';

class HomeController extends GetxController{

  final _api = HomeRepository();

  RxString error = "".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final userList = UserListModel().obs;

  void setRxRequestStatus(Status myvalue)=> rxRequestStatus.value = myvalue;
  void setUserList(UserListModel myvalue)=> userList.value = myvalue;
  void setError(String myvalue)=> error.value = myvalue;

  dynamic userListApi()async{
    setRxRequestStatus(Status.LOADING);
    try {
      dynamic response = await _api.getUsersList();
      setRxRequestStatus(Status.COMPLETED);
      setUserList(response);
      return response;
    } catch (e) {
      if(kDebugMode) print(e.toString());
      setError(e.toString());
      setRxRequestStatus(Status.ERROR);
    }
  }

}