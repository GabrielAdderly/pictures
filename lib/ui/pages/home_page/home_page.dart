import 'package:flutter/material.dart';
import 'package:pictures_view/models/dtos/category_dto.dart';
import 'package:pictures_view/theme/custom_theme.dart';
import 'package:pictures_view/ui/widgets/categories_list.dart';
import 'package:pictures_view/ui/widgets/image_card.dart';

import 'package:pictures_view/ui/layouts/appbars/main_appbar.dart';
import 'package:pictures_view/ui/layouts/main_layout/main_layout.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

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

  final List<CategoryDTO> _categories = [
    CategoryDTO(text: 'Bird'),
    CategoryDTO(text: 'Eminem', isSelected: true),
    CategoryDTO(text: 'Exterior'),
    CategoryDTO(text: 'House'),
    CategoryDTO(text: 'Gamer room'),
    CategoryDTO(text: 'Cat'),
    CategoryDTO(text: 'Tea'),
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bgColor: CustomTheme.colors.accentColor,
      appBar: MainAppBar(
        title: 'IMAGE GALLERY',
        controller: controller,
      ),
      child: Column(
        children: <Widget>[
          CategoriesList(
            key: Key('categories_list'),
            categories: _categories,
            selectCallback: (int index) {},
          ),
          Container(
            height: MediaQuery.of(context).size.height - 250,
            width: double.infinity,
            child: GridView.builder(
              key: Key('Grid'),
              itemCount: urlImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
              ),
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageCard(
                    key: Key('image_card_$index'),
                    card: CardDTO(
                      id: index.toString(),
                      title: 'Test card $index',
                      content: 'Some text here for testing some things',
                      imageUrl: urlImages[index],
                      isLiked: index % 2 == 0 ? true : false,
                      likesCount: index * index,
                    ),
                    onTap: () {},
                    likeCallback: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
