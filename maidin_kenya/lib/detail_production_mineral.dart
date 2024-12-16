import 'package:flutter/material.dart';
import 'common/colors.dart';



class DetailProductionMineral extends StatefulWidget {
  final dynamic item;

  const DetailProductionMineral({Key? key, required this.item}) : super(key: key);

  @override
  _DetailProductionMineralState createState() => _DetailProductionMineralState();
}

class _DetailProductionMineralState extends State<DetailProductionMineral> {
  String userName = "Mr. Nelson Odhiambo";
  String address = '5th Floor NHIF Building Ragati Road P.O Box 34670 - 00100. Nairobi - Kenya.';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Row(
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
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.2),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0,right: 15.0),
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
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.all(10.0),
                height: MediaQuery.of(context).size.height * 0.30,
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
                    Text(
                      widget.item.mineralName,
                      style: const TextStyle(
                          color: textColor2,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
                      endIndent: 255,
                    ),
                    Text(
                      '${widget.item.period} ${widget.item.reportYear}',
                      style: const TextStyle(
                          fontSize: 15, color: textColor3),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Recovered Grade- ',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                          TextSpan(
                            text: '${widget.item.recoveredGrade} kg',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Closing Stock- ',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 16),
                          ),
                          TextSpan(
                            text: '${widget.item.closingStock} kg',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
