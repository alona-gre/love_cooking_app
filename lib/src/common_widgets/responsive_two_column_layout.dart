import 'package:love_cooking_app/src/constants/app_sizes.dart';
import 'package:love_cooking_app/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

/// Responsive layout that shows two child widgets side by side if there is
/// enough space, or vertically stacked if there is not enough space.
class ResponsiveTwoColumnLayout extends StatelessWidget {
  const ResponsiveTwoColumnLayout({
    super.key,
    required this.startContent,
    required this.endContent,
    this.startFlex = 1,
    this.endFlex = 1,
    this.breakpoint = Breakpoint.tablet,
    required this.spacing,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnCrossAxisAlignment = CrossAxisAlignment.stretch,
  });
  final Widget startContent;
  final Widget endContent;
  final int startFlex;
  final int endFlex;
  final double breakpoint;
  final double spacing;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= breakpoint) {
        return Row(
          mainAxisAlignment: rowMainAxisAlignment,
          crossAxisAlignment: rowCrossAxisAlignment,
          children: [
            Flexible(flex: startFlex, child: startContent),
            SizedBox(width: spacing),
            Flexible(flex: endFlex, child: endContent),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: columnMainAxisAlignment,
          crossAxisAlignment: columnCrossAxisAlignment,
          children: [
            startContent,
            SizedBox(height: spacing),
            endContent,
          ],
        );
      }
    });
  }
}

/// Responsive layout that shows two child widgets side by side if there is
/// enough space, or vertically stacked if there is not enough space.
class ResponsiveTwoColumnLayoutWithSwitch extends StatefulWidget {
  const ResponsiveTwoColumnLayoutWithSwitch({
    super.key,
    required this.startContent,
    required this.endContent,
    this.startFlex = 1,
    this.endFlex = 1,
    this.breakpoint = Breakpoint.tablet,
    required this.spacing,
    this.rowMainAxisAlignment = MainAxisAlignment.start,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.columnMainAxisAlignment = MainAxisAlignment.start,
    this.columnCrossAxisAlignment = CrossAxisAlignment.stretch,
  });
  final Widget startContent;
  final Widget endContent;
  final int startFlex;
  final int endFlex;
  final double breakpoint;
  final double spacing;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final MainAxisAlignment columnMainAxisAlignment;
  final CrossAxisAlignment columnCrossAxisAlignment;

  @override
  State<ResponsiveTwoColumnLayoutWithSwitch> createState() =>
      _ResponsiveTwoColumnLayoutWithSwitchState();
}

class _ResponsiveTwoColumnLayoutWithSwitchState
    extends State<ResponsiveTwoColumnLayoutWithSwitch> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= widget.breakpoint) {
        return Row(
          mainAxisAlignment: widget.rowMainAxisAlignment,
          crossAxisAlignment: widget.rowCrossAxisAlignment,
          children: [
            Flexible(flex: widget.startFlex, child: widget.startContent),
            SizedBox(width: widget.spacing),
            Flexible(flex: widget.endFlex, child: widget.endContent),
          ],
        );
      } else {
        return Column(
          mainAxisAlignment: widget.columnMainAxisAlignment,
          crossAxisAlignment: widget.columnCrossAxisAlignment,
          children: [
            gapH16,
            Center(
              child: ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Ingredients'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Method'),
                  ),
                ],
              ),
            ),
            isSelected[0] == true ? widget.startContent : widget.endContent,
          ],
        );
      }
    });
  }
}
