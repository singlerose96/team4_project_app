class ProductItem {
  final String name;    // 🟣 상품 이름
  final int price;      // 🟣 상품 가격 (원 단위)
  final String image;   // 🟣 이미지 URL 또는 asset 경로
  bool isLove;          // 🟣 좋아요 상태

  ProductItem({
    required this.name,
    required this.price,
    required this.image,
    this.isLove = false, // 🟣 기본 좋아요 상태 false
  });
}
