import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../utils/consts.dart';

class TrainingProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> modelData = {
    Model.SUPPORT_VECTOR_MACHINE: {
      "name": Model.SUPPORT_VECTOR_MACHINE,
      "accuracy": 0,
      "status": "initial",
      "route": "supportVectorMachine"
    },
    Model.ARTIFICIAL_NEURAL_NETWORK: {
      "name": Model.ARTIFICIAL_NEURAL_NETWORK,
      "accuracy": 0,
      "status": "initial",
      "route": "artificialNeuralNetwork"
    },
    Model.NAIVE_BAYES: {
      "name": Model.NAIVE_BAYES,
      "accuracy": 0,
      "status": "initial",
      "route": "naiveBayes"
    },
    Model.LOGISTIC_REGRESSION: {
      "name": Model.LOGISTIC_REGRESSION,
      "accuracy": 0,
      "status": "initial",
      "route": "logisticRegression"
    },
    Model.RANDOM_FORREST: {
      "name": Model.RANDOM_FORREST,
      "accuracy": 0,
      "status": "initial",
      "route": "randomForest"
    }
  };
  Future<void> startTraining(String modelName) async {
    const BACKEND_API =
        String.fromEnvironment('BACKEND_API', defaultValue: 'BACKEND_API');
    print(BACKEND_API);
    for (var element in modelData.entries) {
      if (element.key == modelName) {
        element.value['status'] = 'training';
        final String route = element.value['route'];
        Logger().d(element);
        Logger().d(BACKEND_API + route);
        notifyListeners();
        Dio().get(BACKEND_API + route).then((value) => {
              Logger().i(value),
              element.value['accuracy'] = value.data['accuracy'],
              element.value['status'] = 'trained',
              Logger().e(element),
              notifyListeners(),
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
