import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maidin_kenya/database/entity/paymentMineralDataEntity.dart';
import 'package:maidin_kenya/draft_payment.dart';
import 'common/colors.dart';
import 'database/database.dart';
import 'database/entity/syncSalesDataEntity.dart';

class PaymentData extends StatefulWidget {
  @override
  _PaymentDataState createState() => _PaymentDataState();
}

class _PaymentDataState extends State<PaymentData> {
  String userName = "Mr. Nelson Odhiambo";
  String userAddress = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';
  String mineralSaleValue ='5000';
  String fullRoyalityValue ='5000';
  String royalityPaid = 'Yes';
  final Color button = colorPrimary;
  DateTime? royalityPaidDate;
  bool loader = false;

  String? pdfName;
  String? pdfPath ;

  List<SyncSalesDataEntity> syncSaleDataList = [];
  List<String> transactionNoList = [];

  late UserDatabase database;

  //sync info
  String? syncSelectedValue;
  SyncSalesDataEntity? syncSalesObject;

  String?saleTransactionNo,
      mineralName,
      mineralType,
      mineralGrade,
      mineralUnit,
      mineralWeight,
      saleDate,
      saleType,
      purchaserName,
      purchaserAddress,
      soldReceivedPrice,
      saleVerifiedPrice,
      deductableValueByMinistry,
      invoiceDoc;


  TextEditingController royalityPaidAmount = TextEditingController();
  TextEditingController royalityLiability = TextEditingController();
  TextEditingController receiptNumber = TextEditingController();


