import 'package:fb_test2/services/post/post.service.dart';
import 'package:fb_test2/states/post_state.dart';
import 'package:fb_test2/states/user_state.dart';
import 'package:fb_test2/widgets/post/post.form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  static const String routeName = '/edit-post';
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    final post = PostState.of(context).selectedPost;
    _titleController = TextEditingController(text: post?.title ?? '');
    _bodyController = TextEditingController(text: post?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final post = PostState.of(context).selectedPost!;
    final userId = UserState.of(context).user!.id!;
    PostState.of(context).startSubmitting();
    final updated = await PostService.instance.updatePost(
      postId: post.id!,
      userId: userId,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
    );
    if (!mounted) return;
    PostState.of(context).updateSelectedPost(updated);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post updated successfully")),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Post")),
      body: Selector<PostState, bool>(
        selector: (_, s) => s.isLoading,
        builder: (context, isSubmitting, _) => PostForm(
          formKey: _formKey,
          titleController: _titleController,
          bodyController: _bodyController,
          onSubmit: _submit,
          isSubmitting: isSubmitting,
          submitLabel: "Save Changes",
        ),
      ),
    );
  }
}
