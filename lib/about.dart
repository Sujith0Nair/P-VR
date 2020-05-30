import 'package:flutter/material.dart';
import 'radialbar.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Text("Developers", style: AppTheme.display1),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: CharacterWidget(index: 0),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: CharacterWidget(index: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterWidget extends StatelessWidget {
  final int index;
  CharacterWidget({this.index});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, _, __) =>
                    CharacterDetailScreen(character: characters[index])));
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Hero(
              tag: "background-${characters[index].name}",
              child: Container(
                height: 0.6 * screenHeight,
                width: 0.9 * screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: characters[index].colors,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.5),
            child: Hero(
              tag: "image-${characters[index].name}",
              child: CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(
                  characters[index].imagePath,
              ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: "name-${characters[index].name}",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: Text(
                        characters[index].name,
                        style: AppTheme.heading,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Tap to Read more",
                  style: AppTheme.subHeading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppTheme {
  static const TextStyle display1 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black,
    fontSize: 38,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: 'WorkSans',
    color: Colors.black,
    fontSize: 32,
    fontWeight: FontWeight.normal,
    letterSpacing: 1.1,
  );

  static final TextStyle heading = TextStyle(
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w900,
    fontSize: 34,
    color: Colors.white.withOpacity(0.8),
    letterSpacing: 1.2,
  );

  static final TextStyle subHeading = TextStyle(
    inherit: true,
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: Colors.white.withOpacity(0.8),
  );
}

class Character {
  final String name;
  final String imagePath;
  final String description;
  final List<Color> colors;

  Character({this.name, this.imagePath, this.description, this.colors});
}

List characters = [
  Character(
      name: "Sujith",
      imagePath: "assets/images/sujith.png",
      description: "I'm a Gameplay Programmer and Tech Enthusiast \nGaming and writing are my hobbies. This app is a combined effort of creative freedom and hardwork to make it seem easy to use and being flexible at the same time \nFlutter made this possible. Thanks to Google for developing such a wonderful framework and our staff for their support!",
      colors: [Colors.orange.shade200, Colors.deepOrange.shade400]),
  Character(
      name: "Srinivas",
      imagePath: "assets/images/srinivas.jpg",
      description:
          "Agnes Gru it is one of Gru and Lucy's three adopted daughters, alongside her sisters Margo and Edith. She is the youngest child of the three sisters. She greatly adores unicorns, as shown on various occasions. Agnes is a little girl with dark brown eyes. Her long black hair is tied in an upwards ponytail with a red scrunchie. Most of the time, Agnes wears blue overalls over a yellow and brown striped t-shirt, and white sneakers with yellow socks. She also wears a white ballet outfit like Edith and Margo (at the ballet recital). For pajamas, Agnes wears a long blue nightshirt covered with teddy bears and polar bear slippers; her hair stays the same. On her birthday, Agnes is wearing a dress that resembles a princess riding a unicorn. The colors are similar to her regular outfit. She also wears a blue princess hat on her head.",
      colors: [Colors.pink.shade200, Colors.redAccent.shade400]),
];

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({Key key, this.character}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-${characters[0].name}",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.character.colors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-${characters[0].name}",
                      child: Image.asset(widget.character.imagePath,
                          height: screenHeight * 0.45)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                      tag: "name-${characters[0].name}",
                      child: Material(
                          color: Colors.transparent,
                          child: Container(
                              child: Text(widget.character.name,
                                  style: AppTheme.heading)))),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(widget.character.description,
                      style: AppTheme.subHeading),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
