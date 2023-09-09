import 'package:dio/dio.dart';
import 'package:flutter_bloc_api_handling/data/models/post_model.dart';
import 'package:flutter_bloc_api_handling/data/repositories/api/api.dart';

class PostRepository {
  static final API _api = API();

  Future<List<PostModel>> fetchPosts() async {
    try {
      Response response = await _api.sendRequest.get("/posts");
      List<dynamic> postMaps = response.data;
      return postMaps.map((post) => PostModel.fromJson(post)).toList();
    } catch (ex) {
      // If an Exception occurs while fetching data
      // it will be thrown to the Cubit's catch block for handling
      // throw ex;
      rethrow;
    }
  }
}
