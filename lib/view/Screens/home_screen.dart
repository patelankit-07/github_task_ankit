import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';
import 'package:grocery_apps/view/main_layout.dart';
import 'package:grocery_apps/view/screens/all_products_screen.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/product_provider.dart';
import '../../utils/app_widgets/custom_app_bar.dart';
import '../../utils/app_widgets/item_card.dart';
import '../../utils/colors/app_colors.dart';
import 'cart_screen.dart';
import 'filterProductsCategory_screen.dart';
import 'product_detail_screen.dart';
import 'categories_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../utils/app_widgets/category_item.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      provider.getProducts().then((value) =>  provider.getCategory(),);

    });
  }


  static List<Widget> _widgetOptions = <Widget>[
    FruitsScreen(),
    CategoriesScreen(),
    CartScreen(),
    Center(child: Text('Cart Screen')),
    Center(child: Text('Profile Screen')),
  ] ;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(appBar: customAppBar(
      context: context,
      height: 150,
      title: Column(
        children: [
          ListTile(
            title: Text(
              "Hey 😊",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text("Lets search your grocery food",
                style: TextStyle(color: Colors.white)),
            trailing:CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: 10.borderRadius,
                      borderSide: BorderSide.none),
                  border: OutlineInputBorder(
                      borderRadius: 10.borderRadius,
                      borderSide: BorderSide.none),
                  prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: 10.horizontalPadding,
                  hintText: "Search your daily grocery food...",
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
            ),
          ),
        ],
      ),
    ), body: ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        ItemCard(child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              trailing: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(),));
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: green, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 160,
              child: Consumer<ProductProvider>(builder: (context, provider, child) {

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.categoryProducts.length,
                  itemBuilder: (context, index) {
                    var category = provider.categoryProducts[index];
                    return CategoryItem(
                      onItemTap: () {
                        provider.filterProductsCategory(category.category ?? "");
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                FilterProductsCategory(
                                  name: category.category ?? "",
                                ),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      categoryName: '${category.category}',
                      categoryImage: "${category.image}",
                    );
                  },
                );
              },),
            )
          ],
        )),
        Consumer<ProductProvider>(builder: (context, provider, child) => appSlider(provider.sliderImages),) ,
        ItemCard(child: Column(
          children: [
            ListTile(
              horizontalTitleGap: 0,
              leading: const Text(
                "Popular deals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              trailing: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => AllProductsScreen(),
                        transitionsBuilder: (context, animation,
                            secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(color: green, fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 210,
              child: Consumer<ProductProvider>(builder: (context, provider, child) {
                var productList = provider.products;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount:  productList.length,
                  itemBuilder: (context, index) {
                    var product = productList[index];
                    return CategoryItem(
                      onItemTap: () {},
                      categoryName: '${product.title}',
                      categoryImage: '${product.image}',
                      width: 150,
                      height: 150,

                    );
                  },
                );
              },),
            )
          ],
        )),
      ],
    ),);

  }

  Widget appSlider(List<String> images){
    return    Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: CarouselSlider(
        items: images.map((url) {
          return Container(
            margin: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: 15.borderRadius,
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: 150.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class FruitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.green,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 16,
                right: 16,
                bottom: 29,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey 😊',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Let's search your grocery food.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your daily grocery food...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16), // Added space for the carousel
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: CarouselSlider(
                items: [
                  'https://cdn.prod.website-files.com/5f6cc9cd16d59d990c8fca33/6570840942dc5c47e83df2d0_list-of-vegetables.jpg',
                  'https://www.shutterstock.com/shutterstock/photos/2465650867/display_1500/stock-photo-organic-vegetarian-vegan-grocery-fruit-vegetable-fresh-2465650867.jpg',
                  'https://www.organicfacts.net/wp-content/uploads/vegetarianfood.jpg',
                  "https://www.foodandwine.com/thmb/-Yxlx-cou8lNguYnp5HcNH2rX1Q=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Potatoes-May-No-Longer-Be-Considered-a-Vegetable-FT-BLOG1223-83fa6005a5bf4210aac4b1cc6fd35774.jpg",
                  'https://thumbs.dreamstime.com/b/set-vegetables-17810601.jpg',
                ].map((url) {
                  return Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: provider.products.length,
                      itemBuilder: (context, index) {
                        final product = provider.products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    ProductDetailScreen(product: product),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: "${product.id}",
                            child: Card(
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      "${product.image}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(child: Text('Image not available'));
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${product.title}", style: TextStyle(fontSize: 16)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('\$${product.price}', style: TextStyle(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}







