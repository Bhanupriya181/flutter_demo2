import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maidin_kenya/PDFViewerScreen.dart';

import 'common/colors.dart';

class DetailSalesMineral extends StatefulWidget{
  final dynamic item;
  const DetailSalesMineral({Key? key, required this.item}) : super(key: key);

  @override
  DetailSalesMineralState createState() => DetailSalesMineralState();
}

class DetailSalesMineralState extends State<DetailSalesMineral>{

  String userName = "Mr. Nelson Odhiambo";
  String address = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('asset/images/left.png', height: 30)),
                    const SizedBox(width: 8),
                    const Text('View Mineral Sales Data',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.0,right: 15.0),
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
                            widget.item.userName,
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
                            widget.item.address,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
              margin: const EdgeInsets.all(10.0),
              height: MediaQuery.of(context).size.height * 0.70,
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
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         widget.item.mineralName,
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
                         child: const Center(
                           child: Text('3200 MT',
                             style: TextStyle(
                                 color: salesTextColor
                             ),
                           ),
                         ),
                       ),
                     ],
                    ),
                    const SizedBox(height: 2,),
                    const Text(
                      '(ROM | G10 | KG)',
                      style: TextStyle(
                          color: textColor3,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.5),
                      thickness: 1,
                      indent: 3,
                      endIndent: 250,
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Date of Sale',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          formatDate(widget.item.selectedDate),
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sale Transaction No.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                             showPDF(context, widget.item.pdfName);
                          },
                          child: Text(
                            widget.item.saleTransactionController,
                            style: const TextStyle(fontSize: 17,color: textColor2,
                                decoration: TextDecoration.underline,
                            decorationColor: textColor2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      children: [
                        const Flexible(
                         flex:2,
                          child: Text(
                            'Price Received for the sold mineral',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          widget.item.soldMineralPriceController,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      children: [
                        const Flexible(
                          flex:2,
                          child: Text(
                            'Price of the mineral Verified during the period of sale',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          widget.item.verifiedMineralPriceController,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex:2,
                          child: Text(
                            'Type of Sale',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          widget.item.saleTypeController,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex:2,
                          child: Text(
                            'Name of the purchaser',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          widget.item.namePurchaserController,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex:1,
                          child: Text(
                            'Address of the purchaser',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                         widget.item.addressPurchaserController,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(width: MediaQuery.of(context).size.width * 0.35,
                            child: const Text(
                                "Forex exchange rate for minerals exported",
                                textAlign:
                                TextAlign.left,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.grey,)),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(
                                context)
                                .size
                                .width *
                                0.4,
                            child: const Text(
                                'N/A',
                                textAlign: TextAlign.end,
                                style: TextStyle(fontSize: 17.0,)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          flex:1,
                          child: Text(
                            'Any applicable deductible as define by the ministry',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          widget.item.selectedValue,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
              Container(
                margin: const EdgeInsets.only(left: 10.0,right: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 4,
                decoration: BoxDecoration(
                  color: submitBtn,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Center(
                  child: Text(
                    'Update Payment Info',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
             ],
          ),
        )
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }

  void showPDF(BuildContext context, String pdfPath) {
    debugPrint("PDF Path: $pdfPath");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerScreen(path: pdfPath),
      ),
    );
  }
}


