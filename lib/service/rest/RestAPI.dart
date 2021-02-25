import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'app_exceptions.dart';

class RestAPI {
  static String userLogin = 'http://65.0.127.170/wp-json/wp/v2/signin';

  static String getPostList(String userToken, int page, int userOnly) =>
      'http://13.235.24.93:3300/postslist?user_token=$userToken&page=$page&user_only=$userOnly';

  static String getPosts = 'http://13.235.24.93:3300/postslist';

  final Map<String, String> _headers = {
    "Accept": "application/json",
    'Content-type': 'application/json',
  };

  Dio _dio = new Dio();

  Future<T> get<T>(String url, {Map<String, dynamic> params}) async {
    try {
      print('Api Get, url $url  and $params\nheaders :: ${json.encode(_headers)}');
      var response = await _dio.get(url, queryParameters: params, options: Options(headers: _headers));
      print("GET RESPONSE = ${response.statusCode} $url ${response.data} ${response.extra}");

      return response.data;
    } on DioError catch (e) {
      print("DIO_EXCEPTION :: $e");
      throwException(e);
    }
    throw FetchDataException('Something went wrong, please try again');
  }

  Future<T> post<T>(String url, {Map<String, dynamic> params}) async {
    print('Api Post, url $url  and $params\nheaders :: ${json.encode(_headers)}');
    try {
      var response = await _dio.post(url, data: params, options: Options(headers: _headers));
      print("POST RESPONSE = ${response.statusCode} $url ${response.data} ${response.extra}");

      return response.data;
    } on DioError catch (e) {
      print("DIO_EXCEPTION :: $e");
      throwException(e);
    }
    throw FetchDataException('Something went wrong, please try again');
  }

  Future<File> downloadFile(
    String url,
    String savePath,
  ) async {
    Dio dio = new Dio();
    Response response = await dio.get(
      url,
      // onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }
}

/*Future<File> writeToFile(ByteData data) async {
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  var filePath = tempPath + '/${DateTime.now().toIso8601String()}.jpg'; // file_01.tmp is dump file, can be anything
  return new File(filePath).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}*/
void throwException(e) {
  switch (e.type) {
    case DioErrorType.CONNECT_TIMEOUT:
      throw FetchDataException('${e.error}');
      break;
    case DioErrorType.SEND_TIMEOUT:
      throw FetchDataException('${e.error}');
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      throw FetchDataException('${e.error}');
      break;
    case DioErrorType.RESPONSE:
      print("EXCEPTION :: ${e.response?.statusCode}");
      if (e.response.statusCode == 401) {
        throw UnauthorisedException("Unauthorized");
      }
      break;
    case DioErrorType.CANCEL:
      throw FetchDataException('${e.error}');
      break;
    case DioErrorType.DEFAULT:
      throw FetchDataException('${e.error}');
      break;
  }
}

dynamic _returnResponse(Response response) {
  switch (response.statusCode) {
    case 200:
      return response.data;
    case 404:
    case 400:
      throw BadRequestException(json.encode(response.data));
    case 401:
    case 403:
      throw UnauthorisedException(json.encode(response.data));
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
