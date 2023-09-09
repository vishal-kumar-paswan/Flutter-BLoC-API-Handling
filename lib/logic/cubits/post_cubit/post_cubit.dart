import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api_handling/data/models/post_model.dart';
import 'package:flutter_bloc_api_handling/data/repositories/post_repository.dart';
import 'package:flutter_bloc_api_handling/logic/cubits/post_cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    _fetchPosts();
  }

  final PostRepository _postRepository = PostRepository();

  void _fetchPosts() async {
    try {
      List<PostModel> post = await _postRepository.fetchPosts();
      emit(PostLoadedState(post));
    } on DioException catch (e) {
      // Exception occured while fetching the data are thrown
      // and caught and handled here!! :)
      if (e.type == DioExceptionType.unknown) {
        emit(PostErrorState(
            "Can't fetch posts, check your internet and try again"));
      } else {
        emit(PostErrorState(e.message.toString()));
      }
    }
  }
}
