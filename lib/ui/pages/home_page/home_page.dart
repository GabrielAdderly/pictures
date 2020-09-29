import 'package:flutter/material.dart';
import 'package:pictures_view/theme/custom_theme.dart';

import 'package:pictures_view/widgets/clean_behavior.dart';
import 'package:pictures_view/widgets/cashed_network_image.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';

class HomePage extends StatelessWidget {
  HomePage() : super(key: Key('SettingsPage'));

  final List<String> urlImages = [
    for (int i = 0; i < 20; i++) ...[
      'https://www.freedigitalphotos.net/images/img/homepage/394230.jpg',
      'https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg',
      'https://filedn.com/ltOdFv1aqz1YIFhf4gTY8D7/ingus-info/BLOGS/Photography-stocks3/stock-photography-slider.jpg',
      'https://i.insider.com/5eb031e1e3c3fb77d21c342e?width=1100&format=jpeg&auto=webp',
      'https://handluggageonly.co.uk/wp-content/uploads/2018/05/The-12-Best-Markets-In-Paris-You-Have-To-Visit-3.jpg',
      'https://img.fixthephoto.com/blog/UserFiles/Image/222/best-camera-for-sports_640x640.jpg',
      'https://s14761.pcdn.co/wp-content/uploads/sites/2/2019/12/eMTB-grouptest-2019-19-Specialized-Turbo-Kenevo-Expert-032-2-1140x760.jpg',
      'https://cdn.mos.cms.futurecdn.net/8NpCPa3JSLsmA2hN8GQiih-768-80.jpg',
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bgColor: CustomTheme.colors.accentColor,
      appBar: MainAppBar(title: 'image gallery'.toUpperCase()),
      child: ScrollConfiguration(
        behavior: CleanBehavior(),
        child: GridView.builder(
          key: Key('Grid'),
          itemCount: urlImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedImage.squared(
                size: 200.0,
                imageUrl: urlImages[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
