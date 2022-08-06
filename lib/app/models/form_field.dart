class FormField {
  FormField({this.content = '', this.showError = false, this.error});

  final String content;
  final bool showError;
  final String? error;

  FormField copyWith({
    String? content,
    bool? showError,
    String? error,
  }) {
    return FormField(
      content: content ?? this.content,
      showError: showError ?? this.showError,
      error: error ?? this.error,
    );
  }
}
