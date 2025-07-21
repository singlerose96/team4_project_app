import 'package:flutter/material.dart';
import '../models/poster.dart';

class ProductListCard extends StatelessWidget {
  final Poster item;
  final VoidCallback onFavoriteToggle;

  const ProductListCard({
    Key? key,
    required this.item,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 186,   // 🟢 고정 너비
      height: 276,  // 🟢 고정 높이
      child: Stack(
        children: [
          // 🟡 카드 전체를 배경 이미지로 채우고 노란 테두리 적용
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(217, 160, 102, 1),
                  width: 3,
                ),  
                borderRadius: BorderRadius.circular(12),  // 🟢 모든 모서리 반경 12
                image: DecorationImage(
                  image: AssetImage(item.imagePath),       // 🟡 에셋 이미지를 전체 채움
                  fit: BoxFit.cover,                       // 🟡 비율 유지하며 꽉 채우기
                ),






                
              ),
            ),
          ),

          // 🟡 찜(하트) 아이콘: 이미지 위에 오버레이
          Positioned(
            bottom: 20,  // 🟢 하단 공간에서 20px 위쪽
            right: 20,   // 🟢 우측 공간에서 20px 왼쪽
            child: GestureDetector(
              onTap: onFavoriteToggle,                 // 🟣 찜 토글 콜백
              child: Image.asset(
                item.isFavorite
                  ? 'assets/icons/heart_filled.png'
                  : 'assets/icons/heart_outline.png',  // 🟢 상태에 따라 다른 아이콘
              ),
            ),
          ),
        ],
      ),
    );
  }
}
