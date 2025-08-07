import 'package:afiyyah_connect/app/themes/app_spacing.dart';
import 'package:afiyyah_connect/features/common/utils/extension/theme_extension.dart';
import 'package:afiyyah_connect/features/monitoring/view/insightcardNDateInfo_component.dart';
import 'package:afiyyah_connect/features/monitoring/view/tabviewmonitoring.dart';
import 'package:flutter/material.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = 224;

    return Scaffold(
      body: Stack(
        children: [
          // Background image that extends beyond the visible area
          _buildBackgroundImage(appBarHeight),

          // Main content using NestedScrollView
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: (appBarHeight - 120) / 2,
                      horizontal: 16,
                    ),
                    child: InsightCardNDateInfo(value: 16),
                  ),
                ),
                // Transparent spacer to push content down
                // SliverToBoxAdapter(child: SizedBox(height: 90)),

                // Bottom sheet container start
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SizedBox(width: double.infinity, height: 32),
                  ),
                ),

                // Tab bar inside the bottom sheet
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Periksa'),
                        Tab(text: 'Arahan'),
                        Tab(text: 'Rujukan RS'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TabViewMonitoring(tabController: _tabController),
              ),
            ),
          ),
          // Positioned(
          //   left: 16,
          //   right: 16,
          //   top: (appBarHeight - 90) / 2,
          //   child: InsightCardNDateInfo(value: 16),
          // ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(double appBarHeight) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: appBarHeight + 100, // Extra height for better coverage
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVkaWNhbCUyMGNsaXBib2FyZHxlbnwwfHwwfHx8MA%3D%3D',
              height: appBarHeight + 100,
              width: double.infinity,
              fit: BoxFit.cover,
              // loadingBuilder: tampilkan spinner saat loading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: appBarHeight + 100,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              // errorBuilder: tampilkan fallback saat gagal load
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: appBarHeight + 100,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
            // Overlay gradient
            Container(
              height: appBarHeight + 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
