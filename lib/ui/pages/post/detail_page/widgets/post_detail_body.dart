import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_buttons.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_content.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_profile.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/widgets/post_detail_title.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailBody extends ConsumerWidget {
  const PostDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO 3: watch? read?
    PostDetailModel? model = ref.watch(postDetailProvider);
    Post post = model!.post;
    //통신이 필요하면 if ,else 필요. 모델이 null이 절대아닐때는 Post post = model!.post;
    // if(model == null) {
    //
    // }else {
    //
    // }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          PostDetailTitle("${post.title}"),
          const SizedBox(height: largeGap),
          PostDetailProfile(),
          PostDetailButtons(),
          const Divider(),
          const SizedBox(height: largeGap),
          PostDetailContent("${post.content}"),
        ],
      ),
    );
  }
}
