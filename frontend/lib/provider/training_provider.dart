import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../utils/consts.dart';

class TrainingProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> modelData = {
    Model.SUPPORT_VECTOR_MACHINE: {
      "name": Model.SUPPORT_VECTOR_MACHINE,
      "accuracy": 0,
      "status": "initial"
    },
    Model.ARTIFICIAL_NEURAL_NETWORK: {
      "name": Model.ARTIFICIAL_NEURAL_NETWORK,
      "accuracy": 0,
      "status": "initial"
    },
    Model.NAIVE_BAYES: {
      "name": Model.NAIVE_BAYES,
      "accuracy": 0,
      "status": "initial"
    },
    Model.LOGISTIC_REGRESSION: {
      "name": Model.LOGISTIC_REGRESSION,
      "accuracy": 0,
      "status": "initial"
    },
    Model.RANDOM_FORREST: {
      "name": Model.RANDOM_FORREST,
      "accuracy": 0,
      "status": "initial"
    }
  };
  Future<void> startTraining(String modelName) async {
    for (var element in modelData.entries) {
      if (element.key == modelName) {
        element.value['status'] = 'training';
        Logger().d(element);
        notifyListeners();
        Future.delayed(const Duration(seconds: 5)).then((value) {
          var randomValue = Random().nextInt(100);
          Logger().i(randomValue);
          element.value['accuracy'] = randomValue;
          element.value['status'] = 'trained';
          Logger().e(element);
          notifyListeners();
        });
      }
    }
  }

  Future<void> trainAll() async {
    for (var element in modelData.entries) {
      await startTraining(element.key);
    }
  }

  Future<Map<String, Map<String, dynamic>>> getTrainedData() async {
    return modelData;
  }
}
