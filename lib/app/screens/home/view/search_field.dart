part of './home_page.dart';

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        style: Theme.of(context).textTheme.caption,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          fillColor: AppColors.black400,
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.white,
            size: 14,
          ),
          filled: true,
        ),
      ),
    );
  }
}
