import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:permission_handler/permission_handler.dart';

import '../di/injector.dart';


class ImageDownloader {
  final Dio _dio = Dio();

  Future<Either<String, String>> downloadImage(
      String imageUrl, String savePath) async {
    try {
      if (await _requestStoragePermission()) {
        final response = await _dio.download(
          imageUrl,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              double progress = (received / total) * 100;
              print('Download progress: $progress%');
            }
          },
        );

        if (response.statusCode == 200) {
          // Image downloaded successfully
          return Right(savePath);
        } else {
          // Handle error
          return Left('Error downloading image');
        }
      } else {
        // Handle permission denied
        return Left('Permission denied');
      }
    } catch (e,stack) {
      logger.e(e.toString());
      logger.e(stack.toString());

      log(e.toString());
      // Handle other errors
      return Left('An error occurred');
    }
  }

  Future<bool> _requestStoragePermission() async {
    final plugin = DeviceInfoPlugin();
    PermissionStatus status;
    if(Platform.isAndroid){
      final android = await plugin.androidInfo;
       status = android.version.sdkInt < 33
          ? await Permission.storage.request()
          : PermissionStatus.granted;
      // final status = await Permission.storage.request();
      log(status.name);

    }else{
      status =await Permission.storage.request();
    }

    return status.isGranted;

  }
}
