import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class DefaultBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemSelected;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const DefaultBottomNavBar(
      {super.key,
        required this.selectedIndex,
        required this.onItemSelected,
        this.selectedItemColor = Colors.blue,
        this.unselectedItemColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: BottomNavyBar(
        backgroundColor: Colors.grey[200],
        selectedIndex: selectedIndex,
        onItemSelected: onItemSelected,
        containerHeight: 70,
        iconSize: 30.0,
        items: [
          BottomNavyBarItem(
              inactiveColor: unselectedItemColor,
              activeColor: selectedItemColor!,
              icon: const Icon(
                Icons.text_fields_outlined,
              ),
              title: const Text(
                'Tasks',
              ),
              textAlign: TextAlign.center),
          BottomNavyBarItem(
            inactiveColor: unselectedItemColor,
            activeColor: selectedItemColor!,
            icon: const Icon(
              Icons.check_circle_outline,
            ),
            title: const Text('Done', textAlign: TextAlign.center),
          ),
          BottomNavyBarItem(
            inactiveColor: unselectedItemColor,
            activeColor: selectedItemColor!,
            icon: const Icon(
              Icons.archive_outlined,
            ),
            title: const Text('Archived', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
