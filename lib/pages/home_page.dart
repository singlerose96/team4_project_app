import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Clayful',
                        style: GoogleFonts.workSans(
                          color: const Color(0xFF1b140e),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.015 * 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    height: 48,
                    child: IconButton(
                      onPressed: () {},
                      icon: const PhosphorIcon(
                        PhosphorIconsRegular.shoppingBag, // 🟣 스타일 클래스 적용 & weight 제거
                        color: Color(0xFF1b140e),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFf3ede7),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: const Center(
                        child: PhosphorIcon(
                          PhosphorIconsRegular.magnifyingGlass, // 🟣
                          color: Color(0xFF97734e),
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Color(0xFFf3ede7),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search for ceramics',
                              hintStyle: GoogleFonts.workSans(
                                color: const Color(0xFF97734e),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Body Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured Artist
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 218,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBMDkuKFUiBJ7N5rL4AT_v9rQm-fu7LYiiN8DW1ryhYcu1USA7gPYLwj999fHJEE1Y-Im95IGb4wT5RaBrqxhiJj-pw0GN-OSMsP8wb-yifEFJCTkYPo4n0oFMzjyGjLARKyyFntGDJbXNQnRKRY-60cyr245-FHkbaGjYei7d3HjdWEFq73vvPzdJnD8jEoi3VY7MSqNWdKAa_WiRA6H5IbD1aW_boMopWfalxwmtq2NBsW_NjNlJrnziXJCy_BxoUVGzMg_rVsZh6',
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              stops: const [0, 0.25],
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Featured Artist: Anya Petrova',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // New Arrivals
                    const SectionTitle(title: 'New Arrivals'),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: newArrivals.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, i) =>
                            ProductCard(item: newArrivals[i]),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Best Sellers
                    const SectionTitle(title: 'Best Sellers'),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemCount: bestSellers.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, i) =>
                            ProductCard(item: bestSellers[i]),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFfcfaf8),
                border: Border(top: BorderSide(color: Color(0xFFf3ede7))),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: const [
                  NavIcon(icon: PhosphorIconsFill.house, filled: true),           // 🟣 스타일 클래스 적용
                  NavIcon(icon: PhosphorIconsRegular.magnifyingGlass),            // 🟣
                  NavIcon(icon: PhosphorIconsRegular.heart),                      // 🟣
                  NavIcon(icon: PhosphorIconsRegular.user),                       // 🟣
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Text(
        title,
        style: GoogleFonts.workSans(
          color: const Color(0xFF1b140e),
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.015 * 22,
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  // 🟣 아이콘 타입을 PhosphorIconData로 변경
  final PhosphorIconData icon;
  final bool filled;
  const NavIcon({super.key, required this.icon, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PhosphorIcon(
        icon,                                                            // 🟣
        color: filled ? const Color(0xFF1b140e) : const Color(0xFF97734e),
        size: 24,                                                        // 🟣 weight 파라미터 삭제
      ),
    );
  }
}
