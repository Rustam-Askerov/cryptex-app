class Cryptocurrency {
  Cryptocurrency(
      {required this.id,
      required this.rank,
      required this.symbol,
      required this.name,
      required this.priceUsd,
      required this.changePercent24Hr});
  String id;
  int rank;
  String symbol;
  String name;
  double priceUsd;
  double changePercent24Hr;
}
