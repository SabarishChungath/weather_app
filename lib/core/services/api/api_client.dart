import 'dart:convert';
import 'package:climate_app/core/services/errors/exceptions.dart';
import 'package:dio/dio.dart';

///Base options for dio client.
var options = BaseOptions(
  contentType: "application/json",
  connectTimeout: 10000,
  receiveTimeout: 10000,
);

///**Api client for application.**
class BaseClient {
  ///Dio instance variable.
  Dio dio;

  // ignore: unused_field
  String _authToken = '';

  BaseClient() : dio = Dio(options);

  setToken(String token) {
    _authToken = token;
  }

  ///Add header to dio api calls.
  Map<String, dynamic> getHeaders(
      {bool isAuthenticated = true, Map<String, dynamic>? headers}) {
    Map<String, dynamic> _headers = dio.options.headers;

    try {
      if (isAuthenticated && _authToken != '') {
        _headers['access-token'] = _authToken;
      }
      if (headers != null) {
        _headers.addAll(headers);
      }
      return _headers;
    } catch (e) {
      return _headers;
    }
  }

  ///Get data using dio.
  get(
      {required String url,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.get(url,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Post data with dio.
  post(
      {required String url,
      dynamic payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.post(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Put data using dio.
  put(
      {required String url,
      Map<String, dynamic>? payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.put(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Delete data using dio.
  delete(
      {required String url,
      dynamic payload,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.delete(url,
          data: payload ?? {},
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Download data using dio.
  download(
      {required String url,
      required String filePath,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      await dio.download(url, filePath,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Get remoteConfiguration using dio.
  getRemoteConfig(
      {required String url,
      bool isAuthenticated = true,
      Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.get(url,
          options: Options(
              headers: getHeaders(
                  isAuthenticated: isAuthenticated, headers: headers)));
      return _processResponse(response);
    } on DioError catch (dioError) {
      throw _dioException(dioError);
    } catch (e) {
      rethrow;
    }
  }

  ///Process the response and throws exception accordingly with status code.
  _processResponse(Response? response) {
    switch (response?.statusCode) {
      case 200:
        var decodedJson = response?.data;
        return decodedJson;
      case 400:
        var message = jsonDecode(response.toString())["message"];
        throw ClientException(message: message, response: response?.data);
      case 401:
        var message = jsonDecode(response.toString())["message"];
        throw ClientException(
            message: message, response: response?.data, statusCode: 401);
      case 404:
        var message = jsonDecode(response.toString())["message"];
        throw ClientException(message: message, response: response?.data);
      case 500:
        {
          var message = jsonDecode(response.toString())["message"];
          if (message == "Invalid Promo Code") {
            throw AppException(message: 'Invalid Promo Code');
          } else {
            throw ServerException(message: 'Something went wrong');
          }
        }
      case 504:
        throw ServerException(message: 'Something went wrong');
      default:
        throw HttpException(
            statusCode: response?.statusCode, message: 'Something went wrong');
    }
  }

  ///Returns type of exception using DioErrorType.
  _dioException(DioError dioErr) {
    switch (dioErr.type) {
      case DioErrorType.response:
        throw _processResponse(dioErr.response);
      case DioErrorType.sendTimeout:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: 'Something went wrong');
      case DioErrorType.receiveTimeout:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: 'Something went wrong');
      default:
        throw HttpException(
            statusCode: dioErr.response?.statusCode,
            message: 'Something went wrong');
    }
  }
}
