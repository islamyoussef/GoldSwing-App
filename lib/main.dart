import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_swing/repo/current_price_cubit.dart';
import 'package:gold_swing/repo/month_statistics_cubit.dart';
import 'package:gold_swing/views/frm_archive.dart';
import 'package:gold_swing/views/frm_how_to_use.dart';
import 'package:gold_swing/views/frm_month_statistics.dart';
import 'package:hive_flutter/adapters.dart';
import 'ihelper/hive_helper.dart';
import 'models/model_metal.dart';
import 'package:gold_swing/views/frm_home.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'ihelper/shared_methods.dart';

void main() async {
  // Hive preparation
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
    ModelMetalAdapter(),
  ); /* Modal name + Adapter generated dart file */
  await HiveHelper.init(); /* From private class I've opened the hive box*/

  // For testing dio packadge
  HttpOverrides.global = MyHttpOverrides();

  // Get current version
  await SharedMethods.getAppVersion();

  runApp(const GoldSwing());
}

class GoldSwing extends StatelessWidget {
  const GoldSwing({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MonthStatisticsCubit>(
          create: (context) => MonthStatisticsCubit(),
        ),
        BlocProvider<CurrentPriceCubit>(
          create: (context) => CurrentPriceCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GOLD SWING',
        darkTheme: ThemeData.dark(),

        //home: const FrmHome(title: 'Gold Swing'),
        initialRoute: '/frmHome',
        routes: <String, WidgetBuilder>{
          '/frmHome': (context) => const FrmHome(title: 'Gold Swing'),
          '/frmUsing': (context) => const FrmHowToUse(),
          '/frmArchive': (context) {
            // Get the arguments passed from navigation
            final args =
                ModalRoute.of(context)!.settings.arguments
                    as Map<String, String>;
            // Pass them to your widget
            return FrmArchive(
              category: args['category'] ?? 'Gold',
            ); // Default to 'Gold' if null
          },
          '/frmStatistics': (context) => const FrmMonthStatistics(),
        },
      ),
    );
  }
}

// For testing dio [don't use it in production]
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (kDebugMode) {
          // Allow bad certs for dev mode
          return true;
        }
        return false;
      };
  }
}
