import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maidin_kenya/database/entity/syncSalesDataEntity.dart';
import 'common/colors.dart';
import 'database/database.dart';
import 'detail_sales_mineral.dart';

class SyncSales extends StatefulWidget{
  const SyncSales({super.key});

  @override
  _SyncSalesState createState() => _SyncSalesState();
}

class _SyncSalesState extends State<SyncSales>{

  late UserDatabase database;
  bool loader = false;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<SyncSalesDataEntity> syncSaleDataList = [];
  List<SyncSalesDataEntity> searchSaleDataList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      loader = true;
    });
    initializeDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8),
             child: isSearching
            ?Container(
          height:
          MediaQuery.sizeOf(context).height * 0.080,
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.only(
              left: 5, right: 5, bottom: 5, top: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0))),
          child: SizedBox(
            height: 47,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.grey,
              cursorWidth: 1.2,
              onChanged: (value) async {
                //search method call
                searchApplicationList(value);
              },
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 14),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                hintText: "Search by mineral name or month",
                hintStyle: const TextStyle(fontSize: 14),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 17,
                  ),
                  onPressed: () async {
                    setState(() {
                      isSearching = false;
                    });
                    //close method call
                    closeSearchingApplicationList("");
                  },
                ),
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                  size: 23,
                ),
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.white70)),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.white70)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Colors.white70)),
              ),
            ),
          ),
        )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('asset/images/left.png', height: 30),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'View Mineral Sales Data',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          isSearching = true;
                        });
                      },
                      child: Image.asset('asset/images/search .png', height: 25)),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(color: Colors.grey.withOpacity(0.2),),
            Expanded(
              child: ListView.builder(
                itemCount: syncSaleDataList.length,
                itemBuilder: (context,index) {
                  var item = syncSaleDataList[index];
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    height: 220,
                    width: 350,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              item.mineralName,
                              style: TextStyle(
                                  color: textColor2,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: salesContainer,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text('3200 kg',
                                  style: TextStyle(
                                      color: salesTextColor
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Date of Sale -',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                              TextSpan(
                                text: formatDate(item.selectedDate),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .w400), // Change the color to red or any other color you prefer
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sale Through - ',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                              TextSpan(
                                text:
                                item.societyName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .w400), // Change the color to red or any other color you prefer
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sale Value - ',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 18),
                              ),
                              TextSpan(
                                text:
                                '${item.mineralWeightController} kg',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight
                                        .w400), // Change the color to red or any other color you prefer
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Divider(color: Colors.grey.withOpacity(0.2),),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  DetailSalesMineral(item: item,)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 200, top: 10),
                            child: Row(
                              children: [
                                Text('View Details',
                                  style: TextStyle(color: syncSalesColor),),
                                SizedBox(width: 2,),
                                Image.asset('asset/images/right-arrow_green.png',
                                  height: 10,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
  void initializeDb() async {
    await $FloorUserDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      setState(() {database = value;});
    });

    await fetchDbData();
  }

  Future<void> fetchDbData() async {
    var syncData = await database.syncSalesDao.retrieveSyncSalesData();
    if (syncData.isNotEmpty) {
      setState(() {
        syncSaleDataList = syncData;
        searchSaleDataList = syncSaleDataList;
        loader = false;
      });
      debugPrint("sync Data length::::::::::::::: ${syncSaleDataList.length}");
    } else {
      debugPrint("list is empty no data found in sync table");
      setState(() {
        loader = false;
      });
    }
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      searchController.clear();
    });
  }

  void searchApplicationList(String searchValue) {
    setState(() {
      loader = true;
     syncSaleDataList = searchSaleDataList
          .where((element) =>
      element.mineralName
          .toString()
          .toUpperCase()
          .contains(searchValue.toUpperCase()) ||
          element.selectedDate
              .toString()
              .toUpperCase()
              .contains(searchValue.toUpperCase()))
          .toList();
      loader = false;
    });
  }

  void closeSearchingApplicationList(value) {
    setState(() {
      loader = true ;
      syncSaleDataList = searchSaleDataList ;
      loader = false ;
    });
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }
}

