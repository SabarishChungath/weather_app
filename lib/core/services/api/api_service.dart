import 'package:climate_app/core/services/api/api_client.dart';
import 'package:climate_app/core/services/errors/exceptions.dart';
import 'package:climate_app/core/services/service_locator.dart';

///Retrieves or creates an instance of type [ApiService] depending on the registration function used in serviceLocator file.
final ApiService apiService = locator.get<ApiService>();

///Intermediate layer between api client and provider.
class ApiService {
  ///Api client object.
  BaseClient? api = BaseClient();

  setAuthorisation(String token) {
    api?.setToken(token);
  }

  _processError(e) {
    if (e is ClientException && e.statusCode == 401) {
      // Log out if token is invalid.
      // navigationService.navigatePushNamedAndRemoveUntilTo(
      //     LoginScreenRoute, true);
      // apiService.setAuthorisation('');
    }
  }

  Future fetchClimate({required double lat, required double long}) async {
    try {
      String url =
          "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$long&appid=d3ccd2d30df155f6b49a72c821b40a89";
      var response = await api?.get(url: url, isAuthenticated: false);
      return response;
    } catch (e) {
      // _processError(e);
      rethrow;
    }
  }

  Future fetchGeoCode(String query) async {
    try {
      String url =
          "http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=1&appid=d3ccd2d30df155f6b49a72c821b40a89";
      var response = await api?.get(url: url, isAuthenticated: false);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
