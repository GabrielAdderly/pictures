import 'dart:math';

import 'package:flutter/material.dart';

import 'package:pictures_view/models/dtos/card_dto.dart';

final List<CardDTO> dummyImageList = [
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Lonely girl',
    content: 'He knows he\'s innocent. She knows he\'s a killer. Who do you believe?\n\n   In the shadow of a mountain in small-town Tasmania, a woman named Ana is watching the clock, marking the days until she ends her life. \n\n   The strange, reclusive daughter of the local pariah, that\'s how people will remember her, when they remember her at all. No one will mourn her, she reasons, not really. Not ...more',
    imageUrl: 'https://www.freedigitalphotos.net/images/img/homepage/394230.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Butterfly',
    content: 'Cute Butterfly',
    imageUrl: 'https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Round shnyaga',
    content: 'See the world with a round shnyaga!',
    imageUrl: 'https://filedn.com/ltOdFv1aqz1YIFhf4gTY8D7/ingus-info/BLOGS/Photography-stocks3/stock-photography-slider.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Star Wars Battle!',
    content: 'Experience the battle of two great titans from the Star Wars universe',
    imageUrl: 'https://i.insider.com/5eb031e1e3c3fb77d21c342e?width=1100&format=jpeg&auto=webp',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Eiffel Tower',
    content: 'Let\'s plunge into autumn Paris and try to feel this romantic atmosphere!',
    imageUrl:  'https://handluggageonly.co.uk/wp-content/uploads/2018/05/The-12-Best-Markets-In-Paris-You-Have-To-Visit-3.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Real Dude Basketball',
    content: 'Please rate my friend\'s Dunk!',
    imageUrl:  'https://img.fixthephoto.com/blog/UserFiles/Image/222/best-camera-for-sports_640x640.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Travel to the ends of the world',
    content: 'Today I want to share with you photos from a very fascinating journey.',
    imageUrl:   'https://s14761.pcdn.co/wp-content/uploads/sites/2/2019/12/eMTB-grouptest-2019-19-Specialized-Turbo-Kenevo-Expert-032-2-1140x760.jpg',
    likesCount: Random().nextInt(1000),
  ),
  CardDTO(
    id: UniqueKey().toString(),
    title: 'Shadow-boxing',
    content: 'Today we will learn how to fight like real fighters!',
    imageUrl:   'https://cdn.mos.cms.futurecdn.net/8NpCPa3JSLsmA2hN8GQiih-768-80.jpg',
    likesCount: Random().nextInt(1000),
  ),CardDTO(
    id: UniqueKey().toString(),
    title: 'Miss Fortune',
    content: 'Miss Fortune cosplay',
    imageUrl:   'https://hb.bizmrg.com/cybersportru-media/0a/0a448275bbe37c682966a34a85252e70.jpg',
    likesCount: Random().nextInt(1000),
  ),
];