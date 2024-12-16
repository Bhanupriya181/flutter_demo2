import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maidin_kenya/database/entity/syncProductionDataEntity.dart';
import 'common/colors.dart';
import 'database/database.dart';
import 'database/entity/productionDataEntity.dart';
import 'detail_production_mineral.dart';

class DraftProduction extends StatefulWidget {
  const DraftProduction({super.key});

  @override
  _DraftProductionState createState() => _DraftProductionState();
}

class _DraftProductionState extends State<DraftProduction> {
  bool loader = false;
  bool onTapSync = false, onTapDelete = false;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  late UserDatabase database;

  List<ProductionDataEntity> productionDataList = [];
  List<ProductionDataEntity> searchProductionDataList = [];

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
            : productionDataList.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Image.asset('asset/images/no-data.png',height: 25,),
                        Text('no data found')
                      ],
                    ),
                  )
                : Column(
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
                                    child: Image.asset('asset/images/left.png',
                                        height: 30),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Draft Mineral Productions',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSearching = true;
                                        });
                                      },
                                      child: Image.asset(
                                          'asset/images/search .png',
                                          height: 25)),
                                ],
                              ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: productionDataList.length,
                          itemBuilder: (context, index) {
                            var item = productionDataList[index];
                            return Container(
                              margin: const EdgeInsets.all(10.0),
                              height: 250,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.mineralName,
                                        style: const TextStyle(
                                            color: textColor2,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            //navigate to details page by taking the encoded item as an argument
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => DetailProductionMineral(item: item),
                                              ),
                                            );
                                          },
                                          child: Image.asset(
                                            'asset/images/right_arrow.png',
                                            color: Colors.green,
                                          ))
                                    ],
                                  ),
                                  const Text(
                                    '(ROM | G10 | KG)',
                                    style: TextStyle(
                                        color: textColor3,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.5),
                                    thickness: 1,
                                    indent: 3,
                                    endIndent: 280,
                                  ),
                                  Text(
                                    '${item.period} ${item.reportYear}',
                                    style: const TextStyle(
                                        fontSize: 16, color: textColor3),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Ore extracted - ',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        TextSpan(
                                          text:
                                              '${item.oreExtractedQuantity} kg',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight
                                                  .w400), // Change the color to red or any other color you prefer
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Ore processed - ',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        TextSpan(
                                          text:
                                              '${item.oreProcessedQuantity} kg',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight
                                                  .w400), // Change the color to red or any other color you prefer
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Mineral recovered - ',
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        TextSpan(
                                          text: '${item.mineralRecovered} kg',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight
                                                  .w400), // Change the color to red or any other color you prefer
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                          },
                        ),
                      )
                    ],
                  ),
         ),
    );
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
      productionDataList = searchProductionDataList
          .where((element) =>
              element.mineralName
                  .toString()
                  .toUpperCase()
                  .contains(searchValue.toUpperCase()) ||
              element.period
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
      productionDataList = searchProductionDataList ;
      loader = false ;
    });
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

  Future<void> fetchDbData() async {
    var productionDataLists =
        await database.productionDao.retrieveProductionData();
    debugPrint("data length ${productionDataLists.length}");
    if (productionDataLists.isNotEmpty) {
      setState(() {
        productionDataList = productionDataLists;
        searchProductionDataList = productionDataList;
        loader = false;
      });
    } else {
      debugPrint("list is empty no data found in table");
      setState(() {
        loader = false;
      });
    }
  }

  void syncProductionData(int? id, ProductionDataEntity item, int index) {
    var dataId = id;
    try {
      setState(() {
        onTapSync = true;
      });
      //create sync obj from production data obj
      SyncProductionDataEntity syncProductionDataEntity =
          SyncProductionDataEntity(
              userName: item.userName,
              address: item.address,
              reportYear: item.reportYear,
              period: item.period,
              mineralName: item.mineralName,
              mineralType: item.mineralType,
              mineralGreade: item.mineralGreade,
              mineralUnit: item.mineralUnit,
              oreExtractedQuantity: item.oreExtractedQuantity,
              oreProcessedQuantity: item.oreProcessedQuantity,
              recoveredGrade: item.recoveredGrade,
              mineralRecovered: item.mineralRecovered,
              closingStock: item.closingStock,
              remark: item.remark);
      Timer(const Duration(seconds: 3), () {
        //insert data in sync table
        database.syncProductionDao
            .insertSyncProductionData(syncProductionDataEntity);
        //after syncing the data in sync table here i delete the same data from the production table bcz after syncing it is not necessary to show the data again
        database.productionDao.deleteUsProductionData(dataId!);
        setState(() {
          productionDataList.removeAt(index);
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

  deleteProductionData(int? id, int index) {
    try {
      setState(() {
        onTapDelete = true;
      });
      Timer(
        const Duration(seconds: 2),
        () {
          database.productionDao.deleteUsProductionData(id!);
          setState(() {
            productionDataList.removeAt(index);
            onTapDelete = false;
          });
        },
      );
    } catch (e) {
      onTapDelete = false;
      debugPrint("Exception in production data deletion");
    }
  }

  void showSyncDialog(BuildContext context, int id, ProductionDataEntity productionDataEntity, int index) {
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
                syncProductionData(id, productionDataEntity, index);
              },
              child: const Text('Sync'),
            ),
          ],
        );
      },
    );
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
}

