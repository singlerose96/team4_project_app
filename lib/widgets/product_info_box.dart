import 'package:flutter/material.dart';

/// 🟢 상품 이름과 가격을 보여주는 정보 박스 위젯
class ProductInfoBox extends StatelessWidget {
  final String name;   // 🟢 상품 이름
  final int price;     // 🟢 상품 가격(원 단위)

  const ProductInfoBox({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  String get formattedPrice {
    if (price == 0) return 'FREE PRIZE';
    // 🟢 천 단위 콤마 포맷팅
    return '₩' +
        price
            .toString()
            .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
  }

  @override
Widget build(BuildContext context) {
  return Container(
    width: 188,  // 🟢 고정 너비
    height: 68,  // 🟢 고정 높이
    decoration: BoxDecoration(
      color: const Color(0xFFF6F6F6),           // 🟢 배경색 #F6F6F6
      borderRadius: BorderRadius.circular(12),   // 🟢 모든 모서리 반경 12
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: 12,  // 🟢 좌우 패딩
      vertical: 8,     // 🟢 상하 패딩
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,   // 🟢 왼쪽 정렬
      mainAxisAlignment: MainAxisAlignment.center,    // 🟢 세로 중앙 정렬
      children: [
        Text(
          name,  // 🟢 상품 이름
          style: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),  // 🟢 텍스트 간 간격
        Text(
          price == 0
              ? 'FREE PRIZE'  // 🟢 가격이 0이면 FREE PRIZE
              : '₩${price.toString().replaceAllMapped( // 🟢 천 단위 콤마 포맷
                  RegExp(r'\B(?=(\d{3})+(?!\d))'), 
                  (m) => ','
                )}',
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold,
            color: price == 0 ? Colors.red : Colors.black, // 🟢 0원은 빨강, 그 외 검정
          ),
        ),
      ],
    ),
  );
}

}
