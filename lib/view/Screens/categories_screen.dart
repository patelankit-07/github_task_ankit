import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/app_widgets/custom_app_bar.dart';
import 'package:grocery_apps/utils/colors/app_colors.dart';
import 'package:grocery_apps/view/main_layout.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/product_provider.dart';
import 'filterProductsCategory_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: customAppBar(context: context, title: const Text('Category',style: TextStyle(color: white),),centerTitle:true ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8, // Adjusted aspect ratio
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: provider.categoryProducts.length,
                itemBuilder: (context, index) {
                  final product = provider.categoryProducts[index];
                  return GestureDetector(
                    onTap: () {
                      provider.filterProductsCategory(product.category ?? "");
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              FilterProductsCategory(
                                name: product.category ?? "",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.network(
                              "${product.image}",
                              height: 50,
                              width: 50,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${product.category}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                          // Prevent text overflow
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
