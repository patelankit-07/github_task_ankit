
import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';
import 'package:grocery_apps/view/Screens/product_detail_screen.dart';
import 'package:grocery_apps/view/main_layout.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/product_provider.dart';
import '../../utils/app_widgets/custom_app_bar.dart';
import '../../utils/colors/app_colors.dart';

class AllProductsScreen extends StatefulWidget {

  AllProductsScreen({super.key,});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: customAppBar(context: context, title:  Text("All Products",style: TextStyle(color: white),),centerTitle:true ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: grey.withOpacity(0.01), width: 2),
                borderRadius: 20.borderRadius)    ,

          child: Consumer<ProductProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: provider.products.length,
                  itemBuilder: (context, index) {
                    final product = provider.products[index];
                    return PhysicalModel(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  ProductDetailScreen(product: product),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
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
                            elevation: 0,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: 15.borderRadius,
                                    child: Image.network(
                                      "${product.image}",
                                      fit: BoxFit.cover,
                                      height: 200,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                            child: Text('Image not available'));
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(

                                              "${product.title}",
                                              style: TextStyle(

                                                fontSize: 16,
                                              ),
                                              maxLines: product.isCounter == true ? 2 : 2,
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '\$${(product.price! * (product.counter+1)).toStringAsFixed(2)}',
                                              style: const TextStyle(fontSize: 14,

                                                  color: Colors.green,
                                                 ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10))),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Visibility(
                                              visible: product.isCounter,
                                              child: TextButton(
                                                  onPressed: () {
                                                      provider.decrement(product);
                                                  },
                                                  child: Icon(Icons.remove,color: Colors.white,)),
                                            ),
                                            Visibility(
                                                visible: product.isCounter,
                                                child: Text(
                                                    product.counter.toString(),style: TextStyle(color: Colors.white),)),
                                            TextButton(
                                                onPressed: () {
                                                  provider.increment(product);
                                                },
                                                child: Icon(Icons.add,color: Colors.white,))
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
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
      ),
    );
  }
}
