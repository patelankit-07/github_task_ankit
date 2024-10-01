import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_apps/view/main_layout.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/product_provider.dart';
import '../../utils/app_widgets/custom_app_bar.dart';
import '../../utils/colors/app_colors.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: customAppBar(context: context, title: const Text('Cart',style: TextStyle(color: white),),centerTitle:true ),

      body: Consumer<ProductProvider>(
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
                    provider.filterProductsCategory(product.category ?? "");
                    Navigator.push(
                      context,
                     MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),

                      ),
                    );
                  },
                  child: Hero(
                    tag: "${product.id}",
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                      ),                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            "${product.image}",
                            fit: BoxFit.cover,
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
    );
  }
}