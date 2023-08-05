import 'package:vibration/vibration.dart';

bool vibrationOn = true;

//Vibration
void vibrate() async{
  bool? shouldVibrate = await Vibration.hasVibrator();
  if (shouldVibrate ?? false) {
    // Trigger vibration if supported
    Vibration.vibrate(duration: 20);
  }
}

// onPressed: () async{
//             vibrationOn ? vibrate(): null;