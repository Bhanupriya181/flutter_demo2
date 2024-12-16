import 'package:flutter/material.dart';
import 'common/colors.dart';
import 'database/database.dart';
import 'database/entity/syncProductionDataEntity.dart';

class SyncProduction extends StatefulWidget{
  const SyncProduction({super.key});

  @override
  _SyncProductionState createState() => _SyncProductionState();
}

class _SyncProductionState extends State<SyncProduction> {

  late UserDatabase database;
  bool loader = false;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  List<SyncProductionDataEntity> syncProductionDataList = [];
  List<SyncProductionDataEntity> searchProductionDataList = [];

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
                margin: const EdgeInsets.only(top: 10),
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
                :Row(
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
                      'View Mineral Productions',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 40,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          isSearching = true;
                        });
                      },
                        child: Image.asset('asset/images/search .png', height: 25)),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              Expanded(
                  child: ListView.builder(
                    itemCount: syncProductionDataList.length,
                    itemBuilder: (context, index) {
                      var item = syncProductionDataList[index];
                  return Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 200,
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
                          Text(item.mineralName,style: const TextStyle(color: textColor2,fontSize: 22,fontWeight: FontWeight.w500),),
                          Image.asset('asset/images/right_arrow.png',color: Colors.green,)
                        ],
                      ),
                      const Text('(ROM | G10 | KG)',style: TextStyle(color: textColor3,fontWeight: FontWeight.w400,fontSize: 17),),
                      const SizedBox(height: 5,),
                      Divider(color: Colors.grey.withOpacity(0.5),
                        thickness: 1,
                        indent: 3,
                        endIndent: 280,),
                      Text('${item.period} ${item.reportYear}',style: const TextStyle(fontSize: 16,color:textColor3 ),),
                      const SizedBox(height: 5,),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Ore extracted - ',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextSpan(
                              text: '${item.oreExtractedQuantity} kg',
                              style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400), // Change the color to red or any other color you prefer
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2,),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Ore processed - ',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextSpan(
                              text: '${item.oreProcessedQuantity} kg',
                              style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400), // Change the color to red or any other color you prefer
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2,),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Mineral recovered - ',
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            TextSpan(
                              text: '${item.mineralRecovered} kg',
                              style: const TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w400), // Change the color to red or any other color you prefer
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },)
              ),
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
      syncProductionDataList = searchProductionDataList
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
      syncProductionDataList = searchProductionDataList ;
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
    var syncData = await database.syncProductionDao.retrieveSyncProductionData();
    if (syncData.isNotEmpty) {
      setState(() {
        syncProductionDataList = syncData;
        searchProductionDataList = syncProductionDataList;
        loader = false;
      });
      debugPrint("sync Data length::::::::::::::: ${syncProductionDataList.length}");
    } else {
      debugPrint("list is empty no data found in sync table");
      setState(() {
        loader = false;
      });
    }
  }
}


