import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'common/colors.dart';

class DetailPaymentMineral extends StatefulWidget{

  final dynamic item;
  const DetailPaymentMineral({Key? key, required this.item}) : super(key: key);

  @override
  _DetailPaymentMineralState createState() => _DetailPaymentMineralState();
}

class _DetailPaymentMineralState extends State<DetailPaymentMineral>{
  String userName = "Mr. Nelson Odhiambo";
  String address = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';
  DateTime? royalityPaidDate;


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
                    const Text('View Payment Data',
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
                            widget.item.userAddress,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.75,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          widget.item.mineralName,
                          style: TextStyle(
                              color: textColor2,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: colorPrimary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text('PENDING',
                              style: TextStyle(
                                  color: salesTextColor
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      '(ROM | G10)',
                      style: TextStyle(
                          color: textColor3,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                    const SizedBox(height: 2,),
                     Divider(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date of Sale',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                         formatDate(widget.item.saleDate),
                          style: TextStyle(fontSize: 17),
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
                        Text(
                          widget.item.saleTransactionNo,
                          style: TextStyle(fontSize: 17,color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Purchaser Details',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          'Harison, Baringo',
                          style: TextStyle(fontSize: 17,color: Colors.black),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      children: [
                        Flexible(
                          flex:2,
                          child: Text(
                            'Mineral Qty & Sale Value',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Text(
                          '50 x 100= 5000',
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Full Royality Value',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "50 x 100= 5000",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Royality Paid',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          widget.item.royalityPaid,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Text(
                          'Date of Royality Paid',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                         widget.item.royalityPaidDate,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Royalty Paid Amount',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          widget.item.royalityPaidAmount,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Receipt Number',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          // onTap: (){
                          //   showPDF(context, widget.item.pdfName);
                          // },
                          child: const Text(
                            // widget.item.saleTransactionController,
                            'View Invoice',
                            style: TextStyle(fontSize: 17,color: textColor2,
                                decoration: TextDecoration.underline,
                                decorationColor: textColor2),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Royalty Liability',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "100",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Late Pay Amount',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "100",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Apply for Waiver',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          // onTap: (){
                          //   showPDF(context, widget.item.pdfName);
                          // },
                          child: const Text(
                            // widget.item.saleTransactionController,
                            'Request to Authority',
                            style: TextStyle(fontSize: 17,color: textColor2,
                                decoration: TextDecoration.underline,
                                decorationColor: textColor2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12,),
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
                    'Pay Now',
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
        ),
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('d MMMM yyyy').format(date);
  }
}