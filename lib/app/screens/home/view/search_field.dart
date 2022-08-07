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
        decoration: InputDecoration(
          contentPadding: 16.horizontal,
          fillColor: AppColors.black400,
          hintText: 'Search',
          hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.grey,
              ),
          prefixIcon: const Icon(
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
