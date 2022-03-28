import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/training_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          backgroundColor: Colors.black,
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: TrainingProvider()),
            ],
            child: const CircularParticleScreen(),
          )),
    );
  }
}

class CircularParticleScreen extends StatelessWidget {
  const CircularParticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Background(screenHeight: screenHeight, screenWidth: screenWidth),
        const Heading(),
        Center(
          child: Consumer<TrainingProvider>(
            builder: ((context, trainingData, child) {
              var modelData = trainingData.modelData;
              List<Widget> rows = [];
              modelData.forEach(
                (key, value) {
                  if (value['status'] == 'initial') {
                    rows.add(ModelItem(
                      content: ModelBox(
                        child: //  const Center(
                            Center(
                          child: Text(
                            value['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      modelName: value['name'],
                    ));
                  } else if (value['status'] == 'training') {
                    rows.add(ModelItem(
                      content: ModelBox(
                          child: //  const Center(
                              Center(
                        child: Lottie.asset('assets/graph_animation.json'),
                      )),
                      modelName: value['name'],
                    ));
                  } else {
                    rows.add(ModelItem(
                      content: ModelBox(
                          child: //  const Center(
                              Center(
                        child: Text(
                          "Accuracy: ${value['accuracy']} \n\n ${value['name']}",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                      modelName: value['name'],
                    ));
                  }
                },
              );
              return Row(
                children: rows,
              );
            }),
          ),
        ),
        Positioned(
          bottom: 40,
          child: Row(
            children: [
              AnimatedButton(
                child: const Text(
                  'Train All',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Colors.cyan,
                onPressed: () {
                  Provider.of<TrainingProvider>(context, listen: false)
                      .trainAll();
                },
              ),
              const SizedBox(
                width: 20,
              ),
              AnimatedButton(
                child: const Text(
                  'Show Result',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                color: Colors.cyan,
                onPressed: () async {
                  var modelData = await Provider.of<TrainingProvider>(context,
                          listen: false)
                      .getTrainedData();

                  Logger().e(modelData);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ModelItem extends StatelessWidget {
  const ModelItem({
    Key? key,
    required this.content,
    required this.modelName,
  }) : super(key: key);

  final Widget content;
  final String modelName;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        content,
        const SizedBox(
          height: 20,
        ),
        AnimatedButton(
          width: 250,
          child: const Text(
            'Train',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          color: Colors.cyan,
          onPressed: () {
            Provider.of<TrainingProvider>(context, listen: false)
                .startTraining(modelName);
          },
        ),
      ],
    );
  }
}

class ModelBox extends StatelessWidget {
  const ModelBox({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 5,
            )),
        child: child);
  }
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      child: const Text(
        "Analysis of various machine learning approaches for rainfall prediction.",
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularParticle(
        key: UniqueKey(),
        awayRadius: 80,
        numberOfParticles: 500,
        speedOfParticles: 1,
        height: screenHeight,
        width: screenWidth,
        onTapAnimation: true,
        particleColor: const Color.fromARGB(34, 1, 209, 237).withAlpha(150),
        awayAnimationDuration: const Duration(milliseconds: 600),
        maxParticleSize: 4,
        isRandSize: false,
        isRandomColor: false,
        awayAnimationCurve: Curves.easeInOutBack,
        enableHover: true,
        hoverColor: Colors.white,
        hoverRadius: 60,
        connectDots: true, //not recommended
      ),
    );
  }
}
