class DailySummary {
  final int waterMl;
  final int caffeineCount;
  final int junkCount;
  final int napCount;
  final int dopamineCount;

  const DailySummary({
    required this.waterMl,
    required this.caffeineCount,
    required this.junkCount,
    required this.napCount,
    required this.dopamineCount,
  });

  static const empty = DailySummary(
    waterMl: 0,
    caffeineCount: 0,
    junkCount: 0,
    napCount: 0,
    dopamineCount: 0,
  );
}
