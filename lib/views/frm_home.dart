import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_swing/ihelper/hive_helper.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';
import 'package:gold_swing/models/model_metal.dart';
import 'package:gold_swing/repo/current_price_cubit.dart';
import 'package:gold_swing/views/custom_widgets/cust_appbar.dart';
import 'package:gold_swing/views/custom_widgets/cust_gram_container.dart';
import 'package:gold_swing/views/custom_widgets/cust_label_normal.dart';
import 'package:gold_swing/views/custom_widgets/cust_metal_slider.dart';
import '../ihelper/shared_variables.dart';
import 'custom_widgets/cust_drawer.dart';
import 'custom_widgets/cust_rich_text.dart';

class FrmHome extends StatefulWidget {
  const FrmHome({super.key, required this.title});

  final String title;

  @override
  State<FrmHome> createState() => _FrmHomeState();
}

class _FrmHomeState extends State<FrmHome> {
  String selectedMetal = 'Gold';
  String selectedMetalShortCut = 'XAU';
  String selectedAnimation = 'assets/images/gold1.gif';
  //int testIndex = 0;

  ModelMetal currentRecord = ModelMetal(
    /*timestamp: 0,
    metal: 'XAU',
    currency: 'EGP',
    exchange: 'XAU',
    symbol: 'XAU',
    openTime: 0,
    price: 1000.00,
    ch: 1,
    ask: 1000.00,
    bid: 1000.00,
    priceGram24K: 1000.00,
    priceGram22K: 1000.00,
    priceGram21K: 1000.00,
    priceGram20K: 1000.00,
    priceGram18K: 1000.00,
    priceGram16K: 1000.00,
    priceGram14K: 1000.00,
    priceGram10K: 1000.00,
    recordID: 0,*/
  );

  Future<void> getLastRecord(BuildContext ctx) async {
    await ctx.read<CurrentPriceCubit>().getLastRecordByCategory(selectedMetal);
  }

