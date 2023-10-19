import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//1 .창고 데이터
class PostListModel {
  List<Post> posts;
  PostListModel(this.posts);
}

//2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  PostListViewModel(super._state, this.ref);
  final mContext = navigatorKey.currentContext;

  Ref ref;

  Future<void> notifyinit() async {
    //jwt 가져오기
    SessionStore sessionStore = ref.read(sessionProvider);

    ResponseDTO responseDTO =
        await PostRepository().fetchPostList(sessionStore.jwt!);
    state = PostListModel(responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO dto) async {
    SessionStore sessionStore = ref.read(sessionProvider);
    ResponseDTO responseDTO =
        await PostRepository().savePost(sessionStore.jwt!, dto);

    if (responseDTO.code == 1) {
      Post newPost = responseDTO.data; // 1.dynamic(Post)  묵시적 형변환이 자동으로 이루어진다.
      // List<Post> posts = state!.posts;
      List<Post> newPosts = [
        newPost,
        ...state!.posts
      ]; // 2. 기존 상태에 데이터 추가[전개 연산자]
      state = PostListModel(newPosts);
      // 뷰모델(창고) 데이터 갱신이 완료 -> watch 구독자는 rebuild가 된다.}
      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(
          SnackBar(content: Text("게시물 작성 실패 : ${responseDTO.msg}")));
    }
  }
}

//3. 창고 관리자 (View 빌드되기 직전에 생성됨)
final postListProvider =
    StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  return PostListViewModel(null, ref)..notifyinit();
});
