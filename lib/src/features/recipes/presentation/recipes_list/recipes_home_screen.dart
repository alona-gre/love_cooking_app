import 'package:love_cooking_app/src/common_widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:love_cooking_app/src/common_widgets/responsive_center.dart';
import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/features/recipes/presentation/recipes_list/recipes_carousel.dart';

/// Shows the list of products with a search field at the top.
class RecipesHomeScreen extends StatefulWidget {
  const RecipesHomeScreen({super.key});

  @override
  State<RecipesHomeScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<RecipesHomeScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const HomeAppBar(),
      //drawer: DrawerMenu,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // TODO: SEarch
          // const ResponsiveSliverCenter(
          //   padding: EdgeInsets.all(Sizes.p16),
          //   child: ProductsSearchTextField(),
          // ),
          ResponsiveSliverCenter(
            padding: const EdgeInsets.all(Sizes.p16),
            maxContentWidth: screenWidth,
            child: const RecipesCarousel(),
          ),
        ],
      ),
    );
  }
}
