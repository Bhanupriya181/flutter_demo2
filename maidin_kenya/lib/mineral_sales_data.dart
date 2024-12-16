import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:maidin_kenya/database/entity/salesDataEntity.dart';
import 'package:maidin_kenya/draft_sales.dart';
import 'common/colors.dart';
import 'package:http/http.dart' as http;

import 'database/database.dart';
import 'model/AddProductionData.dart';

class MineralSalesData extends StatefulWidget {
  @override
  _MineralSalesDataState createState() => _MineralSalesDataState();
}

class _MineralSalesDataState extends State<MineralSalesData> {

  String fileName = "";
  String? pdfName;
  String? pdfPath ;
  DateTime? selectedDate;

  String selectedValue = 'Option 1';
  String userName = "Mr. Nelson Odhiambo";
  String address = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';
  bool loader = false;
  late UserDatabase database;

  String? selectedYear,
      selectedMineralName,
      selectedPeriod,
      selectedMineralType,
      selectedMineralType1,
      mineralGrade,
      recoveredGrade,
      mineralUnit,
      societyId,
      societyName;

  TextEditingController saleTransactionController = TextEditingController();
  TextEditingController mineralWeightController = TextEditingController();
  TextEditingController soldMineralPriceController = TextEditingController();
  TextEditingController verifiedMineralPriceController = TextEditingController();
  TextEditingController saleTypeController = TextEditingController();
  TextEditingController namePurchaserController = TextEditingController();
  TextEditingController addressPurchaserController = TextEditingController();
  TextEditingController exportedMineralController = TextEditingController();

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
    initializeDb() ;
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                            child: Image.asset('asset/images/left.png', height: 30)),
                        const SizedBox(width: 10),
                        const Text(
                          'Mineral Sales Data',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 30),
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
                          'Date of Sale',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'DD-MM-YYYY'
                                    : formatDate(selectedDate!),
                                style: TextStyle(
                                    color: textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () => selectDate(context),
                                child: Image.asset(
                                  'asset/images/calender_image.png',
                                  height: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Sale transaction no.',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: saleTransactionController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Minerals Info',
                          style: TextStyle(
                              color: textColor2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Mineral',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Mineral Type',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Mineral Grade',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Mineral Unit',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Mineral Weight',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: mineralWeightController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Sales Info',
                          style: TextStyle(
                              color: textColor2,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Price required for the sold Minerals (in KES)',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: soldMineralPriceController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Price of the mineral verified by the Ministry during the Period of sale (in KES)',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: verifiedMineralPriceController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Type of Sale',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller:saleTypeController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Purchaser Type',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: societyId,
                              hint: const Text('Select'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  societyId =
                                      newValue.toString();
                                });
                              },
                              items: globalCoOperativeSocietyData
                                  ?.map<DropdownMenuItem<String>>(
                                      (CoOperativeSocietyData  year) {
                                    return DropdownMenuItem<String>(
                                      value: year.societyId,
                                      child: Text(year.societyId.toString()),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Purchaser License Code',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: societyName,
                              hint: const Text('Select'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  societyName=
                                      newValue.toString();
                                });
                              },
                              items: globalCoOperativeSocietyData
                                  ?.map<DropdownMenuItem<String>>(
                                      (CoOperativeSocietyData  year) {
                                    return DropdownMenuItem<String>(
                                      value: year.societyName,
                                      child: Text(year.societyName.toString()),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Name of the Purchaser',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: namePurchaserController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Address of the Purchaser',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: addressPurchaserController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Forex Exchange rate for Mineral exported',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                              controller: exportedMineralController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Any Applicable documents as defined by the Ministry (in KES)',
                              style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedValue,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedValue = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Option 1',
                                    'Option 2',
                                    'Option 3',
                                    'Option 4'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                  underline:
                                      Container(), // Remove the underline
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              flex: 2,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.3,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                  fileName.toString().isEmpty
                                      ? "No doc"
                                      : fileName.toString(),
                                  style: TextStyle(
                                      fontSize: fileName.toString().isEmpty ? 16 : 10),
                                )
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  await pickFile();
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.height * 0.07,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.035,
                                    ),
                                    border: Border.all(color: textColor2),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: textColor2,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Upload sales Invoice',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        DottedBorder(
                            borderType: BorderType.RRect,
                            radius:  const Radius.circular(2),
                            dashPattern: const [5, 5],
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              height: 150,
                              child: Stack(
                                children: [
                                        pdfName != null ? Positioned(top: 0,right: 0,child: Container(
                                          padding: const EdgeInsets.all(7),
                                          child: GestureDetector(
                                            onTap: (){
                                             setState(() {
                                               pdfName = null ;
                                             });
                                            },
                                              child: const Icon(Icons.delete_outline,color: Colors.red,size: 17,)),
                                        )) :Container(),
                                        Center(
                                          child: pdfName != null ?
                                              GestureDetector(
                                                onTap: (){
                                                  //open pdf view
                                                 if( pdfPath != null) {
                                                    openPdf(pdfPath);
                                                  } else {
                                                   //snackbar to show pdf path is null
                                                 }

                                                },
                                                child: Text(pdfName.toString()),
                                              )
                                              :Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    await pickPdf();
                                                  },
                                                  child: Image.asset(
                                                    "asset/images/upload.png",
                                                    color: Color(0xFFE94C19),
                                                    height: 50,
                                                  )),
                                              const Text(
                                                "Click to upload Documents",
                                                style: TextStyle(
                                                    color: Color(0xFFE94C19),
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              const Text(
                                                "Maximum file size 5mb",
                                                style: TextStyle(
                                                    color: Color(0xFF555653),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                              )
                            )
                          ),
                        const SizedBox(height: 80),
                      ],
                    )
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

  Future<void> pickFile() async {
    // Open the file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        // Update the file name to show in the first container
        fileName = result.files.first.name.toString();
        debugPrint("picked file::::${result.files.first.name.toString()}");
      });
    }
    debugPrint("picked file::::${result?.files.first.name.toString()}");
  }

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        pdfName = result.files.first.name.toString(); // Get the selected PDF file path
        pdfPath = result.files.first.path ;
        debugPrint("Selected PDF name: ${result.files.first.name}");
        debugPrint("Selected PDF Path: ${pdfPath}");
      });
    } else {
      debugPrint("No file selected");
    }
  }

  void openPdf(String? pdfPath) {

  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
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
    if (selectedDate == "" || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add date.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (saleTransactionController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add sale transaction no.'),backgroundColor: Colors.red,showCloseIcon: true),);
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
    } else if (mineralWeightController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add mineral weight.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (soldMineralPriceController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add sold minerals in KES.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (verifiedMineralPriceController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add verified mineral in KES.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (saleTypeController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add type of Sale.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if (societyId == "" || societyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add purchaser type.'),backgroundColor: Colors.red,showCloseIcon: true),);
    } else if(societyName == "" || societyName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add purchaser license code'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(namePurchaserController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add purchaser name'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(addressPurchaserController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add purchaser address'),backgroundColor: Colors.red,showCloseIcon: true),);
    }
    else if(exportedMineralController.text.toString() == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add exported mineral'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(selectedValue == "" || selectedValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add applicable document'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(fileName == "" || fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add the document'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(pdfName == "" || pdfName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add the document'),backgroundColor: Colors.red,showCloseIcon: true),);
    }
    else {
      SalesDataEntity dataEntity = SalesDataEntity(
          userName: userName,
          address: address,
          selectedDate: selectedDate.toString(),
          saleTransactionController: saleTransactionController.text.toString(),
          mineralName: selectedMineralName.toString(),
          mineralType: selectedMineralType.toString(),
          mineralGreade: mineralGrade.toString(),
          mineralUnit: mineralUnit.toString(),
          mineralWeightController: mineralWeightController.text.toString(),
          soldMineralPriceController: soldMineralPriceController.text.toString(),
          verifiedMineralPriceController: verifiedMineralPriceController.text.toString(),
          saleTypeController: saleTypeController.text.toString(),
          societyId: societyId.toString(),
          societyName: societyName.toString(),
          namePurchaserController: namePurchaserController.text.toString(),
          addressPurchaserController: addressPurchaserController.text.toString(),
          exportedMineralController: exportedMineralController.text.toString(),
          selectedValue: selectedValue.toString(),
          fileName: fileName.toString(),
          pdfName: pdfPath.toString()
      );
      await database.salesDataDao.insertSalesData(dataEntity);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DraftSales(),));
    }
  }

  void initializeDb() async{
   await $FloorUserDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      database = value;
      // await this.addUsers(this.database);
      setState(() {});
    });
  }

}
