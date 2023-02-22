import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:workmanager/workmanager.dart';

/*
Catatan Penting terkait Work Manager
1. Stop aplikasi-nya jika menambahkan action baru
2. Uninstall aplikasi-nya jika tiba2 Work Manager-nya Stuck,
lalu jalankan project Flutter-nya kembali
3. Pastikan user sudah melalakukan request permission untuk location jika Action
dari WorkManager-nya adalah meminta lokasi User
4. Periodic Task-nya , hanya bisa berjalan minimal 15 menit sekali!
*/

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    log(
      "Native called background task: $task",
    ); //simpleTask will be emitted here.

    try {
      Position position = await Geolocator.getCurrentPosition();
      var response = await Dio().post(
        "https://capekngoding.com/demo/api/users",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "user_name": "Demo",
          "latitude": position.latitude,
          "longitude": position.longitude,
          "created_at": DateTime.now().toString(),
        },
      );

      Map obj = response.data;
    } on Exception catch (err) {
      log(err.toString());
    }
    return Future.value(true);
  });
}

class CustomWorkManager {
  static init() async {
    if (!kIsWeb && Platform.isWindows) return;
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
  }

  static runOnce({
    required String taskname,
  }) async {
    Workmanager().registerOneOffTask(
      "task-identifier",
      "updateUser",
    );
  }

  static runAfter({
    required String taskname,
    required Duration duration,
  }) async {
    Workmanager().registerOneOffTask(
      "task-identifier",
      "updateUser",
      initialDelay: duration,
    );
  }

  static runEvery({
    required String taskname,
    required Duration duration,
  }) async {
    Workmanager().registerPeriodicTask(
      "task-identifier",
      "updateUser",
      frequency: duration,
    );
  }
}
