import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:food_ui/foodDetails/Components/ingredients.dart';
import 'package:food_ui/foodDetails/Components/methods.dart';

class RecipeTab extends StatefulWidget {
  final List<String> ingredients;
  final AnimationController controller;
  final Color textColor;

  const RecipeTab({
    super.key,
    required this.controller,
    required this.ingredients,
    required this.textColor,
  });

  @override
  State<RecipeTab> createState() => _RecipeTabState();
}

// TickerProviderStateMixin provides a way to create & manage animation controllers within a State class
class _RecipeTabState extends State<RecipeTab> with TickerProviderStateMixin {
  // To manage the state of tab bar, will use TabController
  late TabController _tabController;

  @override
  void initState() {
    // vsync: this, use the current State as the TickerProvider
    // length: 2, shows the number of tabs to be managed
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          indicatorColor: const Color(0xff45C37B),
          unselectedLabelColor: Colors.grey.withOpacity(0.75),
          labelColor: widget.textColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          controller: _tabController,
          tabs: const[
            Tab(text: "INGREDIENTS"),
            Tab(text: "METHOD"),
          ],
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
            children: [
              Ingredients(
                ingredients: widget.ingredients,
                textColor: widget.textColor,
                animationController: widget.controller
              ),
              const Methods(),
            ],
          ),
        )
      ],
    )
    .animate(controller: widget.controller)
    .slideY(begin: 1, end: 0, curve: Curves.easeIn);
  }
}