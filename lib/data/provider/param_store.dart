// 1. 창고 데이터
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParam {
  int? postDetailId;
  // int? commentId;
  RequestParam({this.postDetailId});
}

// 2. 창고 (비지니스 로직)
class ParamStore extends RequestParam {
  final mContext = navigatorKey.currentContext;

  void addPostDetailId(int postId) {
    //super나 this 모두 가능
    this.postDetailId = postId;
  }
}

// 3. 창고 관리자

final paramProvider = Provider<ParamStore>((ref) {
  return ParamStore();
});
