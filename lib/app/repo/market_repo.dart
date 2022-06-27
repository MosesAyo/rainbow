import '../model/market_model.dart';
import 'package:dio/dio.dart';

class MarketAPI {
  Future<MarketModel> getCryptoPrices() async {
    // print('getting data');
    //async to use await, which suspends the current function, while it does other stuff and resumes when data ready
    // print('getting crypto prices');
    String _apiURL =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"; //url to get data
    final response = await Dio().get(
      _apiURL,
      options: Options(
        headers: {
          'X-CMC_PRO_API_KEY':
              '4fcac416-2bd4-4b38-8d2e-e4334cad9f64' // set content-length
        },
        followRedirects: false,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    // print(response.data);
    return MarketModel.fromData(response.data);
  }
}
