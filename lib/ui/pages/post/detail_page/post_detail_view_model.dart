// 창고 데이터
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_store.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PostDetailModel {
  Post post;
  PostDetailModel(this.post);
}

// 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  PostDetailViewModel(super._state, this.ref);
  Ref ref;

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");

    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailModel(responseDTO.data);
  }
}

// 창고 관리자
// family는 파리미터를 전달가능
final postDetailProvider =
    StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>(
        (ref) {
  int postId = ref.read(paramProvider).postDetailId!;
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
