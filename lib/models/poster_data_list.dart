import 'dart:math';

import '../models/poster.dart';
List<Poster> posterDataList = [
  Poster(
    name: "생일 도치(1)",
    price: 5000,
    description: "생일 도치(1)에 관한 설명입니다!",
    imagePath: "assets/images/생일_도치(1).png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "생일 도치(2)",
    price: 5000,
    description: "생일 도치(2)에 관한 설명입니다!",
    imagePath: "assets/images/생일_도치(2).png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "눈이 와 신난 강아지",
    price: 4000,
    description: "눈이 와 신난 강아지에 관한 설명입니다!",
    imagePath: "assets/images/눈이_와_신난_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "보드 타는 앵무새(1)",
    price: 3000,
    description: "보드 타는 앵무새(1)에 관한 관한 설명입니다!",
    imagePath: "assets/images/보드_타는_앵무새(1).png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "햅삐 고양이",
    price: 5000,
    description: "햅삐 고양이에 관한 설명입니다!",
    imagePath: "assets/images/햅삐_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "놀란 햄찌",
    price: 4000,
    description: "놀란 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/놀란_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "멍 때리는 햄찌",
    price: 4000,
    description: "멍 때리는 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/멍_때리는_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "소심한 앵무새",
    price: 3000,
    description: "소심한 앵무새에 관한 설명입니다!",
    imagePath: "assets/images/소심한_앵무새.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "음료 마시는 앵무새",
    price: 3000,
    description: "음료 마시는 앵무새에 관한 설명입니다!",
    imagePath: "assets/images/음료_마시는_앵무새.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "스무디 먹는 고양이",
    price: 5000,
    description: "스무디 먹는 고양이에 관한 설명입니다!",
    imagePath: "assets/images/스무디_먹는_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "스웩있는 고양이",
    price: 5000,
    description: "스웩있는 고양이에 관한 설명입니다!",
    imagePath: "assets/images/스웩_있는_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "감성있는 해파리",
    price: 2000,
    description: "감성있는 해파리에 관한 설명입니다!",
    imagePath: "assets/images/감성_있는_해파리.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "부농부농 해파리",
    price: 2000,
    description: "부농부농 해파리에 관한 설명입니다!",
    imagePath: "assets/images/부농부농_해파리.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "지각한 꿈을 꾼 강아지",
    price: 4000,
    description: "지각한 꿈을 꾼 강아지에 관한 설명입니다!",
    imagePath: "assets/images/지각한_꿈을_꾼_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "박사 생활 20년 햄찌",
    price: 4000,
    description: "박사 생활 20년 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/박사_생활_20년_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "야식 먹는 햄찌",
    price: 4000,
    description: "야식 먹는 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/야식_먹는_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "보드 타는 앵무새(2)",
    price: 3000,
    description: "보드 타는 앵무새(2)에 관한 설명입니다!",
    imagePath: "assets/images/보드_타는_앵무새(2).png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "선과악 고양이",
    price: 5000,
    description: "선과악 고양이에 관한 설명입니다!",
    imagePath: "assets/images/선과악_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "인스타 갬성 고양이",
    price: 5000,
    description: "인스타 갬성 고양이에 관한 설명입니다!",
    imagePath: "assets/images/인스타_갬성_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "포즈 잡는 고양이",
    price: 5000,
    description: "포즈 잡는 고양이에 관한 설명입니다!",
    imagePath: "assets/images/포즈_잡는_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "전직 마피아 고양이",
    price: 5000,
    description: "전직 마피아 고양이에 관한 설명입니다!",
    imagePath: "assets/images/전직_마피아_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "코딩 꿈나무 고양이",
    price: 5000,
    description: "코딩 꿈나무 고양이에 관한 설명입니다!",
    imagePath: "assets/images/코딩_꿈나무_고양이.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "자다 깬 햄찌",
    price: 4000,
    description: "자다 깬 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/자다_깬_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "생각하는 햄찌",
    price: 4000,
    description: "생각하는 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/생각하는_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "산책 기다리는 강아지",
    price: 4000,
    description: "산책 기다리는 강아지에 관한 설명입니다!",
    imagePath: "assets/images/산책_기다리는_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "산책가서 신난 강아지",
    price: 4000,
    description: "산책가서 신난 강아지에 관한 설명입니다!",
    imagePath: "assets/images/산책가서_신난_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "친구만나 기쁜 강아지",
    price: 4000,
    description: "친구만나 기쁜 강아지에 관한 설명입니다!",
    imagePath: "assets/images/친구만나_기쁜_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "크리스마스 강아지",
    price: 4000,
    description: "크리스마스 강아지에 관한 설명입니다!",
    imagePath: "assets/images/크리스마스_강아지.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "크리스마스 고슴도치",
    price: 4000,
    description: "크리스마스 고슴도치에 관한 설명입니다!",
    imagePath: "assets/images/크리스마스_고슴도치.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
  Poster(
    name: "고고학자 햄찌",
    price: 4000,
    description: "고고학자 햄찌에 관한 설명입니다!",
    imagePath: "assets/images/고고학자_햄찌.png",
    date: DateTime(
      2025,
      7,
      Random().nextInt(DateTime.now().day) + 1, // 1일 ~ 오늘 까지 랜덤
      Random().nextInt(24), // 0 ~ 23시
      Random().nextInt(60), // 0 ~ 59분
      Random().nextInt(60), // 0 ~ 59초
    ),
  ),
];