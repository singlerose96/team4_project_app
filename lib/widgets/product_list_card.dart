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
    return SizedBox(
      width: 186,     // 🟢 고정 너비
      height: 276,    // 🟢 고정 높이
      child: Container(
        // 🟢 카드를 감싸는 컨테이너: 노란 테두리 + 전체 모서리 radius 12
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(217, 160, 102, 1), width: 3),
          borderRadius: BorderRadius.circular(12),  // 🟢 모든 모서리 반경 12
        ),
        child: Stack(
          children: [
            Column(
              children: [
                ClipRRect(
                  // 🟢 상단 이미지: 전체 너비, 높이 비율에 맞게 적용
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),   // 🟢 좌측 상단 반경 12
                    topRight: Radius.circular(12),  // 🟢 우측 상단 반경 12
                  ),
                ),
                
          ]),

            Positioned(
              bottom: 20, // 🟢 위젯박스 위에 배치 
              right: 20,
              child: GestureDetector(
                onTap: onFavoriteToggle, // 🟣 찜 토글 콜백
                child: Container(
                  // 🟢 하트 버튼: 초록 테두리 + 흰 배경
                  child: Image.asset(
                    item.isLove
                        ? 'assets/icons/heart_filled.png'
                        : 'assets/icons/heart_outline.png', // 🟢 찜 상태에 따라 아이콘 변경
                
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
