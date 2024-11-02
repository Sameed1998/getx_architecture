import 'package:getx_mvvm/models/login/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{
  
  Future<bool> saveUser(UserModel responseModel) async {
    // Save user information to shared preferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    
    await sp.setString('access_token', responseModel.accessToken);
    await sp.setString('refresh_token', responseModel.refreshToken);
    await sp.setInt('user_id', responseModel.id);
    await sp.setString('username', responseModel.username);
    await sp.setString('email', responseModel.email);
    await sp.setString('first_name', responseModel.firstName);
    await sp.setString('last_name', responseModel.lastName);
    await sp.setString('gender', responseModel.gender);
    await sp.setString('image', responseModel.image);

    return true;
  }
  
  // method to retrieve user data
  Future<UserModel?> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? accessToken = sp.getString('access_token');
    String? refreshToken = sp.getString('refresh_token');
    int? userId = sp.getInt('user_id');
    String? username = sp.getString('username');
    String? email = sp.getString('email');
    String? firstName = sp.getString('first_name');
    String? lastName = sp.getString('last_name');
    String? gender = sp.getString('gender');
    String? image = sp.getString('image');

    if (accessToken != null && refreshToken != null && userId != null) {
      return UserModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        id: userId,
        username: username ?? '',
        email: email ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        gender: gender ?? '',
        image: image ?? '',
      );
    }

    return null; // Return null if user data is not found
  }
  Future<bool> removeUser() async {
    // Remove user information from shared preferences
    SharedPreferences sp = await SharedPreferences.getInstance();
    
    await sp.clear();

    return true;
  }
}
