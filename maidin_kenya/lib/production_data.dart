import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maidin_kenya/common/colors.dart';
import 'package:http/http.dart' as http;
import 'package:maidin_kenya/database/database.dart';
import 'package:maidin_kenya/database/entity/productionDataEntity.dart';
import 'package:maidin_kenya/draft_production.dart';
import 'model/AddProductionData.dart';

class ProductionData extends StatefulWidget {
  const ProductionData({super.key});

  @override
  _ProductionDataState createState() => _ProductionDataState();
}

class _ProductionDataState extends State<ProductionData> {
  String? selectedYear,
      selectedMineralName,
      selectedPeriod,
      selectedMineralType,
      selectedMineralType1,
      mineralGrade,
      recoveredGrade,
      mineralUnit;

  TextEditingController oreExtractedController = TextEditingController();
  TextEditingController oreProcessedController = TextEditingController();
  TextEditingController mineralRecoveredController = TextEditingController();
  TextEditingController closingStockController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  bool loader = false;
  late UserDatabase database;

  String userName = "Mr. Nelson Odhiambo";
  String address = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';

  List<MineralData>? globalMineralData;
  List<UnitData>? globalUnitData;
  List<CoOperativeSocietyData>? globalCoOperativeSocietyData;
  List<YearData>? globalYearData;
  List<PeriodData>? globalPeriodData;

  @override
  void initState() {
    super.initState();
    setState(() {
      loader = true;
    });
    initializeDb();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80.0),
              // Add some padding to avoid overlap with the button
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('asset/images/left.png',
                                height: 30)),
                        const SizedBox(width: 10),
                        const Text(
                          'Add Mineral Production Data',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: homeText2.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'asset/images/people .png',
                                height: 25,
                                color: textColor2,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  userName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Image.asset(
                                'asset/images/location.png',
                                height: 25,
                                color: textColor2,
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  address,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    loader
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: colorPrimary,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Report Year',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedYear,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedYear = newValue.toString();
                                      });
                                    },
                                    items: globalYearData
                                        ?.map<DropdownMenuItem<String>>(
                                            (YearData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.year,
                                        child: Text(year.year.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Period',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedPeriod,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedPeriod = newValue.toString();
                                      });
                                    },
                                    items: globalPeriodData
                                        ?.map<DropdownMenuItem<String>>(
                                            (PeriodData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.period,
                                        child: Text(year.period.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Minerals Info',
                                style: TextStyle(
                                    color: textColor2,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 25),
                              const Text(
                                'Mineral',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedMineralName,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMineralName =
                                            newValue.toString();
                                      });
                                    },
                                    items: globalMineralData
                                        ?.map<DropdownMenuItem<String>>(
                                            (MineralData data) {
                                      return DropdownMenuItem<String>(
                                        value: data.mineralName,
                                        child:
                                            Text(data.mineralName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Mineral Type',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedMineralType,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMineralType =
                                            newValue.toString();
                                      });
                                    },
                                    items: globalMineralData
                                        ?.map<DropdownMenuItem<String>>(
                                            (MineralData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.mineralID,
                                        child: Text(year.mineralID.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Mineral Grade',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedMineralType1,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMineralType1 =
                                            newValue.toString();
                                      });
                                    },
                                    items: globalMineralData
                                        ?.map<DropdownMenuItem<String>>(
                                            (MineralData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.mineralID,
                                        child: Text(year.mineralID.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Mineral Unit',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: mineralUnit,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        mineralUnit = newValue.toString();
                                      });
                                    },
                                    items: globalUnitData
                                        ?.map<DropdownMenuItem<String>>(
                                            (UnitData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.unitName,
                                        child: Text(year.unitName.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Quantity of ore extracted',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: oreExtractedController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Quantity of ore processed',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: oreProcessedController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Recovered Grade',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: recoveredGrade,
                                    hint: const Text('Select'),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        recoveredGrade = newValue.toString();
                                      });
                                    },
                                    items: globalCoOperativeSocietyData
                                        ?.map<DropdownMenuItem<String>>(
                                            (CoOperativeSocietyData year) {
                                      return DropdownMenuItem<String>(
                                        value: year.societyId,
                                        child: Text(year.societyId.toString()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Quantity of mineral recovered',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: mineralRecoveredController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Closing Stock',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: closingStockController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Description',
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.95,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: remarkController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
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
            Positioned(
              bottom: 1,
              left: 10,
              right: 10,
              child: GestureDetector(
                onTap: () async {
                  await callSubmitButton();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 4,
                  decoration: BoxDecoration(
                    color: submitBtn,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    final url =
        Uri.parse('https://my.api.mockaroo.com/users.json?key=24cb3650&');
    final headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        final data = addProductionDataFromJson(response.body);
        debugPrint("response body ::::::::::::${jsonEncode(data)}");

        //check data accessed or not?
        /*final mineralDataList = data.mineralData;
        final unitDataList = data.unitData;
        final coOperativeSocietyDataList = data.coOperativeSocietyData;
        final yearDataList = data.yearData;
        final periodDataList = data.periodData;

        debugPrint("Mineral Data: ${mineralDataList?.map((e) => e.toJson()).toList()}");
        debugPrint("Unit Data: ${unitDataList?.map((e) => e.toJson()).toList()}");
        debugPrint("CoOperative Society Data: ${coOperativeSocietyDataList?.map((e) => e.toJson()).toList()}");
        debugPrint("Year Data: ${yearDataList?.map((e) => e.toJson()).toList()}");
        debugPrint("Period Data: ${periodDataList?.map((e) => e.toJson()).toList()}");*/

        setState(() {
          // Store data in global variables
          globalMineralData = data.mineralData;
          globalUnitData = data.unitData;
          globalCoOperativeSocietyData = data.coOperativeSocietyData;
          globalYearData = data.yearData;
          globalPeriodData = data.periodData;
          loader = false;
        });
      } else {
        setState(() {
          loader = false;
        });
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> callSubmitButton() async {
    if (selectedYear == "" || selectedYear == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add selected year.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (selectedPeriod == "" || selectedPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add selected period.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (selectedMineralName == "" || selectedMineralName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral name.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (selectedMineralType == "" || selectedMineralType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral type.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (selectedMineralType1 == "" || selectedMineralType1 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral grade.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (mineralUnit == "" || mineralUnit == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral unit.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (oreExtractedController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add ore extracted in unit.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (oreProcessedController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add ore processed in unit.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (recoveredGrade == "" || recoveredGrade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add recovered grade in unit.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (mineralRecoveredController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral recovered qty.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (closingStockController.text.toString() =="") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add closing stock qty.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if(remarkController.text.toString() ==  "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add description'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else {
      ProductionDataEntity dataEntity = ProductionDataEntity(
          userName: userName,
          address: address,
          reportYear: selectedYear.toString(),
          period: selectedPeriod.toString(),
          mineralName: selectedMineralName.toString(),
          mineralType: selectedMineralType.toString(),
          mineralGreade: mineralGrade.toString(),
          mineralUnit: mineralUnit.toString(),
          oreExtractedQuantity: oreExtractedController.text.toString(),
          oreProcessedQuantity: oreProcessedController.text.toString(),
          recoveredGrade: recoveredGrade.toString(),
          mineralRecovered: mineralRecoveredController.text.toString(),
          closingStock: closingStockController.text.toString(),
          remark: remarkController.text.toString()
      );
      await database.productionDao.insertProductionData(dataEntity);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DraftProduction(),));
    }
  }

  void initializeDb() {
    $FloorUserDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
      // await this.addUsers(this.database);
      setState(() {});
    });
  }
}
