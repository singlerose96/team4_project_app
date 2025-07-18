import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 🟣 로컬 저장소
import '../models/product_item.dart';
import '../widgets/product_list_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController(); // 🟣 스크롤 컨트롤러
  final List<ProductItem> _allItems = [];     // 🟣 전체 상품 데이터
  final List<ProductItem> _displayItems = []; // 🟣 화면에 보이는 상품
  bool _isLoading = false;                    // 🟣 로딩 플래그
  bool _allLoaded = false;                    // 🟣 모두 로드 완료 여부
  int _nextPage = 0;                          // 🟣 다음 페이지 인덱스
  static const int _pageSize = 10;            // 🟣 페이지당 아이템 수

  @override
  void initState() {
    super.initState();
    _initData();                               // 🟣 초기 데이터 로드
    _scrollController.addListener(_onScroll);  // 🟣 스크롤 리스너
  }

  Future<void> _initData() async {
    _loadAllItems();                           // 🟣 샘플 데이터 생성
    await _loadFavorites();                    // 🟣 찜 상태 불러오기
    _loadMore();                               // 🟣 첫 페이지 로드
  }

  void _loadAllItems() {
    for (int i = 1; i <= 50; i++) {
      _allItems.add(ProductItem(
        name: 'Animal Poster $i',
        price: i % 5 == 0 ? 0 : 10000 + i * 3000,
        image: 'https://via.placeholder.com/300x400?text=Poster+$i',
      ));
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();          // 🟣 prefs
    final favList = prefs.getStringList('favorites') ?? [];      // 🟣 저장된 이름 리스트
    setState(() {
      for (var item in _allItems) {
        item.isLove = favList.contains(item.name);               // 🟣 상태 적용
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        !_allLoaded) {
      _loadMore(); // 🟣 다음 페이지 로드
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoading = true);             // 🟣 로딩 시작
    final start = _nextPage * _pageSize;
    final end = (start + _pageSize).clamp(0, _allItems.length);
    final newItems = _allItems.sublist(start, end);
    if (newItems.isNotEmpty) {
      setState(() => _displayItems.addAll(newItems)); // 🟣 화면에 추가
      _nextPage++;
    }
    if (_displayItems.length >= _allItems.length) {
      _allLoaded = true;                           // 🟣 모두 로드 완료
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('상품을 모두 보았습니다.'),
            duration: Duration(seconds: 1),
          ),                                         // 🟣 스낵바
        );
      });
    }
    setState(() => _isLoading = false);            // 🟣 로딩 끝
  }

  Future<void> _toggleFavorite(ProductItem item) async {
    setState(() {
      item.isLove = !item.isLove;                  // 🟣 토글
    });
    final prefs = await SharedPreferences.getInstance();
    final favNames = _allItems.where((e) => e.isLove).map((e) => e.name).toList();
    await prefs.setStringList('favorites', favNames); // 🟣 저장
  }

  @override
  void dispose() {
    _scrollController.dispose();                  // 🟣 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,             // 🟢 헤더 배경
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 40), // 🟢 로고
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search.png', width: 24, height: 24), // 🟢 검색
            onPressed: () => Navigator.pushNamed(context, '/item_search_page'),   // 🟣 이동
          ),
          Stack(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/cart.png', width: 24, height: 24), // 🟢 장바구니
                onPressed: () => Navigator.pushNamed(context, '/my_cart_page'),     // 🟣 이동
              ),
              if (_allItems.any((e) => e.isLove))
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ), // 🟢 배지
                  ),
                ),
            ],
          ),
        ],
      ),
      body: GridView.builder(
        controller: _scrollController,             // 🟣 페이징
        padding: const EdgeInsets.all(8),           // 🟢 패딩
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,                        // 🟢 2열
          childAspectRatio: 0.75,                   // 🟢 카드 비율
          crossAxisSpacing: 8,                      // 🟢 열 간격
          mainAxisSpacing: 8,                       // 🟢 행 간격
        ),
        itemCount: _displayItems.length,           // 🟣 로드된 수
        itemBuilder: (context, index) {
          final item = _displayItems[index];
          return ProductListCard(
            item: item,
            onFavoriteToggle: () => _toggleFavorite(item), // 🟣 토글
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/item_add_page'), // 🟣 이동
          child: Image.asset('assets/icons/add.png', width: 120, height: 120), // 🟢 +
        ),
    );
         
        
  }
}
