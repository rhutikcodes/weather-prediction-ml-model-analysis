import 'package:flutter/material.dart';

import '../utils/consts.dart';
import '../models/data_model.dart';

class BarData {
  static int interval = 20;

  static List<Data> barData = [
    const Data(
      id: 0,
      name: Model.SUPPORT_VECTOR_MACHINE,
      y: 97.62,
      color: Color(0xff19bfff),
    ),
    const Data(
      name: Model.ARTIFICIAL_NEURAL_NETWORK,
      id: 1,
      y: 99.74,
      color: Color(0xffff4d94),
    ),
    const Data(
      name: Model.NAIVE_BAYES,
      id: 2,
      y: 87.83,
      color: Color(0xff2bdb90),
    ),
    const Data(
      name: Model.LOGISTIC_REGRESSION,
      id: 3,
      y: 96.56,
      color: Color(0xffffdd80),
    ),
    const Data(
      name: Model.RANDOM_FORREST,
      id: 4,
      y: 99.94,
      color: Color.fromARGB(255, 128, 156, 255),
    ),
  ];
}
