import 'package:flutter/material.dart';
import 'package:frontend_flutter/assets/colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: PrimaryColor,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: BottomIcon(path: "icons/compass_icon.png"),
                onPressed: () {}),
            IconButton(
                icon: BottomIcon(path: "icons/bookmark_icon.png"),
                onPressed: () {}),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            IconButton(
                icon: BottomIcon(path: "icons/bell_icon.png"),
                onPressed: () {}),
            IconButton(
                icon: BottomIcon(path: "icons/user_icon.png"),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  final String path;

  const BottomIcon({required this.path});

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: null),
      child: Image(
        image: AssetImage(path),
        width: MediaQuery.of(context).size.height * 0.05,
        height: MediaQuery.of(context).size.height * 0.05,
        color: Colors.white,
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
      ),
    );
  }
}
