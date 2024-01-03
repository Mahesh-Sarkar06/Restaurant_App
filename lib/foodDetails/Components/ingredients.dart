import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class Ingredients extends StatelessWidget {
  final List<String> ingredients;
  final AnimationController animationController;
  final Color textColor;

  const Ingredients({
    super.key,
    required this.animationController,
    required this.textColor,
    required this.ingredients
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        // Return a combination of ListTile widget & checkbox
        // It uses adaptive constructor that adapt its appearance based on the running platform (iOS, Android)
        return CheckboxListTile.adaptive(
            //boolean value to determine if checkbox is checked or not
            value: false,
            //Alignment of checkbox wrt the title or subtitle. Can be leading or trailing
            controlAffinity: ListTileControlAffinity.leading,
            // Callback func that get triggered on the state change.
            onChanged: (val) {},
            // Primary content of ListTile
            title: Text(
              ingredients[index],
              style: TextStyle(color: textColor),
            ),
        )
            .animate(controller: animationController)
            .then(delay: Duration(milliseconds: 300 + index * 50))
            .slideY(
              begin: 1.4,
              end: 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack
            );
      },
      itemCount: ingredients.length,
    );
  }
}