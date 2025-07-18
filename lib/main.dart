import 'package:flutter/material.dart';
import 'pages/product_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Poster',                   // 🟢 앱 타이틀
      theme: ThemeData(
        primarySwatch: Colors.green,            // 🟢 기본 테마색
      ),
      initialRoute: '/product_list',            // 🟣 첫 화면 라우트
      routes: {
        '/product_list': (context) => const ProductListPage(),  // 🟣 목록 페이지
        '/my_cart_page': (context) => const Scaffold(body: Center(child: Text('My Cart Page'))),       // 🟣 (팀원 구현 예정)
        '/item_search_page': (context) => const Scaffold(body: Center(child: Text('Search Page'))),    // 🟣 (팀원 구현 예정)
        '/item_add_page': (context) => const Scaffold(body: Center(child: Text('Add Item Page'))),     // 🟣 (팀원 구현 예정)
      },
    );
  }
}
