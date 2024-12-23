import 'package:buzzcab/common/widgets/colors/color.dart';
import 'package:buzzcab/common/widgets/texts/appTextStyle.dart';
import 'package:flutter/material.dart';

class HomeScreenMapContainer extends StatelessWidget {
  const HomeScreenMapContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ride Ready? Let\'s Roll!',
            style: AppTextStyles.h6.copyWith(color: AppColors.background)),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.search,
                color: AppColors.background,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFF292929),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Search any location, place...",
                      style: AppTextStyles.label
                          .copyWith(color: AppColors.background)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: -5.0,
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: Image.network(
              'https://s3-alpha-sig.figma.com/img/3891/2979/dcad6d9b8067e0e8422ad45140e41e90?Expires=1734307200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=TWnxi3HpCIZZok6xE50Wui1PgdC0oF~UtTqoAcbhFJHtd0V-6MfZ0N-ruxvswizeAJOF50SZjvrnipoWu0Yu7Zrw-hAVD0nCWHK2pFCT-sARj30oraPLdLH3PSKcRPCjHGqmEy3YOdd26t0YBp100ObsxRKyxz3UUONH3zER~PTyo0gk~vd2P6L4sLYkruBVK4kXAGaMsy~pLbsRU2kwl0VnSclWqq-SZ9VPA4yOrYabTyviXQKjhpl1BdZyrD9t8DWG8gJllUETjbyVMKyJ-ZOu212oE-64OtmbgFA9NWqNyc~qsYvuP7I9tVGBSEMXPSeGJAOh5F3bQ9TiOJCe7Q__',
              fit: BoxFit.fill,
            ),
          ),
        )
      ],
    );
  }
}
