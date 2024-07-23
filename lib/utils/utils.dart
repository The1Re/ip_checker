

Duration getDifferenceTime(int targetTimestamp) {
  DateTime targetTime = DateTime.fromMillisecondsSinceEpoch(targetTimestamp * 1000);
  DateTime currentTime = DateTime.now();
  return currentTime.difference(targetTime);
}