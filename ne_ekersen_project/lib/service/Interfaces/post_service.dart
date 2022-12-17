import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:ne_ekersen_project/service/model/activity_model.dart';

abstract class IPostService {
  Future<List<ActivityModel>?> postItemsAdvance();

  Future<bool> AddPostAdvance(ActivityModel model);

  Future<bool> putItemToService(ActivityModel model, Guid id);

  Future<bool> deleteItem(Guid id);

  Future<List<ActivityModel>?> CommentPostWithId(Guid postId);
}

class PostService implements IPostService {
  final Dio _dio;

  PostService()
      : _dio =
  Dio(BaseOptions(baseUrl: 'https://localhost:7123/api/Activity/'));

  @override
  Future<List<ActivityModel>?> postItemsAdvance() async {
    try {
      final response = await _dio.get('https://localhost:7123/api/Activity/');

      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;
        if (_datas is List) {
          return _datas.map((e) => ActivityModel.fromJson(e)).toList();
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> AddPostAdvance(ActivityModel model) async {
    try {
      final response =
          await _dio.post('https://localhost:7123/api/Activity/', data: model);
      return response.statusCode == HttpStatus.created;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<ActivityModel>?> CommentPostWithId(Guid postId) async {
    try {
      final response = await _dio.get("https://localhost:7123/api/Activity/",
          queryParameters: {
            "https://localhost:7123/api/Activity/$postId": postId
          });
      if (response.statusCode == HttpStatus.ok) {
        final _datas = response.data;
        if (_datas is List) {
          return _datas.map((e) => ActivityModel.fromJson(e)).toList();
        }
      }
    } on DioError catch (_) {}
  }


  @override
  Future<bool> deleteItem(Guid id) async {
    try {
      final response = await _dio.delete(
          "https://localhost:7123/api/Activity/$id");
      return response.statusCode == HttpStatus.ok;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> putItemToService(ActivityModel model, Guid id) async {
    try {
      final response =
          await _dio.put("https://localhost:7123/api/Activity/$id", data: model);
      return response.statusCode == HttpStatus.ok;
    } catch (_) {
      return false;
    }
  }
}