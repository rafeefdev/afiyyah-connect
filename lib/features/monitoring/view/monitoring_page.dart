import 'package:afiyyah_connect/app/themes/app_spacing.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildAppBar(appBarHeight),
            SliverToBoxAdapter(child: SizedBox(height: AppSpacing.m)),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TabViewMonitoring(tabController: _tabController),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAppBar(double appBarHeight) {
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWVkaWNhbCUyMGNsaXBib2FyZHxlbnwwfHwwfHx8MA%3D%3D',
              height: appBarHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              // loadingBuilder: tampilkan spinner saat loading
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: appBarHeight,
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
                  height: appBarHeight,
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
              height: appBarHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: (appBarHeight - 90) / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InsightCardNDateInfo(value: 16),
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
