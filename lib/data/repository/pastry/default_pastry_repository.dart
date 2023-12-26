import 'dart:async';

import 'package:ambataapp/data/repository/pastry/pastry_repository.dart';
import 'package:collection/collection.dart';

import '../../model/pastry.dart';

class DefaultPastryRepository extends PastryRepository {
  final _controller = StreamController<List<Pastry>>.broadcast();

  final List<Pastry> _pastries = [
    Pastry(
      0,
      'Baguette',
      22000.0,
      'This baguette comes with a distinctive texture, crispy on the outside and soft on the inside. Perfect to be enjoyed as a light breakfast or served with your favorite dishes.',
      'https://theloopywhisk.com/wp-content/uploads/2023/05/Gluten-Free-Baguettes_1200px-featured.jpg',
      PastryCategory.bread,
    ),
    Pastry(
      1,
      'Croissant',
      30500.0,
      'Savor the alluring deliciousness of our croissants with a tantalizing crispy coating and soft texture inside. Made with heart, our croissants offer an unforgettable culinary experience. Their rich, buttery flavor and fragrant aroma make them perfect to enjoy anytime.',
      'https://cdn.idntimes.com/content-images/community/2023/01/20230119-092250-07baad106fdc4464a18f44e1ed0250ca.jpg',
      PastryCategory.bread,
    ),
    Pastry(
      2,
      'Muffin',
      16000.0,
      'Made from a mixture of wheat flour, sugar and eggs, our muffins provide just the right amount of sweetness and a soft texture. Ideal for a light breakfast, snack, or as an accompaniment to your favorite beverage.',
      'https://denpasarviral.com/wp-content/uploads/2022/07/WhatsApp-Image-2022-04-16-at-15.23.11-124.jpeg',
      PastryCategory.bread,
    ),
    Pastry(
      3,
      'Whole Grain Bread',
      48000.0,
      'These whole grain breads are carefully produced using the finest ingredients, creating a delicious and nutritious dining experience. Great for a healthy breakfast or light snack, our wholemeal bread is high in fiber and essential nutrients.',
      'https://down-id.img.susercontent.com/file/75e173a29c01e5554f6cc6dc287f7c18',
      PastryCategory.bread,
    ),
    Pastry(
      4,
      'White Bread',
      14000.0,
      'Savor the deliciousness and fluffiness of our premium white bread served with care. Made with the highest quality ingredients, these breads provide an exquisite breakfast or snack experience. The quality is guaranteed to 4-star hotel standards, and the price is very affordable, making it the perfect choice for any occasion. Our bread is suitable for all occasions, from daily breakfast to healthy snacks. The convenient packaging makes it an ideal choice for busy lifestyles.',
      'https://down-id.img.susercontent.com/file/d98837f1a962ce9ea5b580d1bdc8bf38',
      PastryCategory.bread,
    ),
    Pastry(
      5,
      'Chiffon Cake',
      45000.0,
      'Made with high-quality eggs, selected flour, and the finest ingredients, our Chiffon Cake is the perfect choice to accompany your special moments, such as coffee at dusk.',
      'https://kurio-img.kurioapps.com/22/09/26/c73c81b5-bbc3-45fa-ae98-5c4d0ed25c86.jpg',
      PastryCategory.cake,
    ),
    Pastry(
      6,
      'Genoise Cake',
      132000.0,
      'Enjoy the harmony of flavor and tenderness of our Genoise Cake produced from the perfect combination of the finest ingredients. Genoise Cake, with its traditional French roots, is the ideal choice to enhance your special moments.',
      'https://images.hellomagazine.com/horizon/square/9812ed377693-genoisesponge-t.jpg',
      PastryCategory.cake,
    ),
    Pastry(
      7,
      'Pound Cake',
      128000.0,
      'Savor the exquisite delights of our Pound Cake, an exquisite cake with a delicate taste and alluring classic flavors. Made with love and the finest ingredients, our Pound Cake is suitable for any occasion.',
      'https://sugarspunrun.com/wp-content/uploads/2021/04/LEMON-POUND-CAKE-1-of-1.jpg',
      PastryCategory.cake,
    ),
    Pastry(
      8,
      'Red Velvet Cake',
      145000.0,
      'Made with the finest ingredients, this cake has a soft texture with a generous layer of cream cheese on top. Ideal for celebrating special moments or as a perfect gift.',
      'https://www.allrecipes.com/thmb/gDJ1S6ETLfWGyyWw_4A_IGhvDYE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/9295_red-velvet-cake_ddmfs_4x3_1129-a8ab17b825e3464a9a53ceeda54ff461.jpg',
      PastryCategory.cake,
    ),
    Pastry(
      9,
      'Sponge Cake',
      45000.0,
      'Enjoy a light and fluffy delicacy with Sponge Cake, the perfect choice to savor special moments. Made with care and using quality ingredients, our Sponge Cake is suitable for any occasion.',
      'https://img-global.cpcdn.com/recipes/a922d418717a7614/1360x964cq70/japanese-cotton-sponge-cake-foto-resep-utama.webp',
      PastryCategory.cake,
    ),
    Pastry(
      10,
      'Bombolina',
      28000.0,
      'A delicious treat that tantalizes the taste buds and greets the stomach with perfect tenderness. Suitable to accompany any occasion, our Bomboloni is meticulously crafted using carefully selected ingredients to ensure every bite brings happiness.',
      'https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2022/10/05/998485218.jpg',
      PastryCategory.donut,
    ),
    Pastry(
      11,
      'Churros',
      28000.0,
      'The perfect snack to indulge your taste buds. Our churros are carefully crafted, combining traditional flavors with a modern twist. Suitable to be enjoyed anytime, our Churros are sure to become everyone`s favorite.',
      'https://www.frisianflag.com/storage/app/media/uploaded-files/churros-sederhana.jpg',
      PastryCategory.donut,
    ),
    Pastry(
      12,
      'Regular Donut',
      12000.0,
      'A perfect combination of softness, moistness, and enticing flavors. Our doughnuts are not just a snack, but an indulgent culinary experience.',
      'https://down-id.img.susercontent.com/file/92a5b2efb7ad5afd8c29260395255b90',
      PastryCategory.donut,
    ),
    Pastry(
      13,
      'Koeksister',
      56000.0,
      'A sweet treat that captivates the heart and delivers unparalleled pleasure. Meticulously crafted according to tradition, our Koeksister is the perfect choice to savor classic flavors in every bite.',
      'https://www.chelsea.co.nz/files/cache/e62cb1ddbe1d733b53d8cc8bee6e2e4c_f2581.jpeg',
      PastryCategory.donut,
    ),
    Pastry(
      14,
      'Zeppole',
      24000.0,
      'Serve up an authentic Italian taste sensation with our Zeppole, a delicious snack suitable for any occasion. Crafted with heart and tradition, our Zeppole will delight your taste buds with mesmerizing deliciousness.',
      'https://rickrodgers.com/wp-content/uploads/2015/03/Zeppole.jpg',
      PastryCategory.donut,
    ),
    Pastry(
      15,
      'Bika Ambon',
      73000.0,
      'A traditional cake that captivates with its unique and delicate flavor. Bika Ambon is the perfect choice to satisfy your taste buds.',
      'https://admin.sahabat.com/ckimages/eb22506c66c8f7759d1b927ad4550582_1681283847.jpg_1681283847.jpg',
      PastryCategory.local,
    ),
    Pastry(
      16,
      'Gambang Cake',
      6500.0,
      'A traditional dish that tantalizes the taste buds and pampers the tongue. This cake originates from Betawi and has a unique flavor. With the softness of wheat flour, kue gambang is the perfect choice to accompany a relaxing afternoon or as a light snack.',
      'https://img-global.cpcdn.com/recipes/b5eff976a88b5aa2/680x482cq70/roti-gambang-versi-empuk-foto-resep-utama.jpg',
      PastryCategory.local,
    ),
    Pastry(
      17,
      'Lapis Legit',
      89000.0,
      'This Lapis Legit is painstakingly baked, resulting in layer upon layer of perfection. Lapis Legit Indonesia is famous for its distinctive spice flavor, creating a perfect harmony between cinnamon, cloves and other spices. The softness of each layer feels so good on the tongue, providing an unforgettable taste experience.',
      'https://www.balipost.com/wp-content/uploads/2017/04/balipostcom_cnn-tempatkan-kue-lapis-legit-di-top-5-kue-terlezat-dunia_01-696x464.jpg',
      PastryCategory.local,
    ),
    Pastry(
      18,
      'Pancong',
      2500.0,
      'The pancong, soft on the inside and browned on the outside, offers an authentic taste experience. Pancong is made from quality ingredients, creating a delicious and alluring flavor. The uniqueness of Pancong lies in the perfect combination of tender grated coconut, coconut sugar that gives it a distinctive aroma, and rice flour that gives it a chewy texture.',
      'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/08/2023/08/08/FotoJet-2023-08-08T130848581-3760337870.jpg',
      PastryCategory.local,
    ),
    Pastry(
      19,
      'Surabi',
      6000.0,
      'Savor the traditional delights of Indonesia with Serabi, a snack that offers a soft and sweet taste in every bite. Serabi is an Indonesian-style pancake that is prepared with distinctive craftsmanship, giving each serving a special touch. It has a soft texture on the inside and a lightly crispy edge, creating a perfect harmony between softness and crunchiness. With the addition of grated coconut on top, Serabi is even more alluring with its distinctive aroma and authentic flavor.',
      'https://asset.kompas.com/crops/ppc2Ky-jXCV2fmus-GotYvmUX-c=/0x0:5000x3333/750x500/data/photo/2021/06/02/60b75ac64e085.jpg',
      PastryCategory.local,
    ),
  ];

  @override
  Stream<List<Pastry>> get pastries => _controller.stream;

  @override
  void getAllPastries() {
    Future.delayed(const Duration(milliseconds: 350))
        .then((_) => _controller.sink.add(_pastries));
  }

  @override
  Future<Pastry?> getPastryById(int id) async {
    Future.delayed(const Duration(milliseconds: 250));
    return _pastries.firstWhereOrNull((pastry) => pastry.id == id);
  }
}
