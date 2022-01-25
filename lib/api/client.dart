import 'package:carousel/model/imageModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi()
abstract class Client {
  factory Client() => _Client(
        Dio(
          BaseOptions(
            baseUrl: 'http://192.168.50.140/api',
          ),
        ),
      );

  @GET('/image')
  Future<List<ImageModel>> getList();
}
