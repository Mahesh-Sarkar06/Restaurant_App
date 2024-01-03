import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_animate/flutter_animate.dart';
import 'package:unicons/unicons.dart';

import 'package:food_ui/Services/precache_service.dart';
import 'package:food_ui/Home/Components/rotate_food.dart';
import 'package:food_ui/const.dart';
import 'package:food_ui/Home/Utils/utils.dart';
import 'package:food_ui/Home/Components/food.dart';
import 'package:food_ui/Home/Providers/transition_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentIndex = 0;
  // Used to control the PageView widget. PageView is used to create a scrollable list of pages.
  late PageController _pageController;

  // Used to initialise the state of the widget for the first time before getting displayed on the screen.
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    // This will be used to faster loading of images from the assets folder
    PreCacheImages.preCacheImages(context);  //precache_service.dart
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // Used to get the logical pixels of the screen to perfectly fit the context within the available screen width
    double width = MediaQuery.of(context).size.width;
    // Used to get the logical pixels of the screen height
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // Control whether the body of scaffold should extends behind the app bar or not. It creates a visual immersive design where content flows behind the app bar by creating transparent or blur app bar.
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Transform(
        // It creates an object of Matrix4.identity() which is an Identity matrix that does not change while transformation. The ..rotateZ(pi/4) denotes a transformation along Z-axis at 45 deg angle. The (..) is the cascade notation which allows multiple operation on same object
        transform: Matrix4.identity()..rotateZ(pi/4),
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff45C37B).withOpacity(0.5),
                offset: const Offset(2, 5),
                blurRadius: 12,
              ),
            ]
          ),
          child: FloatingActionButton(
            mini: true,
            elevation: 0,
            backgroundColor: const Color(0xff45C37B),
            onPressed: () => navigateToDetail(foodList[currentIndex], context), //rotate_food.dart
            child: Transform(
              transform: Matrix4.identity()..rotateZ(-pi/4),
              alignment: Alignment.center,
              child: Icon(
                UniconsLine.arrow_right,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: foodList[currentIndex].textColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          PageView.builder(
            // Preventing the PageView from scrolling
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.vertical,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
              // Used to modify the state of Provider that is associated with notifier. It interacts with providers, read values & trigger changes.
              // Here we are modifying the state to null value using the state property.
              ref.read(textAnimationIndex.notifier).state = null;
            },
            itemBuilder: (context, index) {
              return Container(
                color: foodList[index].colorScheme!.background,
              );
            },
            itemCount: foodList.length,  //const.dart
          ),
          Food(
            foodDetail: foodList[currentIndex],
            pageController: _pageController,
          ),
          Positioned(
            top: height / 2 - (width * 0.88) / 2,
            left: width / 2 - 20,
            child: RotateFood(
              currentIndex: currentIndex,
              width: width,
              pageController: _pageController,
            ),
          )
        ],
      ),
    );
  }
}