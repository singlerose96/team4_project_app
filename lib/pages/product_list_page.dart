import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 🟣 SharedPreferences 패키지: 찜 상태 로컬 저장용
import '../models/product_item.dart';                      // 🟣 데이터 모델 정의
import '../widgets/product_list_card.dart';               // 🟢 카드 UI 위젯
import '../widgets/product_info_box.dart';                // 🟢 하단 정보 박스 위젯

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // 🟣 스크롤 페이징용 컨트롤러
  final ScrollController _scrollController = ScrollController();
  // 🟣 전체 상품 데이터
  final List<ProductItem> _allItems = [];
  // 🟣 현재 화면에 표시 중인 상품 데이터
  final List<ProductItem> _displayItems = [];
  // 🟣 로딩 플래그: 추가 로딩 중 표시 제어
  bool _isLoading = false, _allLoaded = false;
  // 🟣 현재 페이지 인덱스
  int _nextPage = 0;
  // 🟣 페이지당 아이템 수
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _initData();                               // 🟣 초기 데이터 로드
    _scrollController.addListener(_onScroll);  // 🟣 스크롤 리스너 등록
  }

  /// 🟣 앱 시작 시 전체 데이터 생성, 찜 상태 복원, 첫 페이지 로드
  Future<void> _initData() async {
    _loadAllItems();
    await _loadFavorites();
    _loadMore();
  }

  /// 🟣 샘플 상품 50개 생성
  void _loadAllItems() {
    for (int i = 1; i <= 50; i++) {
      _allItems.add(ProductItem(
        name: 'Animal Poster $i',
        price: i % 5 == 0 ? 0 : 10000 + i * 3000,
        image: 'https://via.placeholder.com/300x400?text=Poster+$i',
      ));
    }
  }

  /// 🟣 SharedPreferences에서 저장된 찜 목록 불러와 적용
  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    setState(() {
      for (var item in _allItems) {
        item.isLove = favList.contains(item.name);
      }
    });
  }

  /// 🟣 스크롤 끝에 다다르면 다음 페이지 로드
  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        !_allLoaded) {
      _loadMore();
    }
  }

  /// 🟣 다음 페이지의 상품 데이터를 화면에 추가하고, 모두 로드되면 스낵바 표시
  Future<void> _loadMore() async {
    setState(() => _isLoading = true);
    final start = _nextPage * _pageSize;
    final end = (start + _pageSize).clamp(0, _allItems.length);
    final slice = _allItems.sublist(start, end);
    if (slice.isNotEmpty) {
      setState(() => _displayItems.addAll(slice));
      _nextPage++;
    }
    if (_displayItems.length >= _allItems.length) {
      _allLoaded = true;
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

  /// 🟣 아이템의 찜 상태 토글 및 SharedPreferences에 저장
  Future<void> _toggleFavorite(ProductItem item) async {
    setState(() => item.isLove = !item.isLove);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorites',
      _allItems.where((e) => e.isLove).map((e) => e.name).toList(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();  // 🟣 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🟢 아직 로드된 상품이 없다면 로딩 인디케이터 표시
    if (_displayItems.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 🟢 상품 2개를 한 행(Row)에 배치한 ListView
    return Scaffold(
      backgroundColor: Colors.white, // 페이지 배경색
      body: Column(
        children: [
          // AppBar 없이 로고만 담긴 상단 박스
          Container(
            color: Colors.white, // 박스 배경색
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Transform.translate( // 로고 위치조정         
                 offset: const Offset(0, 30),
              child: Image.asset('assets/logo.png', height: 40), // 로고만 표시
            ),
          ),
          ),
          // 로고 아래에 search & cart 아이콘
          Container(
            color: Colors.white, // 동일 배경
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Image.asset('assets/icons/cart.png',
                      width: 30, height: 24), //장바구니 아이콘 사이즈
                  onPressed: () =>
                      Navigator.pushNamed(context, '/my_cart_page'),
                ),
                const SizedBox(width: 10), //아이콘 사이 거리
                IconButton(
                  icon: Image.asset('assets/icons/search.png',
                      width: 23, height: 23), //돋보기 아이콘 사이즈
                  onPressed: () =>
                      Navigator.pushNamed(context, '/item_search_page'),
                ),
              ],
            ),
          ),
          // 🟣 ListView.builder 를 Expanded로 감싸서 배치
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8), // 🟢 전체 패딩
              itemCount: (_displayItems.length / 2).ceil(),
              itemBuilder: (context, rowIndex) {
                final left = _displayItems[rowIndex * 2];
                final rightIndex = rowIndex * 2 + 1;
                final hasRight = rightIndex < _displayItems.length;
                final right = hasRight ? _displayItems[rightIndex] : null;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ProductListCard(
                              item: left,
                              onFavoriteToggle: () => _toggleFavorite(left),
                            ),
                            const SizedBox(height: 8), // 🟢 카드와 박스 사이 간격
                            ProductInfoBox(
                              name: left.name,
                              price: left.price,
                            ),
                          ],
                        ),
                      ),
                      if (hasRight) ...[
                        const SizedBox(width: 8), // 🟢 좌우 간격
                        Expanded(
                          flex: 1,
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
          'assets/icons/add.png', // 🟢 플로팅 + 아이콘
          width: 66,
          height: 66,
        ),
      ),
    );
  }
}