  @override
  void initState() {
    super.initState();
    setState(() {
      loader = true;
    });
    initializeDb();
    fetchDbData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loader? const Center(
          child: CircularProgressIndicator(color: colorPrimary,),
        ):Stack(
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
                            child: Image.asset('asset/images/left.png',
                                height: 30)),
                        const SizedBox(width: 10),
                        const Text(
                          'Add Payment Data',
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
                                  userAddress,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
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
                    const SizedBox(
                      height: 10,
                    ),
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
                      child: DropdownButton<String>(
                        value: syncSelectedValue,
                        onChanged: (String? newValue) async {
                          setState(() {
                            syncSelectedValue = newValue!;
                            loader = true;
                          });
                          await getSyncSalesData(syncSelectedValue);
                        },
                        items: transactionNoList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        isExpanded: true,
                        underline: Container(), // Remove the underline
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mineral Name',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                syncSalesObject!.mineralName,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mineral Type',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                syncSalesObject!.mineralType,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mineral Grade',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                syncSalesObject!.mineralGreade,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mineral Unit',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                syncSalesObject!.mineralUnit,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Mineral Weight',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                syncSalesObject!.mineralWeightController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      const Row(
                        children: [
                          Text(
                            'Sales Info',
                            style: TextStyle(
                                color: textColor2,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '(All price are mentioned in KES)',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      loader
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: colorPrimary,
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: MediaQuery.of(context).size.width * 0.90,
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
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Date of Sale',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        formatDate(syncSalesObject!.selectedDate),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Type of Sale',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        syncSalesObject!.saleTypeController,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        flex: 2,
                                        child: Text(
                                          'Name of the purchaser',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        syncSalesObject!
                                            .namePurchaserController,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        flex: 1,
                                        child: Text(
                                          'Purchaser Address',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        syncSalesObject!.addressPurchaserController,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Flexible(
                                        flex: 2,
                                        child: Text(
                                          'Price received for the sold mineral',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        syncSalesObject!.soldMineralPriceController,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          child: const Text(
                                              "Price of the mineral verified by the ministry during the period of sale",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.grey,
                                              )),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width * 0.4,
                                          child: Text(syncSalesObject!.verifiedMineralPriceController,
                                              textAlign: TextAlign.end,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                   Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                        flex: 1,
                                        child: Text(
                                          'Any applicable deductible as define by the ministry',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        syncSalesObject!.selectedValue,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mineral Sale Value',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '5000',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Full Royality Value',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        '5000',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Royality Paid',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Yes',
                                groupValue: royalityPaid,
                                onChanged: (String? value) {
                                  setState(() {
                                    royalityPaid = value!;
                                  });
                                },
                              ),
                              const Text('Yes'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'No',
                                groupValue: royalityPaid,
                                onChanged: (String? value) {
                                  setState(() {
                                    royalityPaid = value!;
                                  });
                                },
                              ),
                              const Text('No'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Date of Royality Paid',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                              royalityPaidDate == null
                                  ? 'DD-MM-YYYY'
                                  : formatDate(royalityPaidDate!.toString()),
                              style: const TextStyle(
                                  color: textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          GestureDetector(
                              onTap: () => selectDate(context),
                              child: Image.asset(
                                'asset/images/calender_image.png',
                                height: 20,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Royality Paid Amount',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: royalityPaidAmount,
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
                      'Royality Liability',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          controller: royalityLiability,
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
                      'Receipt Number',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                          controller: receiptNumber,
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
                      'Upload Invoice',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(2),
                        dashPattern: const [5, 5],
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 2,
                        child: Container(
                          height: 150,
                          width: 320,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
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
                          ),
                        )
                    ),
                    const SizedBox(height: 70,)
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

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: royalityPaidDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != royalityPaidDate) {
      setState(() {
        royalityPaidDate = picked;
      });
    }
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }

  void initializeDb() async {
    await $FloorUserDatabase
        .databaseBuilder('user_database.db')
        .build()
        .then((value) async {
      setState(() {
        database = value;
      });
    });

    await fetchDbData();
  }

  Future<void> fetchDbData() async {
    var syncData = await database.syncSalesDao.retrieveSyncSalesData();
    if (syncData.isNotEmpty) {
      setState(() {
        syncSaleDataList = syncData;
        // Extract transaction numbers from the retrieved data
        transactionNoList = syncSaleDataList
            .map((draft) => draft.saleTransactionController)
            .toList();
      });
      // Initialize selectedValue with the first item in the list
      if (transactionNoList.isNotEmpty) {
        setState(() {
          syncSelectedValue = transactionNoList[0];
        });
        await getSyncSalesData(syncSelectedValue);
      }
      debugPrint('transactionlist:::::: ${transactionNoList}');
    } else {
      debugPrint("list is empty no data found in sync table");
      setState(() {
        loader = false;
      });
    }
  }

  getSyncSalesData(String? selectedTransactionNo) {
    for (var item in syncSaleDataList) {
      Future.delayed(const Duration(seconds: 3));
      if (selectedTransactionNo?.toLowerCase().toString() ==
          item.saleTransactionController.toLowerCase().toString()) {
          setState(() {
          syncSalesObject = item;
        });
      }
    }
    setState(() {
      loader = false;
    });
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

  Future<void>callSubmitButton()async{
    if(syncSelectedValue == "" || syncSelectedValue== null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the sale transition no.'),backgroundColor: Colors.red,showCloseIcon: true),);
  } else if(royalityPaid == "" || royalityPaid == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the royality paid.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(royalityPaidDate ==""||royalityPaidDate == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the royality paid date.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(royalityPaidAmount.text.toString() == ""){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the royality paid amount.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(royalityLiability.text.toString() == ""){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the royality liability.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(receiptNumber.text.toString() == ""){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select the receipt number.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else if(pdfName == "" || pdfName==null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload invoice.'),backgroundColor: Colors.red,showCloseIcon: true),);
    }else{
      PaymentMineralDataEntity paymentMineralDataEntity = PaymentMineralDataEntity(
        userName: userName,
        userAddress: userAddress,
        saleTransactionNo: syncSalesObject!.saleTransactionController.toString(),
        mineralName: syncSalesObject!.mineralName.toString(),
        mineralType: syncSalesObject!.mineralType.toString(),
        mineralGrade: syncSalesObject!.mineralGreade.toString(),
        mineralUnit: syncSalesObject!.mineralUnit.toString(),
        mineralWeight: syncSalesObject!.mineralWeightController.toString(),
        saleDate: syncSalesObject!.selectedDate.toString(),
        saleType: syncSalesObject!.saleTypeController.toString(),
        purchaserName: syncSalesObject!.namePurchaserController.toString(),
        purchaserAddress: syncSalesObject!.addressPurchaserController.toString(),
        soldReceivedPrice:syncSalesObject!.soldMineralPriceController.toString(),
        saleVerifiedPrice: syncSalesObject!.verifiedMineralPriceController.toString(),
        deductableValueByMinistry: syncSalesObject!.selectedValue.toString(),
        mineralSaleValue: mineralSaleValue.toString(),
        fullRoyalityValue: fullRoyalityValue.toString(),
        royalityPaid: royalityPaid.toString(),
        royalityPaidDate: royalityPaid.toString(),
        royalityPaidAmount: royalityPaidAmount.text.toString(),
        royalityLiability: royalityLiability.text.toString(),
        receiptNumber: receiptNumber.text.toString(),
        invoiceDoc: pdfName.toString()
      );
      debugPrint("inserted data :::::::::::::${paymentMineralDataEntity}");
      await database.paymentMineralDataDao.insertPaymentMineralData(paymentMineralDataEntity);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DraftPayment(),));
    }
}

}
