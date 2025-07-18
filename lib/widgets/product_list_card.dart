import 'package:flutter/material.dart';
import '../models/product_item.dart';

class ProductListCard extends StatelessWidget {
  final ProductItem item;
  final VoidCallback onFavoriteToggle;

  const ProductListCard({
    Key? key,
    required this.item,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 🟢 카드 외부 여백 & 노란 테두리
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  // 🟢 상단 이미지: 위쪽 모서리만 둥글게
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(
                    item.image,         // 🟢 상품 이미지
                    fit: BoxFit.cover,  // 🟢 화면에 꽉 차도록
                    width: double.infinity,
                  ),
                ),
              ),
              Container(
                // 🟢 정보 박스: 밝은 회색 배경 + 패딩
                color: Colors.grey.shade200,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,      // 🟢 상품 이름
                        style: const TextStyle(
                          fontSize: 16,           // 🟢 큰 볼드 텍스트
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      item.price == 0
                          ? 'FREE PRIZE' 
                          : '₩${item.price.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}', // 🟢 천 단위 콤마
                      style: TextStyle(
                        fontSize: 14,          // 🟢 작은 볼드 텍스트
                        fontWeight: FontWeight.bold,
                        color: item.price == 0 ? Colors.red : Colors.black, // 🟢 0원은 빨강
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 60,
            right: 10,
            child: GestureDetector(
              onTap: onFavoriteToggle, // 🟣 찜 토글 콜백
              child: Container(
                // 🟢 하트 버튼: 초록 테두리 + 흰 배경
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 2),
                  color: Colors.white,
                ),
                child: Image.asset(
                  // 🟢 찜 상태에 따라 아이콘 변경
                  item.isLove
                      ? 'assets/icons/heart_filled.png'
                      : 'assets/icons/heart_outline.png',
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
