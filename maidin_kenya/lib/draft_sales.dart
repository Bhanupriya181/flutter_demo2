import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:maidin_kenya/database/entity/salesDataEntity.dart';
import 'package:maidin_kenya/database/entity/syncSalesDataEntity.dart';
import 'common/colors.dart';
import 'database/database.dart';

class DraftSales extends StatefulWidget {
  @override
  _DraftSalesState createState() => _DraftSalesState();
}

class _DraftSalesState extends State<DraftSales> {

  bool loader = false;
  late UserDatabase database;

  bool isSearching = false;
  bool onTapDelete = false;
  bool onTapSync = false;

  List<SalesDataEntity> saleDataList = [];
  List<SalesDataEntity>  searchSaleDataList = [];

  TextEditingController searchController = TextEditingController();

  DateTime? selectedDate;

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
       body: loader
            ? const Center(
         child: CircularProgressIndicator(
           color: colorPrimary,
         ),
       )
            :saleDataList.isEmpty
            ? Center(
         child: Column(
           children: [
             Image.asset('asset/images/no-data.png',height: 25,),
             Center(child: Text('no data found'))
           ],
         ),
       )
            :Column(
            children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: isSearching
                ? Container(
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
                  'Mineral Sales Draft Data',
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
              itemCount: saleDataList.length,
              itemBuilder: (context,index) {
                var item = saleDataList[index];
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
                            style: const TextStyle(
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
                                  fontWeight: FontWeight.w400), // Change the color to red or any other color you prefer
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5,),
                      RichText(
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sale Value -',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 18),
                            ),
                            TextSpan(
                              text:
                              '${item.mineralWeightController} kg',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400), // Change the color to red or any other color you prefer
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              var id = item.id ;
                              showSyncDialog(context,
                                  id!, item, index);
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                onTapSync
                                    ? Lottie.asset(
                                    'asset/animation/sync_animation.json',
                                    height: 20)
                                    : Image.asset(
                                  "asset/images/sync.png",
                                  height: 15,
                                  color: Colors.green,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Sync',
                                  style: TextStyle(
                                      color: Colors.green),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var id = item.id ;
                              showDeleteDialog(context,id!, index);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                onTapDelete
                                    ? Lottie.asset(
                                    'asset/animation/delete_animation.json',
                                    height: 20)
                                    : Image.asset(
                                  "asset/images/delete.png",
                                  height: 15,
                                  color: textColor2,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Delete',
                                  style:
                                  TextStyle(color: textColor2),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            ),
          )
        ],
      ),
     )
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
    var saleDataLists = await database.salesDataDao.retrieveSalesData();
    debugPrint("data length ${saleDataLists.length}");
    if (saleDataLists.isNotEmpty) {
      setState(() {
        saleDataList = saleDataLists;
        searchSaleDataList = saleDataList;
        loader = false;
      });
    } else {
      debugPrint("list is empty no data found in table");
      setState(() {
        loader = false;
      });
    }
  }

  void searchApplicationList(String searchValue) {
    setState(() {
      loader = true;
      saleDataList = searchSaleDataList
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
      saleDataList = searchSaleDataList ;
      loader = false ;
    });
  }

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      searchController.clear();
    });
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }

  deleteProductionData(int? id, int index) {
    try {
      setState(() {
        onTapDelete = true;
      });
      Timer(
        const Duration(seconds: 2),
            () {
          database.salesDataDao.deleteSalesDataById(id!);
          setState(() {
            saleDataList.removeAt(index);
            onTapDelete = false;
          });
        },
      );
    } catch (e) {
      onTapDelete = false;
      debugPrint("Exception in production data deletion");
    }
  }

  void showDeleteDialog(BuildContext context, int id, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Data'),
          content: const Text('Are you sure you want to delete this data?'),
          actions:[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                deleteProductionData(id, index);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void syncSalesData(int? id, SalesDataEntity item, int index) {
    var draftDataId = id;
    try {
      setState(() {
        onTapSync = true;
      });
      //create sync obj from production data obj
      SyncSalesDataEntity syncSalesDataEntity =
      SyncSalesDataEntity(
          userName: item.userName,
          address: item.address,
          selectedDate: item.selectedDate,
          saleTransactionController: item.saleTransactionController,
          mineralName: item.mineralName,
          mineralType: item.mineralType,
          mineralGreade: item.mineralGreade,
          mineralUnit: item.mineralUnit,
          mineralWeightController: item.mineralWeightController,
          soldMineralPriceController: item.soldMineralPriceController,
          verifiedMineralPriceController: item.verifiedMineralPriceController,
          saleTypeController: item.saleTypeController,
          societyId: item.societyId,
          societyName: item.societyName,
          namePurchaserController: item.namePurchaserController,
          addressPurchaserController: item.addressPurchaserController,
          exportedMineralController: item.exportedMineralController,
          selectedValue: item.selectedValue,
          fileName: item.fileName,
          pdfName: item.pdfName);
      /*debugPrint(item.pdfName);*/
      Timer(const Duration(seconds: 3), () {
        //insert data in sync table
        database.syncSalesDao.insertSyncSalesData(syncSalesDataEntity);
        //after syncing the data in sync table here i delete the same data from the DRAFT SYNC table bcz after syncing it is not necessary to show the data again
        database.salesDataDao.deleteSalesDataById(draftDataId!);
        setState(() {
          saleDataList.removeAt(index);
          onTapSync = false;
          loader = false;
        });
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SyncProduction(),));
      });
    } catch (e) {
      onTapSync = false;
      debugPrint("sync failed::::::::$e");
    }
  }

  void showSyncDialog(BuildContext context, int id, SalesDataEntity salesDataEntity, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sync Data'),
          content: const Text('Are you sure you want to sync this data?'),
          actions:[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                syncSalesData(id, salesDataEntity, index);
              },
              child: const Text('Sync'),
            ),
          ],
        );
      },
    );
  }

}