  @override
  void initState() {
    super.initState();

    // Get the last record for the selected metal category
    //getLastRecordByCategory();
    //await context.read()<CurrentPriceCubit>().get;
    getLastRecord(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustAppBar(
        title: widget.title,
        isSyncVisible: true,
        onSyncPressed: () async {
          // Step 1 check internet connectivity
          bool isInternetWorking = await SharedMethods.isInternetWorking();
          if (isInternetWorking == false) {
            SharedMethods.msgOperationResult(
              // ignore: use_build_context_synchronously
              context,
              "No internet connection",
              Colors.black,
            );
            return;
          }

          // Step 2 check if there is api key saved in shared_preferences or not
          String curSavedKey = await SharedMethods.apiKeyGet(
            mySharedPrefApiKey,
          );
          if (curSavedKey == '') {
            SharedMethods.msgOperationResult(
              // ignore: use_build_context_synchronously
              context,
              "You don't have a private key, open (how to use?) screen!",
              Colors.black,
            );
            return;
          }

          // Step 3 call api
          //currentRecord = await DioHelper().selectRecord(selectedMetalShortCut);
          // ignore: use_build_context_synchronously
          currentRecord = await context
              .read<CurrentPriceCubit>()
              .getCurrentPrice(selectedMetalShortCut);

          if (currentRecord.responseMsg != '200') {
            SharedMethods.msgOperationResult(
              // ignore: use_build_context_synchronously
              context,
              currentRecord.responseMsg,
              Colors.red,
            );
            return;
          } else {
            // Step 4 Save new metal rcord
            HiveHelper.addRecord(currentRecord).then((value) {
              if (value > 0) {
                SharedMethods.msgOperationResult(
                  // ignore: use_build_context_synchronously
                  context,
                  "Record was saved successfuly",
                  Colors.green,
                );
              } else {
                SharedMethods.msgOperationResult(
                  // ignore: use_build_context_synchronously
                  context,
                  "Record was not saved",
                  Colors.red,
                );
              }
            });
          }

          setState(() {
            //testIndex++;
          });
        },
      ),

      body: BlocBuilder<CurrentPriceCubit, CurrentPriceState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(left: 8, right: 8),
            children: [
              // Metal category horizontal list
              metalSlider(),

              // Metal prices
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                //height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //color: const Color.fromRGBO(255, 255, 255, 0.9),
                  color: Colors.white,
                ),

                child:
                    state is CurrentPriceLoading
                        ? Center(
                          child: Image.asset(
                            'assets/images/Loading.gif',
                            width: 100,
                          ),
                        )
                        : state is CurrentPriceSuccess
                        ? metalDifferentPrices(state.modelMetal)
                        : state is CurrentPriceError
                        ? metalDifferentPrices(state.modelMetal)
                        : Center(child: Text('Unknown State')),
              ),
            ],
          );
        },
      ),

      // Drawer
      drawer: CustDrawer(),
    );
  }

  // Get the last record for the selected metal category
  void getLastRecordByCategory1() async {
    getLastRecord(context);

    /*  await context.read<CurrentPriceCubit>().getLastRecordByCategory(
      selectedMetal,
    );
   
    HiveHelper.selectOne(selectedMetal).then((value) {
      setState(() {
        currentRecord = value;
      });
    });
    */
  }

  // Horizontal Slider
  Widget metalSlider() {
    return SizedBox(
      height: 125,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        alignment: Alignment.center,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: metalCategories.length,
          itemBuilder: (context, index) {
            return CustMetalSlider(
              metal: metalCategories[index]['name'],
              selectedMetal: selectedMetal,
              image: metalCategories[index]['image'],
              onTap: () {
                selectedMetal = metalCategories[index]['name'];
                selectedMetalShortCut = metalCategories[index]['shortCut'];
                selectedAnimation = metalCategories[index]['animation'];

                /*
                context.read<CurrentPriceCubit>().getLastRecordByCategory(
                  selectedMetal,
                );
                */
                // getLastRecord(context);
                //getLastRecordByCategory();
                currentRecord = context
                    .read<CurrentPriceCubit>()
                    .getLastRecordByCategory(selectedMetal);
                metalDifferentPrices(currentRecord);
                //debugPrint('>> metal: ${metalCategories[index]['name']} >> selectedMetal: $selectedMetal',);

                //setState(() {});
              },
            );
          },
        ),
      ),
    );
  }

  // Main metal info
  Widget metalMainInfo({
    required String date,
    required double lastPrice,
    required double change,
    required double ask,
    required double bid,
  }) {
    return // Metal main info
    Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date
          CustLabelNormal(text: lastPrice > 0 ? date : ''),

          const SizedBox(height: 12),

          // Last price & change
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metal name
              CustRichText(
                firstText: 'Last Price',
                secondText: lastPrice.toStringAsFixed(2),
              ),

              // Metal change
              CustRichText(
                firstText: 'Change',
                secondText: change.toStringAsFixed(2),
                secondTextColor: change > 0 ? Colors.green : Colors.red,
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Ask & bid price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Metal name
              CustRichText(
                firstText: 'Ask',
                secondText: ask.toStringAsFixed(2),
              ),

              // Metal change
              CustRichText(
                firstText: 'Bid',
                secondText: bid.toStringAsFixed(2),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Metal prices
  Widget metalDifferentPrices(ModelMetal selectedRecord) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Animated image
        SizedBox(
          height: 150,
          width: 250,
          child: Image.asset(selectedAnimation, width: 250),
        ),

        metalMainInfo(
          date: SharedMethods.convertTimesTampToDateTime(
            selectedRecord.timestamp,
          ),
          lastPrice: selectedRecord.price,
          change: selectedRecord.ch,
          ask: selectedRecord.ask,
          bid: selectedRecord.bid,
        ),

        const SizedBox(height: 8),

        // Metal prices
        CustGramContainer(text: 'Gram 24k', price: selectedRecord.priceGram24K),
        CustGramContainer(text: 'Gram 22k', price: selectedRecord.priceGram22K),
        CustGramContainer(text: 'Gram 21k', price: selectedRecord.priceGram21K),
        CustGramContainer(text: 'Gram 20k', price: selectedRecord.priceGram20K),
        CustGramContainer(text: 'Gram 18k', price: selectedRecord.priceGram18K),
        CustGramContainer(text: 'Gram 16k', price: selectedRecord.priceGram16K),
        CustGramContainer(text: 'Gram 14k', price: selectedRecord.priceGram14K),
        CustGramContainer(text: 'Gram 10k', price: selectedRecord.priceGram10K),
      ],
    );
  }
}


