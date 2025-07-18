import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_item.dart';
import '../widgets/product_list_card.dart';
import '../widgets/product_info_box.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController();
  final List<ProductItem> _allItems = [];
  final List<ProductItem> _displayItems = [];
  bool _isLoading = false, _allLoaded = false;
  int _nextPage = 0;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _initData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _initData() async {
    _loadAllItems();
    await _loadFavorites();
    _loadMore();
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
    final prefs = await SharedPreferences.getInstance();
    final favList = prefs.getStringList('favorites') ?? [];
    setState(() {
      for (var item in _allItems) {
        item.isLove = favList.contains(item.name);
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        !_allLoaded) {
      _loadMore();
    }
  }

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
            content: Text('상품을 모두 보았습니다.'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }
    setState(() => _isLoading = false);
  }

  Future<void> _toggleFavorite(ProductItem item) async {
    setState(() => item.isLove = !item.isLove);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'favorites',
      _allItems.where((e) => e.isLove).map((e) => e.name).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 로드된 상품이 없으면 로딩 표시
    if (_displayItems.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ListView를 사용해, 한 줄에 두 개씩 Row 배치
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset('assets/logo.png', height: 40),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/search.png', width: 24, height: 24),
            onPressed: () => Navigator.pushNamed(context, '/item_search_page'),
          ),
          Stack(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/cart.png', width: 24, height: 24),
                onPressed: () => Navigator.pushNamed(context, '/my_cart_page'),
              ),
              if (_allItems.any((e) => e.isLove))
                const Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
                ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount: (_displayItems.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          // 각 Row마다 좌/우 아이템을 할당
          final left = _displayItems[rowIndex * 2];
          final rightIndex = rowIndex * 2 + 1;
          final hasRight = rightIndex < _displayItems.length;
          final right =
              hasRight ? _displayItems[rightIndex] : null;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 좌측 카드+정보
                Expanded(
                  flex: 1,
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
                  // 우측 카드+정보
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
      floatingActionButton: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/item_add_page'),
        child: Image.asset('assets/icons/add.png', width: 66, height: 66),
      ),
    );
  }
}
