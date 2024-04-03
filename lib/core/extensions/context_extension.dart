import 'package:flutter/material.dart';
import 'package:map_task/features/map/domain/models/location_model.dart';

enum ToastType {
  ///Success
  success,

  ///Error
  error,

  ///Message
  message
}

extension HelperExtension on BuildContext {
  ///SnackBar Extension
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String message, required ToastType toastType}) {
    return ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: toastType == ToastType.message
          ? Colors.black
          : toastType == ToastType.success
              ? Colors.green
              : Colors.red,
    ));
  }

  ///bottom sheet extension
  void showBottomSheet(LocationModel locationModel) {
    showModalBottomSheet(
        context: this,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationModel.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _verticalGap(),
                Text("Region: ${locationModel.region}"),
                _verticalGap(),
                Text("Latitude: ${locationModel.latY}"),
                _verticalGap(),
                Text("Longitude: ${locationModel.longx}"),
                _verticalGap(),
                Text("Location Type: ${locationModel.featureClass}"),
                _verticalGap(),
              ],
            ),
          );
        });
  }
}

SizedBox _verticalGap() => const SizedBox(height: 8);
