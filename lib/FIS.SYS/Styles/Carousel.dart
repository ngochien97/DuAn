import 'package:flutter/material.dart';

class FCarousel extends StatelessWidget {
  final FSlideShow slideShow;
  final FGridSpace gridSpace;
  final List<Widget> children;

  const FCarousel({
    @required this.children,
    @required this.slideShow,
    this.gridSpace = FGridSpace.large,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final standartWidth = (screenWidth - 2 * gridSpace.value * 2) * 0.9;
    final elementWidth =
        (standartWidth - slideShow.getGridSpaceNumbers * gridSpace.value * 2) *
            slideShow.getPercentWidthValue;

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var element in children)
              Container(
                margin: EdgeInsets.only(
                  left: element == children.first
                      ? gridSpace.value * 2
                      : gridSpace.value,
                  right: element == children.last
                      ? gridSpace.value * 2
                      : gridSpace.value,
                ),
                width: elementWidth,
                child: element,
              )
          ],
        ),
      ),
    );
  }
}

enum FSlideShow {
  oneAndAHalf,
  twoAndAHalf,
  threeAndAHalf,
  fourAndAHalf,
}

extension FSlideShowExtension on FSlideShow {
  static const widthValues = {
    FSlideShow.oneAndAHalf: 1.0,
    FSlideShow.twoAndAHalf: 0.5,
    FSlideShow.threeAndAHalf: 1 / 3,
    FSlideShow.fourAndAHalf: 0.25,
  };

  double get getPercentWidthValue => widthValues[this];

  static const gridSpaceNumbers = {
    FSlideShow.oneAndAHalf: 0,
    FSlideShow.twoAndAHalf: 1,
    FSlideShow.threeAndAHalf: 2,
    FSlideShow.fourAndAHalf: 3,
  };

  int get getGridSpaceNumbers => gridSpaceNumbers[this];
}

enum FGridSpace {
  xSmall,
  small,
  medium,
  large,
  xLarge,
}

extension FGridSpaceExtension on FGridSpace {
  static const spaceValues = {
    FGridSpace.xSmall: 2.0,
    FGridSpace.small: 4.0,
    FGridSpace.medium: 6.0,
    FGridSpace.large: 8.0,
    FGridSpace.xLarge: 10.0,
  };

  double get value => spaceValues[this];
}
