import 'package:flutter/material.dart';

class ListColors extends StatefulWidget {
  final void Function(Color) onSelected;
  final Color selectedColor;
  const ListColors({
    super.key,
    required this.onSelected,
    required this.selectedColor,
  });

  @override
  State<ListColors> createState() => _ListColorsState();
}

class _ListColorsState extends State<ListColors> {
  late List<Color> colorList;

  @override
  initState() {
    super.initState();
    colorList = [
      Colors.black,
      Colors.blue,
      Colors.brown,
      Colors.pink,
      Colors.red,
      Colors.green,
      Colors.yellow,
    ];
  }

  Widget colorBox(Color color) {
    return GestureDetector(
      onTap: () => widget.onSelected(color),
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(right: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2),
          color: color,
        ),
        child: color == widget.selectedColor
            ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ...colorList.map(
            (color) => colorBox(color),
          ),
        ],
      ),
    );
  }
}