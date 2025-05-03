import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';
import 'package:gold_swing/models/model_api_status.dart';
import 'package:gold_swing/repo/month_statistics_cubit.dart';
import 'package:gold_swing/views/custom_widgets/cust_appbar.dart';
import 'package:gold_swing/views/custom_widgets/cust_label_normal.dart';
import 'package:gold_swing/views/custom_widgets/cust_rich_text.dart';
import 'custom_widgets/cust_drawer.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';

class FrmMonthStatistics extends StatelessWidget {
  const FrmMonthStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustAppBar(
        title: 'Statistics report ...',
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
              "You've to get your private key first, open (how to use?) screen!",
              Colors.black,
            );
            return;
          }

          // ignore: use_build_context_synchronously
          await context.read<MonthStatisticsCubit>().getCurrentStatistics();

          //setState(() {});
        },
      ),

      body: BlocBuilder<MonthStatisticsCubit, MonthStatisticsState>(
        builder: (context, state) {
          if (state is MonthStatisticsLoading) {
            return Center(
              child: Image.asset('assets/images/Loading.gif', width: 75),
            );
          } else if (state is MonthStatisticsSuccess) {
            return monthlyStatistics(state.modelApiStatus);
          } else if (state is MonthStatisticsSuccess) {
            return Center(
              child: Text(
                state.modelApiStatus.statusMsg.toString(),
                style: TextStyle(color: Colors.redAccent),
              ),
            );
            //return monthlyStatistics(modelApiStatus);
          } else {
            return Center(
              child: Text(
                'Click Sync To Get Current Status',
                style: TextStyle(color: myGoldenColor),
              ),
            );
          }
        },
      ),

      // Drawer
      drawer: CustDrawer(),
    );
  }

  Widget monthlyStatistics(ModelApiStatus modelApiStatus) {
    return Container(
      margin: EdgeInsets.only(top: 24, left: 16, right: 16),
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          CustRichText(
            firstText: 'Requests today ',
            firstTextColor: Colors.white,
            secondText: modelApiStatus.requestsToday.toString(),
            secondTextColor: myGoldenColor,
          ),
          SizedBox(height: 16),

          CustRichText(
            firstText: 'Requests yesterday ',
            firstTextColor: Colors.white,
            secondText: modelApiStatus.requestsYesterday.toString(),
            secondTextColor: myGoldenColor,
          ),
          SizedBox(height: 16),

          CustRichText(
            firstText: 'Requests this month ',
            firstTextColor: Colors.white,
            secondText: modelApiStatus.requestsMonth.toString(),
            secondTextColor: myGoldenColor,
          ),
          SizedBox(height: 16),

          CustRichText(
            firstText: 'Requests last month ',
            firstTextColor: Colors.white,
            secondText: modelApiStatus.requestsLastMonth.toString(),
            secondTextColor: myGoldenColor,
          ),
          SizedBox(height: 16),

          Center(
            child: CustLabelNormal(
              text: modelApiStatus.statusMsg,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
