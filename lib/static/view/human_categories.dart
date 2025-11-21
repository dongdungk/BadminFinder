import 'package:flutter/material.dart';
import '../viewmodel/local_data.dart';


class HumanCategories extends StatefulWidget {
  const HumanCategories({super.key});

  @override
  State<HumanCategories> createState() => _HumanCategoriesState();
}

class _HumanCategoriesState extends State<HumanCategories> {
  List<bool> pressedButton= [true, false, false];
  List<ElevatedButton> getElevatedButton() { // 버튼생성
    List<String> statCategories = ['연령별', '시간대별', '성별'];
    List<int> buttonColors = [0xff2B7FFF, 0xffFB2C36, 0xffAD46FF, 0xF3F4F6];
    List<ElevatedButton> categoriesButton = [
      ElevatedButton(onPressed: () {
        pressedButton[0] = true;
        pressedButton[1] = false;
        pressedButton[2] = false;
        setState(() {

        });
      },
          style: pressedButton[0] ?
          ElevatedButton.styleFrom(
            backgroundColor: Color(buttonColors[0]),
            foregroundColor: Colors.white,
          ) :
          ElevatedButton.styleFrom(
              backgroundColor: Color(buttonColors[3]),
              foregroundColor: Colors.black,
          ),
          child: Text(statCategories[0]),
      ),
      ElevatedButton(onPressed: () {
        pressedButton[0] = false;
        pressedButton[1] = true;
        pressedButton[2] = false;
        setState(() {

        });
      },
          style: pressedButton[1] ?
          ElevatedButton.styleFrom(
            backgroundColor: Color(buttonColors[1]),
            foregroundColor: Colors.white,
          ) :
          ElevatedButton.styleFrom(
            backgroundColor: Color(buttonColors[3]),
            foregroundColor: Colors.black,
          ),
          child: Text(statCategories[1]),
      ),
      ElevatedButton(onPressed: () {
        pressedButton[0] = false;
        pressedButton[1] = false;
        pressedButton[2] = true;
        setState(() {

        });
      },
          style: pressedButton[2] ?
          ElevatedButton.styleFrom(
            backgroundColor: Color(buttonColors[2]),
            foregroundColor: Colors.white,
          ) :
          ElevatedButton.styleFrom(
            backgroundColor: Color(buttonColors[3]),
            foregroundColor: Colors.black,
          ),
          child: Text(statCategories[2])
      ),
     ];
    return categoriesButton;
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          children: getElevatedButton()
        ),
      );
    }
  }
