import 'package:flutter/material.dart';

enum PeopleStatus{age, time, gender}

class FacilitiesStatusPage extends StatelessWidget { //시설분석통계창
  const FacilitiesStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE6E7EB),
        body: SafeArea(
            child: Column(
              children: [
                Container( //시설분석으로 돌아가기
                  color: Color(0xFFFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          //Container(padding: EdgeInsets.only(left: 15), child: ),
                          Container(padding: EdgeInsets.only(left: 15, top: 15), child: Text('시설분석으로 돌아가기', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),),
                        ],
                      ),
                      Container(padding: EdgeInsets.only(left: 15, top: 5), child: Text('양천구민 체육센터', style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),),
                      Container(padding: EdgeInsets.only(left: 15, bottom: 15), child: Text(' - 시설 통계 분석', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),),

                    ],
                  ),
                ),
                Container(//통계 항목 선택

                  margin: EdgeInsets.all(15),
                  color: Color(0xFFFFFFFF),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(padding: EdgeInsets.all(5), child: Text('통계 항목 선택', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),),
                      Row(
                        children: [
                          TextButton(onPressed: (){}, child: Text('연령별', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),),),
                          TextButton(onPressed: (){}, child: Text('시간대별', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),),),
                          TextButton(onPressed: (){}, child: Text('성별', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),),),


                        ],
                      )
                    ],
                  ),


                ),

                Container(//**별 이용현황

                  margin: EdgeInsets.all(15),
                  color: Color(0xFFFFFFFF),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(padding: EdgeInsets.only(left: 15, top: 15), child: Text('연령별 이용현황', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),),
                      Container(),
                      Container(margin: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(child: Container(color: Color(0xffF9FAFB),padding: EdgeInsets.all(5),margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('10대'), Text('45%')],),),),
                              Expanded(child: Container(color: Color(0xffF9FAFB), padding: EdgeInsets.all(5), margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('20대'), Text('75%')],),),),
                            ],),
                            Row(children: [
                              Expanded(child: Container(color: Color(0xffF9FAFB),padding: EdgeInsets.all(5),margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('30대'), Text('92%')],),),),
                              Expanded(child: Container(color: Color(0xffF9FAFB), padding: EdgeInsets.all(5), margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('40대'), Text('85%')],),),),
                            ],),
                            Row(children: [
                              Expanded(child: Container(color: Color(0xffF9FAFB),padding: EdgeInsets.all(5),margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('50대'), Text('68%')],),),),
                              Expanded(child: Container(color: Color(0xffF9FAFB), padding: EdgeInsets.all(5), margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('60대'), Text('42%')],),),),
                            ],),
                            Row(children: [
                              Expanded(child: Container(color: Color(0xffF9FAFB),padding: EdgeInsets.all(5),margin: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text('70대'), Text('28%')],),),),
                              Expanded(child: Container(),),
                            ],),
                          ],),
                      )
                    ],
                  ),

                ),
              ],
            )
        )
    );


  }
}

