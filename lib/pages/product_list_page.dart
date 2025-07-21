import 'dart:convert';                                 // 🟦 AssetManifest 파싱
import 'package:flutter/services.dart';               // 🟦 rootBundle 사용
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 🟣 SharedPreferences: 찜 상태 로컬 저장용
import '../models/poster.dart';                       // 🟣 데이터 모델 정의
import '../widgets/product_list_card.dart';           // 🟢 카드 UI 위젯
import '../widgets/product_info_box.dart';            // 🟢 하단 정보 박스 위젯

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController();
  final List<Poster> _displayItems = [];              // 🟢 화면에 표시 중인 상품 데이터
  final Set<String> _favoriteNames = {};              // 🟦 찜한 상품 이름 집합
  bool _isLoading = false, _allLoaded = false;        // 🟢 로딩 상태, 모두 로드 여부
  int _nextPage = 0;                                  // 🟢 다음 페이지 인덱스
  static const int _pageSize = 10;                    // 🟢 페이지당 아이템 수

  List<String> _allImagePaths = [];                   // 🟦 AssetManifest에서 가져온 모든 이미지 경로

  @override
  void initState() {
    super.initState();
    _loadImagePaths().then((_) => _initData());       // 🟦 에셋 경로 로드 후 초기 데이터 로드
    _scrollController.addListener(_onScroll);         // 🟣 스크롤 리스너 등록
  }

  /// 🟦 AssetManifest.json에서 assets/images/ 하위 경로만 추출
  Future<void> _loadImagePaths() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestJson);
    _allImagePaths = manifestMap.keys
        .where((path) => path.startsWith('assets/images/'))
        .toList()
      ..sort();
  }

  /// 🟢 SharedPreferences에서 찜 목록을 불러온 뒤 첫 페이지 로드
  Future<void> _initData() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    _favoriteNames.addAll(favList);
    _loadMore();
  }

  /// 🟢 스크롤 끝 근처에서 다음 페이지 로드
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        !_allLoaded) {
      _loadMore();
    }
  }

  /// 🟦 페이지 단위로 이미지 경로를 Poster 객체로 생성해 화면에 추가
  Future<void> _loadMore() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final start = _nextPage * _pageSize;
    final end = (_nextPage + 1) * _pageSize;

    if (start >= _allImagePaths.length) {
      _allLoaded = true;
    } else {
      final slice = _allImagePaths.sublist(
        start,
        end > _allImagePaths.length ? _allImagePaths.length : end,
      );
      for (var idx = 0; idx < slice.length; idx++) {
        final i = start + idx + 1;
        _displayItems.add(Poster(
          name: 'Animal Poster $i',
          price: i % 5 == 0 ? 0 : 10000 + i * 3000,
          description: '간단 설명',
          imagePath: slice[idx],                   // 🟦 루트 번들에서 가져온 경로 사용
          date: DateTime.now(),
        )..isFavorite = _favoriteNames.contains('Animal Poster $i'));
      }
      _nextPage++;
      if (_displayItems.length >= _allImagePaths.length) {
        _allLoaded = true;
      }
    }

    if (_allLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('마지막 상품입니다.'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }

    setState(() => _isLoading = false);
  }

  /// 🟢 찜 상태 토글 & SharedPreferences에 저장
  Future<void> _toggleFavorite(Poster item) async {
    setState(() => item.isFavorite = !item.isFavorite);
    if (item.isFavorite) {
      _favoriteNames.add(item.name);
    } else {
      _favoriteNames.remove(item.name);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteNames.toList());
  }

  @override
  void dispose() {
    _scrollController.dispose();                    // 🟢 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🟢 아직 로드된 상품이 없다면 로딩 인디케이터 표시
    if (_displayItems.isEmpty && !_allLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,                // 🟢 페이지 배경색
      body: Column(
        children: [
          // 🟢 AppBar 없이 로고만 담긴 상단 박스
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, 30),
                child: Image.asset('assets/logo.png', height: 40), // 🟢 로고
              ),
            ),
          ),
          // 🟢 로고 아래에 search & cart 아이콘
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Image.asset('assets/icons/cart.png', width: 30, height: 24), // 🟢 장바구니
                  onPressed: () => Navigator.pushNamed(context, '/my_cart_page'),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Image.asset('assets/icons/search.png', width: 23, height: 23), // 🟢 검색
                  onPressed: () => Navigator.pushNamed(context, '/item_search_page'),
                ),
              ],
            ),
          ),

          // 🟣 ListView.builder를 Expanded로 감싸서 2열 배치
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8),       // 🟢 전체 패딩
              itemCount: (_displayItems.length / 2).ceil(),
              itemBuilder: (context, rowIndex) {
                final left = _displayItems[rowIndex * 2];
                final rightIndex = rowIndex * 2 + 1;
                final hasRight = rightIndex < _displayItems.length;
                final right = hasRight ? _displayItems[rightIndex] : null;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20), // 🟢 행 간격
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🟢 왼쪽 카드 + 정보 박스
                      Expanded(
                        child: Column(
                          children: [
                            ProductListCard(
                              item: left,
                              onFavoriteToggle: () => _toggleFavorite(left),
                            ),
                            const SizedBox(height: 8),
                            ProductInfoBox(
                              name: left.name,
                              price: left.price,
                            ),
                          ],
                        ),
                      ),
                      if (hasRight) ...[
                        const SizedBox(width: 8),
                        // 🟢 오른쪽 카드 + 정보 박스
                        Expanded(
                          child: Column(
                            children: [
                              ProductListCard(
                                item: right!,
                                onFavoriteToggle: () => _toggleFavorite(right),
                              ),
                              const SizedBox(height: 8),
                              ProductInfoBox(
                                name: right.name,
                                price: right.price,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/item_add_page'),
        child: Image.asset(
          'assets/icons/add.png',                 // 🟢 플로팅 + 아이콘
          width: 66,
          height: 66,
        ),
      ),
    );
  }
}