/*

  final List<ModelMetal> archiveList = [
    ModelMetal(
      timestamp: 0,
      metal: 'XAU',
      currency: 'EGP',
      exchange: 'XAU',
      symbol: 'XAU',
      openTime: 0,
      price: 1000.00,
      ch: 25,
      ask: 1000.00,
      bid: 1000.00,
      priceGram24K: 1000.00,
      priceGram22K: 100.00,
      priceGram21K: 1000.00,
      priceGram20K: 1000.00,
      priceGram18K: 1000.00,
      priceGram16K: 1000.00,
      priceGram14K: 1000.00,
      priceGram10K: 1000.00,
      recordID: 1,
    ),
    ModelMetal(
      timestamp: 0,
      metal: 'XAU',
      currency: 'EGP',
      exchange: 'XAU',
      symbol: 'XAU',
      openTime: 0,
      price: 2000.00,
      ch: 25,
      ask: 2000.00,
      bid: 2000.00,
      priceGram24K: 2000.00,
      priceGram22K: 2000.00,
      priceGram21K: 2000.00,
      priceGram20K: 2000.00,
      priceGram18K: 2000.00,
      priceGram16K: 2000.00,
      priceGram14K: 2000.00,
      priceGram10K: 2000.00,
      recordID: 2,
    ),
    ModelMetal(
      timestamp: 0,
      metal: 'XAG',
      currency: 'EGP',
      exchange: 'XAU',
      symbol: 'XAU',
      openTime: 0,
      price: 3000.00,
      ch: 25,
      ask: 3000.00,
      bid: 300.00,
      priceGram24K: 3000.00,
      priceGram22K: 3000.00,
      priceGram21K: 3000.00,
      priceGram20K: 3000.00,
      priceGram18K: 3000.00,
      priceGram16K: 3000.00,
      priceGram14K: 3000.00,
      priceGram10K: 3000.00,
      recordID: 3,
    ),
    ModelMetal(
      timestamp: 0,
      metal: 'XAG',
      currency: 'EGP',
      exchange: 'XAU',
      symbol: 'XAU',
      openTime: 0,
      price: 5000.00,
      ch: 25,
      ask: 5000.00,
      bid: 5000.00,
      priceGram24K: 5000.00,
      priceGram22K: 5000.00,
      priceGram21K: 5000.00,
      priceGram20K: 5000.00,
      priceGram18K: 5000.00,
      priceGram16K: 5000.00,
      priceGram14K: 5000.00,
      priceGram10K: 5000.00,
      recordID: 5,
    ),
    ModelMetal(
      timestamp: 0,
      metal: 'XAU',
      currency: 'EGP',
      exchange: 'XAU',
      symbol: 'XAU',
      openTime: 0,
      price: 4000.00,
      ch: 25,
      ask: 4000.00,
      bid: 4000.00,
      priceGram24K: 4000.00,
      priceGram22K: 4000.00,
      priceGram21K: 4000.00,
      priceGram20K: 4000.00,
      priceGram18K: 4000.00,
      priceGram16K: 4000.00,
      priceGram14K: 4000.00,
      priceGram10K: 4000.00,
      recordID: 4,
    ),
    // Add more ModelMetal instances as needed
  ];

 */

/*
Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Animated image
                SizedBox(
                  height: 150,
                  width: 250,
                  child: Image.asset(selectedAnimation, width: 250),
                ),

                metalMainInfo(
                  date: SharedMethods.convertTimesTampToDateTime(
                    currentRecord.timestamp,
                  ),
                  lastPrice: currentRecord.price,
                  change: currentRecord.ch,
                  ask: currentRecord.ask,
                  bid: currentRecord.bid,
                ),

                const SizedBox(height: 8),

                // Metal prices
                CustGramContainer(
                  text: 'Gram 24k',
                  price: currentRecord.priceGram24K,
                ),
                CustGramContainer(
                  text: 'Gram 22k',
                  price: currentRecord.priceGram22K,
                ),
                CustGramContainer(
                  text: 'Gram 21k',
                  price: currentRecord.priceGram21K,
                ),
                CustGramContainer(
                  text: 'Gram 20k',
                  price: currentRecord.priceGram20K,
                ),
                CustGramContainer(
                  text: 'Gram 18k',
                  price: currentRecord.priceGram18K,
                ),
                CustGramContainer(
                  text: 'Gram 16k',
                  price: currentRecord.priceGram16K,
                ),
                CustGramContainer(
                  text: 'Gram 14k',
                  price: currentRecord.priceGram14K,
                ),
                CustGramContainer(
                  text: 'Gram 10k',
                  price: currentRecord.priceGram10K,
                ),
              ],
            )

 */