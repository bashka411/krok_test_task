// import 'package:flutter/material.dart';
// import 'package:pedometer/pedometer.dart';

// class ExampleApp extends StatefulWidget {
//   @override
//   _ExampleAppState createState() => _ExampleAppState();

//   const ExampleApp({super.key});
// }

// class _ExampleAppState extends State<ExampleApp> {
//   late Stream<StepCount> _stepCountStream;
//   String _steps = '?';

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   void onStepCount(StepCount event) {
//     print(event);
//     setState(() {
//       _steps = event.steps.toString();
//     });
//   }

//   void onStepCountError(error) {
//     print('onStepCountError: $error');
//     setState(() {
//       _steps = 'Step Count not available';
//     });
//   }

//   void initPlatformState() {
//     _stepCountStream = Pedometer.stepCountStream;
//     _stepCountStream.listen(onStepCount).onError(onStepCountError);

//     if (!mounted) return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp();
//   }
// }
