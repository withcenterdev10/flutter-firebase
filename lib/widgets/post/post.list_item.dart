import 'package:fb_test2/models/post/post.model.dart';
import 'package:fb_test2/utils/string/string.util.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post, required this.onTap});

  final PostModel post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initials = StringUtil.initials(post.author?.name);

    return ListTile(
      leading: CircleAvatar(child: Text(initials)),
      title: Text(post.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringUtil.displayName(post.author?.name)),
          Text(
            post.body ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: const Icon(Icons.chevron_right),
      isThreeLine: true,
      onTap: onTap,
    );
  }
}
