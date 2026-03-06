import 'package:flutter/material.dart';

class PostForm extends StatelessWidget {
  const PostForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.bodyController,
    required this.onSubmit,
    required this.isSubmitting,
    required this.submitLabel,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController bodyController;
  final VoidCallback onSubmit;
  final bool isSubmitting;
  final String submitLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? "Title is required" : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Body"),
              maxLines: 5,
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? "Body is required" : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isSubmitting ? null : onSubmit,
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(submitLabel),
            ),
          ],
        ),
      ),
    );
  }
}
