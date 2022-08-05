part of './home_page.dart';

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(24),
    );
    return SizedBox(
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 14, color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          fillColor: AppColors.black400,
          filled: true,
          enabledBorder: border,
          focusedBorder: border,
          border: border,
          disabledBorder: border,
        ),
      ),
    );
  }
}
