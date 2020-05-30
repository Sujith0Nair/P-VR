import 'package:flutter/material.dart';
import 'about.dart';
import 'home.dart';
import 'styles.dart';
import 'tutorial.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List screens = [HomeScreen(), Tutorial(), About()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundgColor,
      body: screens[_selectedIndex],
      bottomNavigationBar: AnimatedBottomBar(
          barItems: [
            BarItem(
              text: "Home",
              iconData: Icons.home,
              color: Colors.indigo,
            ),
            BarItem(
              text: "FAQs",
              iconData: Icons.school,
              color: Colors.teal,
            ),
            BarItem(
              text: "About",
              iconData: Icons.developer_board,
              color: Colors.yellow.shade900,
            ),
          ],
          animationDuration: const Duration(milliseconds: 100),
          barStyle: BarStyle(fontSize: 20.0, iconSize: 30.0),
          onBarTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onBarTap;
  final BarStyle barStyle;

  AnimatedBottomBar(
      {this.barItems,
      this.animationDuration = const Duration(milliseconds: 500),
      this.onBarTap,
      this.barStyle});

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
          top: 10.0,
          left: 10.0,
          right: 10.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          duration: widget.animationDuration,
          decoration: BoxDecoration(
              color: isSelected
                  ? item.color.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(
            children: <Widget>[
              Icon(
                item.iconData,
                color: isSelected ? item.color : Colors.black,
                size: widget.barStyle.iconSize,
              ),
              SizedBox(
                width: 10.0,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                vsync: this,
                child: Text(
                  isSelected ? item.text : "",
                  style: TextStyle(
                      color: item.color,
                      fontWeight: widget.barStyle.fontWeight,
                      fontSize: widget.barStyle.fontSize),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }
}

class BarStyle {
  final double fontSize, iconSize;
  final FontWeight fontWeight;

  BarStyle(
      {this.fontSize = 12.0,
      this.iconSize = 26,
      this.fontWeight = FontWeight.w600});
}

class BarItem {
  String text;
  IconData iconData;
  Color color;

  BarItem({this.text, this.iconData, this.color});
}
