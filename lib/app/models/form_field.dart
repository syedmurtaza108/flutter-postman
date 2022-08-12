class FormField {
  FormField({this.content = '', this.error});

  final String content;
  final String? error;

  FormField copyWith({
    String? content,
    String? error,
  }) {
    return FormField(
      content: content ?? this.content,
      error: error,
    );
  }
}
