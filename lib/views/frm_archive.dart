import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';
import 'package:gold_swing/models/model_metal.dart';
import 'package:gold_swing/views/custom_widgets/cust_appbar.dart';
import 'package:gold_swing/views/custom_widgets/cust_archive_content.dart';
import 'package:gold_swing/views/custom_widgets/cust_label_with_icon.dart';
import 'package:gold_swing/views/custom_widgets/cust_rich_text.dart';
import '../ihelper/hive_helper.dart';
import 'custom_widgets/cust_drawer.dart';

class FrmArchive extends StatefulWidget {
  const FrmArchive({super.key, required this.category});

  final String category;

  @override
  State<FrmArchive> createState() => _FrmArchiveState();
}

class _FrmArchiveState extends State<FrmArchive> {
  List<ModelMetal> archiveList = [];

  @override
  void initState() {
    super.initState();

    //debugPrint('>> frmArchive category: ${widget.category}');

    getAllRecordsByCategpry();
  }

  @override
  void dispose() {
    super.dispose();
    archiveList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustAppBar(title: 'Gold Swing - Archive', isSyncVisible: false),
      backgroundColor: Colors.black,

      body: ListView.builder(
        padding: const EdgeInsets.only(left: 8, right: 8),
        itemCount: archiveList.length,
        itemBuilder: (context, index) {
          return CustArchiveContent(
            shortCut: archiveList[index].metal,
            gram: 'Gram 21K',
            price: archiveList[index].priceGram21K,
            change: archiveList[index].ch,
            date: SharedMethods.convertTimesTampToDateTime(
              archiveList[index].timestamp,
            ),
            onTap: () {
              openModelsheet(context, archiveList[index]);
            },
          );
        },
      ),

      // Drawer
      drawer: CustDrawer(),
    );
  }

  Future<void> openModelsheet(
    BuildContext context,
    ModelMetal selRecord,
  ) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          //height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Metal and change price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    selRecord.metal.toLowerCase() == 'gold'
                        ? 'assets/images/gold1.gif'
                        : 'assets/images/silver.gif',
                    width: 75,
                  ),

                  CustLabelWithIcon(change: selRecord.ch),
                ],
              ),

              SizedBox(height: 8),

              // Ask and Bid price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustRichText(
                    firstText: 'Ask',
                    firstTextColor: Colors.white70,
                    secondText: selRecord.ask.toStringAsFixed(2),
                    secondTextColor: Colors.white70,
                    textSize: 20,
                  ),

                  CustRichText(
                    firstText: 'Bid',
                    firstTextColor: Colors.white70,
                    secondText: selRecord.bid.toStringAsFixed(2),
                    secondTextColor: Colors.white70,
                    textSize: 20,
                  ),
                ],
              ),
              Divider(color: Colors.white30, thickness: 0.5),

              // 10k and 14k price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustRichText(
                    firstText: 'Gram 10K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram10K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),

                  CustRichText(
                    firstText: 'Gram 14K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram14K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),
                ],
              ),
              Divider(color: Colors.white30, thickness: 0.5),

              // 16k and 18k price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustRichText(
                    firstText: 'Gram 16K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram16K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),

                  CustRichText(
                    firstText: 'Gram 18K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram18K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),
                ],
              ),
              Divider(color: Colors.white30, thickness: 0.5),

              // 20k and 21k price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustRichText(
                    firstText: 'Gram 20K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram20K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),

                  CustRichText(
                    firstText: 'Gram 21K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram21K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),
                ],
              ),
              Divider(color: Colors.white30, thickness: 0.5),

              // 22k and 24k price section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustRichText(
                    firstText: 'Gram 22K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram22K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),

                  CustRichText(
                    firstText: 'Gram 24K',
                    firstTextColor: Colors.white,
                    secondText: selRecord.priceGram24K.toStringAsFixed(2),
                    secondTextColor: Colors.white,
                    textSize: 16,
                  ),
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  //debugPrint('>>> Archive selected 24k price: ${selRecord.priceGram24K}');

                  String statusCode =
                      HiveHelper.deleteRecord(selRecord).toString();
                  //debugPrint('>>> Archive statusCode: $statusCode');
                  if (statusCode == "200") {
                    // Success
                    SharedMethods.msgOperationResult(
                      context,
                      "Record was deleted successfuly.",
                      Colors.green,
                    );

                    getAllRecordsByCategpry();
                  } else {
                    // Error while deleting
                    SharedMethods.msgOperationResult(
                      context,
                      statusCode,
                      Colors.red,
                    );
                  }
                  Navigator.pop(context);
                  //Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 40),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  iconSize: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void getAllRecordsByCategpry() {
    setState(() {
      archiveList.clear();
      archiveList = HiveHelper.selectAllRecords(categoryName: widget.category);
    });
  }
}
