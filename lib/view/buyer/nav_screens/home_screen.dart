import 'package:flutter/material.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/banner_widget.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/category_text.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/search_input_widget.dart';
import 'package:prog_ex_app/view/buyer/nav_screens/widgets/welcom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SizedBox(
            height: 14,
          ),
          SearchInputWidget(),
          BannerWidget(),
          CategoryText(),
        ],
      ),
    );
  }
}
