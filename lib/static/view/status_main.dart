import 'package:flutter/material.dart';



class StatusMainPage extends StatelessWidget {
  const StatusMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(child: Column(
          children: [
            // Container(
            //     width: double.maxFinite,
            //     height: 50,
            //     child: Status_Tabbar()
            // ),
            Container(
              decoration: BoxDecoration(
                  color:Color(0xffD9D9D9),
                  border: Border.all(width: 0, color: Color(0xffD9D9D9),),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              margin: EdgeInsets.fromLTRB(20, 8, 20, 8),
              width: double.maxFinite,
              height: 40,
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    top:  11,
                    child: Image(
                      image: AssetImage('assets/icons/searchIcon.png'),
                    ),
                  ),
                  Positioned(
                    left: 50,
                    top: -3,
                    child: Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: TextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(hintText: '검색창 : '),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 10,
              children: [
                Container(
                decoration: BoxDecoration(
                    color:Color(0xffF9FAFB),
                    border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('강남구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('강동구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('강북구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('강서구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('관악구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('광진구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('구로구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('금천구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('노원구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('도봉구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('동대문구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('동작구',style: TextStyle(fontSize: 16),),
                ),
                Container(
                  decoration: BoxDecoration(
                      color:Color(0xffF9FAFB),
                      border: Border.all(width: 0, color: Color(0xffE5E7EB),),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(left: 20, top: 8),
                  width: double.maxFinite,
                  height: 40,
                  child: Text('마포구',style: TextStyle(fontSize: 16),),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
