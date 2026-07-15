import 'dart:async';
import 'dart:io';

import 'package:delivery_app/src/core/utils/either.dart';
import 'package:delivery_app/src/core/utils/failure.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/data/source/home_data_source.dart';
import 'package:dio/dio.dart';

class HomeDataSourceImpl extends HomeDataSource {
  @override
  Future<Either<Failure, List<ServiceModel>>> getServiceLocations() async {
    try {
      final response = await Dio()
          .get("https://6a54cf95e49d9eb2cc552bd5.mockapi.io/services");

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print('getServiceLocations malumot keldi ${response.statusCode}');
        List<ServiceModel> data = (response.data as List)
            .map((map) => ServiceModel.fromJson(map))
            .toList();
        return Right(data);
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } on TimeoutException catch (_) {
      print('getServiceLocations timout exception chiqdi !');
      return Left(TimeOutFailure(message: 'Check your internet please !'));
    } on SocketException catch (_) {
      print('getServiceLocations internet yoq  chiqdi !');
      return Left(SocketFailure(message: 'Internet yoq !'));
    } on FormatException catch (error) {
      print('getServiceLocations FormatException exception chiqdi !');
      return Left(Failure(message: error.message));
    } on DioException catch (error) {
      print('DioException timout exception chiqdi !');
      return Left(DioFailure(errorMessage: error.requestOptions.data));
    } catch (error) {
      print('Catch dagi xato keldi $error');
      return Left(Failure(message: 'Xatolik yuzga keldi !'));
    }
  }
}