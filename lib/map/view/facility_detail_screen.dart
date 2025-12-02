import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '/map/model/facility_model.dart';
import '/map/viewmodel/facility_detail_viewmodel.dart';

class FacilityDetailScreen extends StatefulWidget {
  final String facilityId;

  const FacilityDetailScreen({
    super.key,
    required this.facilityId,
  });

  @override
  State<FacilityDetailScreen> createState() => _FacilityDetailScreenState();
}

class _FacilityDetailScreenState extends State<FacilityDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // ⭐️ [필수] ViewModel을 읽어와 시설 정보 로드 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FacilityDetailViewModel>().loadFacility(widget.facilityId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ⭐️ ViewModel 구독 및 데이터 가져오기
    final viewModel = context.watch<FacilityDetailViewModel>();
    final FacilityModel? facility = viewModel.facility;

    return Scaffold(
      appBar: AppBar(
        // ⭐️ Appbar 제목: ViewModel에서 직접 facility.name 사용
        title: Text(facility?.name ?? '로딩 중...'),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : facility == null
          ? const Center(child: Text('시설 정보를 불러오는 데 실패했습니다.'))
          : _buildContentLoaded(context, facility), // 로딩 완료 시 컨텐츠 표시
    );
  }

  Widget _buildContentLoaded(BuildContext context, FacilityModel facility) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. 이미지 슬라이더 (PageView.builder로 변경)
          _buildImageSlider(context, facility.images), // ⭐️ context 전달

          // 2. 탭 바 (탭 클릭 시 라우팅)
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              _buildTab('정보'),
              _buildTab('리뷰'),
              _buildTab('사진'),
            ],
            onTap: (index) {
              // ⭐️ 탭 클릭 시 해당 경로로 이동 후 탭을 '정보'로 다시 돌림
              if (index == 1) {
                // '리뷰' 탭
                context.push('/facility/${widget.facilityId}/reviews');
              } else if (index == 2) {
                // '사진' 탭
                context.push('/facility/${widget.facilityId}/photos');
              }
              _tabController.animateTo(0); // 현재 탭을 다시 정보 탭으로 되돌림
            },
          ),

          // 3. 정보 탭 컨텐츠
          _buildInfoTabContent(facility),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------
  // 헬퍼 위젯들
  // -----------------------------------------------------------------

  // ⭐️⭐️⭐️ [핵심 수정] _buildImageSlider 함수 (PageView.builder 사용) ⭐️⭐️⭐️
  Widget _buildImageSlider(BuildContext context, List<String> images) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (images.isEmpty) {
      return Container(
        height: screenWidth * 0.7, // 높이를 화면 너비에 맞춰 설정
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: Icon(Icons.image_not_supported_outlined, color: Colors.grey[400], size: 50),
      );
    }

    // ⭐️ PageView.builder를 사용하여 스와이프 가능한 슬라이더 구현
    return Container(
      height: screenWidth * 0.7, // 높이를 화면 너비의 70%로 설정
      width: screenWidth, // 너비를 화면 가득 채움
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록 설정
            width: screenWidth, // Image 자체도 너비를 꽉 채우도록 설정
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.error_outline, color: Colors.grey),
              );
            },
          );
        },
      ),
    );
  }
  // ⭐️⭐️⭐️ ----------------------------------------------------------- ⭐️⭐️⭐️

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoTabContent(FacilityModel facility) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // (이름, 평점, 주소 등은 모두 동일)
          Text(
            facility.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(facility.rating.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text('(${facility.reviewCount} 리뷰)',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          _buildInfoRow(
            Icons.location_on_outlined,
            '주소',
            facility.address,
            trailingWidget: TextButton(
              child: const Text('복사'),
              onPressed: () {/* TODO */},
            ),
          ),
          _buildInfoRow(
            Icons.access_time_outlined,
            '운영시간',
            facility.hours,
          ),
          _buildInfoRow(
            Icons.call_outlined,
            '전화번호',
            facility.phone,
            trailingWidget: TextButton(
              child: const Text('전화'),
              onPressed: () {/* TODO */},
            ),
          ),
          _buildInfoRow(
            Icons.info_outline,
            '시설정보',
            '${facility.category}입니다. ${facility.price}. 현재 ${facility.status}이며, ${facility.reservation} 상태입니다.',
          ),
          const SizedBox(height: 24),
          const Text(
            '시설 현황',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('현재 "${facility.status}"입니다.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: facility.status == '운영중'
                            ? Colors.green
                            : Colors.orange)),
                const SizedBox(height: 8),

                // 모델 데이터 사용 (현재 인원/정원)
                Text(
                  '약 ${facility.currentOccupancy}명 (${facility.maxCapacity}명 정원)',
                  style: const TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content,
      {Widget? trailingWidget}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 22),
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (trailingWidget != null) trailingWidget,
        ],
      ),
    );
  }
}