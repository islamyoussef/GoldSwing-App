import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';
//import 'package:package_info_plus/package_info_plus.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({super.key});

  /*
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<String> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'Version: ${packageInfo.version} (Build ${packageInfo.buildNumber})';
  }
  */

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          // Avatar
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            color: myGoldenColor,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/Category_Gold.jpg'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 75.0,
                  height: 75.0,
                ),

                userInfo('Islam A,Youssef', 14),

                userInfo('islamyoussef83@gmail.com', 12),
              ],
            ),
          ),

          item('Home', Icons.home, () {
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/frmHome',
              (Route<dynamic> route) => false,
            );
          }),

          item('Gold\'s archive', Icons.shopping_basket_outlined, () {
            Navigator.pop(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/frmArchive',
              (route) => false,
              arguments: {'category': 'Gold'},
            );
          }),

          item(
            'Silver\'s archive',
            Icons.shopping_basket_outlined,
            color: Colors.white,
            () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/frmArchive',
                (route) => false,
                arguments: {'category': 'Silver'},
              );
            },
          ),

          item('Statistics report', Icons.report, () {
            Navigator.pop(context);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/frmStatistics', (route) => false);
          }),

          item('How to use?', Icons.question_mark_rounded, () {
            Navigator.pop(context);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/frmUsing', (route) => false);
          }),

          item('Exit', Icons.close, () {
            SharedMethods.exitApp();

            Navigator.pop(context);
          }),

          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.bottomCenter,
            child: Text(
              myAppVersion,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget item(
    String title,
    IconData icon,
    VoidCallback onClick, {
    Color color = myGoldenColor,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        //Item name
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        //trailing: the icon on the right side
        trailing: Icon(Icons.chevron_right, color: Colors.grey.shade300),

        //Event
        onTap: onClick,
      ),
    );
  }

  Widget userInfo(String title, double fontSize) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black87,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
