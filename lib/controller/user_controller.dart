
import 'package:get/get.dart';
import 'package:task/model/user_model.dart';
import 'package:task/service/api_service.dart';

class UserController  extends GetxController{

var users= <User>[].obs;
var isLoading=true.obs;
var errorMessage=''.obs;

@override
void onInit(){
  fetchUsers();
  super.onInit();
}
Future<void> fetchUsers()async{
  try{
    isLoading(true);
    errorMessage('');
    users.value=await ApiService.fetchUsers();
  }catch(e){
    errorMessage(e.toString());
  }finally{
    isLoading(false);
  }
}
}