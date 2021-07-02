import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nativeadproblem/native_inline_ad.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Without Ads"),
              Tab(text: "With Ads")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListViewToProfile(withAds: false),
            ListViewToProfile(withAds: true)
          ],
        ),
      ),
    );
  }
}

class ListItem {
  final bool isAnAd;
  final int id;
  ListItem({required this.id, this.isAnAd = false});
}
class ListViewToProfile extends StatelessWidget {

  final bool withAds;

  const ListViewToProfile({Key? key, this.withAds = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListItem> items = [];
    for(int i = 0; i < 100; i++) {
      items.add(ListItem(id: i));
      if(withAds && i % 10 == 0){
        items.add(ListItem(id: i, isAnAd: true));
      }
    }
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          ListItem _item = items[index];
          if(_item.isAnAd){
            return NativeInlineAd();
          }
          else{
            return Text("Id : " + _item.id.toString());
          }
        });
  }

}
