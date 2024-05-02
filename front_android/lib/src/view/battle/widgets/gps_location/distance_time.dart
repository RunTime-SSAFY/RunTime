part of 'gps_location.dart';

class DistanceTime extends ConsumerStatefulWidget {
  const DistanceTime({
    required this.distanceNow,
    required this.distance,
    required this.startTime,
    required this.currentTime,
    super.key,
  });

  final double distanceNow;
  final int distance;
  final DateTime startTime;
  final DateTime currentTime;

  @override
  ConsumerState<DistanceTime> createState() => _DistanceTimeState();
}

class _DistanceTimeState extends ConsumerState<DistanceTime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.distanceNow.toKilometer(),
              style: ref.typo.headline1.copyWith(
                color: ref.color.onBackground,
                fontSize: 60,
              ),
            ),
            Text(
              ' / ${widget.distance}km',
              style: ref.typo.body1.copyWith(
                color: ref.color.onBackground,
                fontSize: 40,
              ),
            ),
          ],
        ),
        Text(
          widget.currentTime.difference(widget.startTime).toHhMmSs(),
          style: ref.typo.mainTitle.copyWith(
            color: ref.color.onBackground,
            fontSize: 60,
          ),
        )
      ],
    );
  }
}
