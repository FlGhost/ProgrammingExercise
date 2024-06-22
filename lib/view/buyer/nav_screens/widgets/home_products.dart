import 'package:flutter/material.dart';
import 'package:prog_ex_app/view/buyer/productDetail/product_detail_screen.dart';

class HomeProductWidget extends StatelessWidget {
  final String categoryName;

  const HomeProductWidget({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    //mock data list
    final List<Map<String, dynamic>> mockProducts = [
      {
        'productName': 'T-shirt',
        'imageUrl': 'https://pngimg.com/d/dress_shirt_PNG8069.png',
        'productPrice': 19.99,
        'description': 'Comfortable cotton t-shirt in various colors.',
        'sizeList': ['S', 'M', 'L', 'XL'],
        'quantity': 100,
        'vendorId': 'vendor1',
      },
      {
        'productName': 'Running Shoes',
        'imageUrl':
            'https://static.vecteezy.com/system/resources/thumbnails/036/625/143/small_2x/ai-generated-sports-shoes-for-the-future-running-shoes-for-the-future-isolated-on-transparent-background-free-png.png',
        'productPrice': 59.99,
        'description': 'Lightweight running shoes with responsive cushioning.',
        'sizeList': ['US 7', 'US 8', 'US 9', 'US 10'],
        'quantity': 50,
        'vendorId': 'vendor2',
      },
      {
        'productName': 'Backpack',
        'imageUrl':
            'https://atlas-content-cdn.pixelsquid.com/stock-images/open-backpack-RJE7x6B-600.jpg',
        'productPrice': 39.99,
        'description': 'Spacious backpack with multiple compartments.',
        'sizeList': [],
        'quantity': 30,
        'vendorId': 'vendor3',
      },
    ];

    return Container(
      height: 270,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final productData = mockProducts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      productData: productData,
                    ),
                  ));
            },
            child: Card(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 170,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: NetworkImage(productData['imageUrl']),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      productData['productName'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\$' +
                          " " +
                          productData['productPrice'].toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(width: 15),
        itemCount: mockProducts.length,
      ),
    );
  }
}
