import 'package:flutter/material.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/category_screen.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/home_products.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/main_product_widget.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  //mock
  final List<String> mockCategories = [
    'Electronics',
    'Clothing',
    'Books',
    'Sports'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mockCategories.length,
              itemBuilder: (context, index) {
                final category = mockCategories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 120,
                    child: ActionChip(
                      backgroundColor: Colors.lightBlue,
                      onPressed: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                        print(_selectedCategory);
                      },
                      label: Center(
                        child: Text(
                          category,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CategoryScreen();
                    }));
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
          if (_selectedCategory == null) MainProductWidget(),
          if (_selectedCategory != null)
            Expanded(child: HomeProductWidget(categoryName: _selectedCategory!))
        ],
      ),
    );
  }
}
