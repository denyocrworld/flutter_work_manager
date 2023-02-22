import 'package:flutter/material.dart';
import 'package:flutter_work_manager/core.dart';
import 'package:flutter_work_manager/service/custom_work_manager.dart';
import '../controller/user_list_controller.dart';

class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  Widget build(context, UserListController controller) {
    controller.view = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text("UserList"),
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                CustomWorkManager.runOnce(taskname: "updateUser");
              },
              child: const Text("Run once"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                CustomWorkManager.runAfter(
                  taskname: "updateUser",
                  duration: const Duration(seconds: 10),
                );
              },
              child: const Text("Run after 10seconds"),
            ),
            const SizedBox(
              height: 12.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () {
                CustomWorkManager.runEvery(
                  taskname: "updateUser",
                  duration: const Duration(minutes: 5),
                );
              },
              child: const Text("Run every 15 minutes"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<UserListView> createState() => UserListController();
}
