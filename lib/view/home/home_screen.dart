import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_mvvm/models/login/user_model.dart';
import 'package:getx_mvvm/res/components/general_exception.dart';
import 'package:getx_mvvm/res/components/internet_exception_widget.dart';
import 'package:getx_mvvm/res/routes/routes_name.dart';
import 'package:getx_mvvm/view_models/controller/home/home_view_model.dart';
import 'package:getx_mvvm/view_models/controller/user_preference/user_preference_view_model.dart';
import 'package:getx_mvvm/data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final UserPreference _userPreference = UserPreference();
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    userData = await _userPreference.getUser();
    if (mounted) setState(() {});
    _homeController.userListApi();
  }

  Future<void> _handleLogout() async {
    try {
      await _userPreference.removeUser();
      Get.offNamed(RoutesName.loginScreen);
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(userData?.username ?? "Guest"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Obx(() {
              final status = _homeController.rxRequestStatus.value;
              if (status == Status.LOADING) {
                return const Center(child: CircularProgressIndicator());
              } else if (status == Status.ERROR) {
                if(_homeController.error.value == "Internet Exception: No internet connection"){
                  return InternetExceptionWidget(onPress: _initializeData);
                }else{
                  return GeneralException(onPress: _initializeData,);
                }
                // return const Center(child: Text('Failed to load data'));
              } else if (status == Status.COMPLETED) {
                final posts = _homeController.userList.value.posts;
                if (posts == null || posts.isEmpty) {
                  return const Center(child: Text('No posts available'));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        child: ListTile(
                          title: Text(post.title ?? 'No title available'),
                          subtitle: Text(post.body ?? 'No body available'),
                          
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
