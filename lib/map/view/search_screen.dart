import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ⭐️ 1. [수정] go_router 패키지를 import 합니다.
import 'package:go_router/go_router.dart';

import 'package:victor/map/view/facility_detail_screen.dart';
import 'package:victor/map/model/facility_model.dart';
import 'package:victor/map/viewmodel/search_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,

      // 1. 상단 앱 바 (AppBar)
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: '시설 검색 (예: 광진, 송파, 성북, 동작)',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
          ),
          onSubmitted: (String query) {
            context.read<SearchViewModel>().searchFacilities(query);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black),
            onPressed: () {
              // ⭐️ 2. [수정] Navigator.pushNamed -> context.push
              // '/favorites' 경로는 '홈' 탭의 하위 경로이므로
              // 탭 바가 유지된 채로 화면이 전환됩니다. (정상)
              context.push('/favorites');
            },
          ),
        ],
      ),

      // 2. 메인 컨텐츠
      body: Column(
        // ... (이하 Column 내용은 동일) ...
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              '특정시설 검색 목록',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Consumer<SearchViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (viewModel.facilities.isEmpty) {
                  return const Center(
                    child: Text(
                      '검색 결과가 없습니다. (예: 광진, 송파)',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: viewModel.facilities.length,
                  itemBuilder: (context, index) {
                    final facility = viewModel.facilities[index];
                    return _buildFacilityResultCard(context, facility);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityResultCard(
      BuildContext context, FacilityModel facility) {

    // ... (이하 색상 로직은 동일) ...
    Color statusColor;
    switch (facility.status) {
      case '운영중': statusColor = Colors.green; break;
      case '휴무': statusColor = Colors.orange; break;
      default: statusColor = Colors.red;
    }
    Color reservationColor;
    // ... (이하 동일) ...
    switch (facility.reservation) {
      case '예약 가능': reservationColor = Colors.blue; break;
      case '예약 불가': reservationColor = Colors.grey; break;
      default: reservationColor = Colors.purple;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          // ⭐️ 3. [수정] Navigator.of(context, rootNavigator: true).push(...)
          //    -> context.push(...)
          // 1단계에서 정의한 최상위 경로('/facility/:id')로 이동합니다.
          // 이 경로는 셸 바깥에 있으므로 하단 탭 바를 덮고 나옵니다.
          context.push('/facility/${facility.id}');
        },
        child: Padding(
          // ... (이하 카드 내부는 모두 동일) ...
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      facility.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    facility.distance,
                    style: const TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                facility.address,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(child: Text(facility.hours, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.payment, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(facility.price, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 12),
                  const Icon(Icons.call_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(facility.phone, style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(facility.reservation),
                    backgroundColor: reservationColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: reservationColor, fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(facility.status),
                    backgroundColor: statusColor.withOpacity(0.1),
                    labelStyle: TextStyle(color: statusColor, fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}