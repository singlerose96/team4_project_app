import 'package:flutter/material.dart';

/// 🟣 상품 이름과 가격을 보여주는 정보 박스 위젯
class ProductInfoBox extends StatelessWidget {
  final String name;   // 🟣 상품 이름
  final int price;     // 🟣 상품 가격(원 단위)

  const ProductInfoBox({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  /// 🔵 가격을 천 단위 콤마로 포맷팅하고 '원'을 붙입니다.
  String get formattedPrice {
    if (price == 0) return 'FREE PRIZE';
    return price
        .toString()
        .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',') +
      '원';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 186,  // 🟣 카드와 동일한 고정 너비
      height: 68,  // 🟣 고정 높이
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),         // 🟣 배경색 #F6F6F6
        borderRadius: BorderRadius.circular(12), // 🟣 모든 모서리 반경 12
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12, // 🟣 좌우 패딩
        vertical: 8,    // 🟣 상하 패딩
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 🟡 자식 위젯을 너비 최대치로 확장
        mainAxisAlignment: MainAxisAlignment.center,    // 🟣 세로 중앙 정렬
        children: [
          Text(
            name, // 🟣 상품 이름
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4), // 🟣 텍스트 간 간격
          Align(
            alignment: Alignment.centerRight, // 🟡 가격 텍스트를 오른쪽 정렬
            child: Text(
              formattedPrice, // 🟣 포맷된 가격
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: price == 0 ? Colors.red : Colors.black, // 🟣 0원은 빨강, 그 외 검정
              ),
            ),
          ),
        ],
      ),
    );
  }
}
