import 'package:flutter/material.dart';
import 'human_categories.dart';

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
                          Container(padding: EdgeInsets.only(left: 15, top: 15), child: Image.asset('assets/static/icons/backIcon.png')),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x33000000),
                            offset: const Offset(0, 1.5),
                            blurRadius: 1,
                            spreadRadius: 2
                        ),
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(padding: EdgeInsets.only(top: 10, left: 10, bottom: 5), child: Text('통계 항목 선택', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),),
                      Container(width: double.maxFinite, height: 50, padding: EdgeInsets.all(10),child: HumanCategories())
                    ],
                  ),
                ),

                Container(//**별 이용현황
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x33000000),
                            offset: const Offset(0, 1.5),
                            blurRadius: 1,
                            spreadRadius: 2
                        ),
                      ]
                  ),
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

