part of './home_page.dart';

class _TopWidget extends StatelessWidget {
  const _TopWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(width: 200, child: _SearchField()),
          16.width,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: 4.padding,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.blue200,
                        AppColors.blue400,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Syed Murtaza'.body1,
                    'User'.body2,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
