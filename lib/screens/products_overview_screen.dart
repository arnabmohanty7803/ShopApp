import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/cart_screen.dart';
import '../widgets/productsGrid.dart';
import '../widgets/badge.dart' as badge;
import '../widgets/app_drawer.dart';

enum FilterValues {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShopApp',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterValues selectedValue) {
              setState(() {
                if (selectedValue == FilterValues.Favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favourites'),
                value: FilterValues.Favourites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterValues.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => badge.Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
              color: Colors.yellowAccent,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: ProductsGrid(_showOnlyFavourites),
            ),
    );
  }
}
