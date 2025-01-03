import 'package:flutter/material.dart';
import 'package:jjimkong/common/themes/app_styles.dart';
import 'package:jjimkong/common/widget/base_app_bar.dart';
import 'package:jjimkong/common/widget/base_layout.dart';
import 'package:jjimkong/map/services/map_service.dart';
import 'package:jjimkong/map/utils/map_category.dart';
import 'package:jjimkong/map/widgets/%08jjimkong_list_item.dart';

class TodayJjimkongListScreen extends StatefulWidget {
  @override
  State<TodayJjimkongListScreen> createState() =>
      _TodayJjimkongListScreenState();
}

class _TodayJjimkongListScreenState extends State<TodayJjimkongListScreen> {
  late Future<List> _todayJjimkongList;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 데이터 로드 메소드
  void _loadData() {
    setState(() {
      _todayJjimkongList = MapService.getTodayJJimKongList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        title: "오늘 찜콩",
      ),
      body: BaseLayout(
        hasHorizontalPadding: true,
        child: FutureBuilder(
          future: _todayJjimkongList,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                "오늘 찜콩이 없어요",
                style: AppStyles.defaultText,
              ));
            }

            var places = snapshot.data;
            return ListView.builder(
              itemCount: places!.length,
              itemBuilder: (context, index) {
                return TodayListItem(
                  callback: _loadData,
                  id: places[index].restaurantId,
                  placeName: places[index].restaurantName,
                  category:
                      MapCategory().findCategoryByCode(places[index].category),
                  address: places[index].address,
                  visitorCount: places[index].checkCount,
                  hasWrittenReview: places[index].reviewed,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
