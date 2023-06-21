import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/animates_title.dart';
import 'package:shopapp/widgets/price_card.dart';
import 'package:shopapp/widgets/productDescwidget.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findId(productId);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: loadedProduct.title,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 20,
            ),
            Center(
                child: AnimatedProductTitle(
              title: loadedProduct.title,
            )),
            SizedBox(
              height: 20,
            ),
            PriceCard(price: loadedProduct.price),
            SizedBox(
              height: 20,
            ),
            AnimatedDescriptionContainer(
                description: loadedProduct.description),
            SizedBox(
              height: 800,
            )
          ])),
        ],
      ),
    );
  }
}
