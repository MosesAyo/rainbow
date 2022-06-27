class MarketModel {
  final List data;

  const MarketModel({
    required this.data,
  });

  factory MarketModel.fromData(Map<String, dynamic> map) {
    final _data = map['data'];
    // print(map);
    // print(_data[0]);

    return MarketModel(data: _data);
  }
}
