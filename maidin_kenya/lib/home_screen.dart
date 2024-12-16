import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maidin_kenya/draft_payment.dart';
import 'package:maidin_kenya/login_screen.dart';
import 'package:maidin_kenya/mineral_payment_data.dart';
import 'package:maidin_kenya/production_data.dart';
import 'package:maidin_kenya/draft_sales.dart';
import 'package:maidin_kenya/rms_home.dart';
import 'package:maidin_kenya/splash_screen.dart';
import 'package:maidin_kenya/sync_production_data.dart';
import 'package:maidin_kenya/sync_sales_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/colors.dart';
import 'database/database.dart';
import 'database/entity/productionDataEntity.dart';
import 'database/entity/salesDataEntity.dart';
import 'database/entity/syncProductionDataEntity.dart';
import 'database/entity/syncSalesDataEntity.dart';
import 'draft_production.dart';
import 'mineral_sales_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loader = false;

  late UserDatabase database;
  List<ProductionDataEntity> productionDataList = [];
  List<SyncProductionDataEntity> syncProductionDataList = [];

  List<SalesDataEntity> saleDataList = [];
  List<SyncSalesDataEntity> syncSaleDataList = [];


  @override
  void initState() {
    super.initState();
    setState(() {
      loader = true;
    });
    initializeDb();
  }
  void initializeDb() async {
    await $FloorUserDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
      setState(() {});
    });

    await fetchDbData();
  }

  Future<void> fetchDbData()async{
    try{
      var productionData = await database.productionDao.retrieveProductionData();
      var syncProductionData = await database.syncProductionDao.retrieveSyncProductionData();
      var saleDraftData =await database.salesDataDao.retrieveSalesData();
      var syncSalesData = await database.syncSalesDao.retrieveSyncSalesData();
      if(productionData.isNotEmpty ||
          syncProductionData.isNotEmpty ||
          saleDraftData.isNotEmpty ||
          syncSalesData.isNotEmpty ) {
        setState(() {
          productionDataList = productionData ;
          syncProductionDataList = syncProductionData ;
          saleDataList = saleDraftData;
          syncSaleDataList = syncSalesData;
          loader = false ;
        });
      } else {
        debugPrint("no data found in table");
      }

    } catch(e) {
      debugPrint("error retrieving data from table $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 220,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [colorPrimary1, colorPrimary2],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'RMS Home',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        // Icon(Icons.arrow_back, color: Colors.white),
                        GestureDetector(
                          onTap: ()async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setBool(SplashScreenState.KEYLOGIN, false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                            child: Image.asset('asset/images/logout_logo.png',height: 20,color: Colors.white,))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 16)),
                        const Text('Mr. Nelson Odhiamba', style: TextStyle(color: homeText, fontSize: 18)),
                        const Text('AML/2024/1234', style: TextStyle(color: homeText2, fontSize: 16, fontWeight: FontWeight.w400)),
                        Text('Artisanal Miner', style: TextStyle(color: homeText2.withOpacity(0.6), fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update/View Production Info',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProductionData()),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: homeText2,
                                child: Image.asset(
                                  'asset/images/labor.png',
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                              const Text(
                                'Add Production Data',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 30),
                              Image.asset('asset/images/right_arrow.png', height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                           Navigator.push(
                             context,
                            MaterialPageRoute(builder: (context) => SyncProduction()),
                            );
                            },
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/sync_animation.json', height: 30),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Flexible(
                                          child: Text(
                                            'Synced Data',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            syncProductionDataList.length.toString(),
                                            style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const DraftProduction()),
                              );
                            },
                            child: Flexible(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                    const SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         const Flexible(
                                          child: Text(
                                            'Draft Data    ',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            productionDataList.length.toString(),
                                            style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Update/View Sales Info',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MineralSalesData()),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: homeText2,
                                child: Image.asset(
                                  'asset/images/cooperation.png',
                                  color: Colors.orange,
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                              const Text(
                                'Add Sales Data',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 30),
                              Image.asset('asset/images/right_arrow.png', height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    SyncSales()),
                              );
                            },
                            child: Flexible(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/sync_animation.json', height: 30),
                                    const SizedBox(width: 5),
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Flexible(
                                          child: Text(
                                            'Synced Data',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            syncSaleDataList.length.toString(),
                                            style: const TextStyle(fontSize: 18,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    DraftSales()),
                              );
                            },
                            child: Flexible(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Draft Data',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            saleDataList.length.toString(),
                                            style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Update/View Payment Info',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: (){
                            if(syncSaleDataList.length > 0){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    PaymentData()),);
                            } else {
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: homeText2,
                                child: Image.asset(
                                  'asset/images/money.png',
                                  color: Colors.orange,
                                  height: 25.0,
                                  width: 25.0,
                                ),
                              ),
                              const Text(
                                'Add Payment Data',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 30),
                              Image.asset('asset/images/right_arrow.png', height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    RmsHome()),
                              );
                            },
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/sync_animation.json', height: 30),
                                    const SizedBox(width: 5),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Synced Data',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '1254',
                                            style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    DraftPayment()),
                              );
                            },
                            child: Expanded(
                              flex: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.1,
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10.0,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Lottie.asset('asset/animation/draft_animation.json', height: 30),
                                    const SizedBox(width: 5),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Draft Data',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            '13',
                                            style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
