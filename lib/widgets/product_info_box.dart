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

  String get _formattedPrice {
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
      // 🟢 고정 크기, 배경색, 아래쪽만 둥근 모서리 radius 12
      width: 186,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name, // 🟢 상품 이름
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            _formattedPrice, // 🟢 포맷된 가격
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: price == 0 ? Colors.red : Colors.black, // 🟢 0원은 빨강
            ),
          ),
        ],
      ),
    );
  }
}
