import 'package:flutter_work_manager/service/custom_work_manager.dart';
import 'package:flutter_work_manager/service/location_service.dart';
import 'package:flutter_work_manager/state_util.dart';
import 'package:flutter/material.dart';
import 'module/user_list/view/user_list_view.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     log("Native called background task:: $task");

//     log("DIO Request running");
//     var response = await Dio().post(
//       "https://capekngoding.com/demo/api/users",
//       options: Options(
//         headers: {
//           "Content-Type": "application/json",
//         },
//       ),
//       data: {
//         "user_name": "Demo",
//         "latitude": 0,
//         "longitude": 0,
//         "created_at": DateTime.now().toString(),
//       },
//     );

//     Map obj = response.data;

//     log("DIO Request success!");
//     return Future.value(true);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocationService.requestPermission();
  CustomWorkManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserListView(),
    );
  }
}
