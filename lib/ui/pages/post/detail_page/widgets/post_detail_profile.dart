import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_store.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailProfile extends ConsumerWidget {
  const PostDetailProfile({Key? key}) : super(key: key);
  // final Post post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostDetailModel? model = ref.read(postDetailProvider);
    return ListTile(
        title: Text(model!.post.title),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset('assets/default_profile.png'),
        ),
        subtitle: Row(
          children: [
            Text(model!.post.user.email),
            const SizedBox(width: mediumGap),
            const Text("·"),
            const SizedBox(width: mediumGap),
            const Text("Written on "),
            Text("작성예정"),
          ],
        ));
  }
}
