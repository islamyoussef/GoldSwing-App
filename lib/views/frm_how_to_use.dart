import 'package:flutter/material.dart';
import 'package:gold_swing/ihelper/api_endpoints.dart';
import 'package:gold_swing/ihelper/shared_variables.dart';
import 'package:gold_swing/views/custom_widgets/cust_appbar.dart';
import 'package:gold_swing/views/custom_widgets/cust_label_normal.dart';
import 'package:gold_swing/views/custom_widgets/cust_text_field.dart';
import 'package:url_launcher/link.dart';
import 'custom_widgets/cust_drawer.dart';
import 'package:gold_swing/ihelper/shared_methods.dart';

class FrmHowToUse extends StatefulWidget {
  const FrmHowToUse({super.key});

  @override
  State<FrmHowToUse> createState() => _FrmHowToUseState();
}

class _FrmHowToUseState extends State<FrmHowToUse> {
  final _formKey = GlobalKey<FormState>();
  final _txtKey = TextEditingController();

  getSavedKey() async {
    _txtKey.text = await SharedMethods.apiKeyGet(mySharedPrefApiKey);
  }

  @override
  void initState() {
    getSavedKey();
    super.initState();
  }

  @override
  void dispose() {
    _txtKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustAppBar(title: 'How to use ...'),

      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 24, left: 16, right: 16),
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
              CustLabelNormal(
                text:
                    '1. Open the following site and create your account to get free access for 100 calls monthly.',
                color: Colors.white,
              ),

              SizedBox(height: 16),

              Link(
                target: LinkTarget.blank,
                uri: Uri.parse(apiSiteReg),
                builder: (context, openLink) {
                  return ElevatedButton(
                    onPressed: openLink,
                    child: Text(
                      'Create your account free!',
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  );
                },
              ),

              SizedBox(height: 16),

              CustLabelNormal(
                text:
                    '2. After creating your free account you will have a KEY, just copy and paste it bellow then click Save.',
                color: Colors.white,
              ),
              SizedBox(height: 16),
              CustTextField(
                controller: _txtKey,
                labelText: 'Your key',

                isRequired: true,
                requiredErrorMessage: 'Insert a valid registered key.',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  bool isValied = _formKey.currentState!.validate();
                  //_formKey.currentState!.save(); // Add this line
                  if (isValied) {
                    // Save the user's key in shared_preferences key
                    if (await SharedMethods.apikeySet(_txtKey.text.trim())) {
                      SharedMethods.msgOperationResult(
                        // ignore: use_build_context_synchronously
                        context,
                        "Your key has been save successfully.",
                        Colors.green,
                      );
                    } else {
                      SharedMethods.msgOperationResult(
                        // ignore: use_build_context_synchronously
                        context,
                        "Check your key again.",
                        Colors.red,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: myGoldenColor,
                  minimumSize: Size(double.infinity, 40),
                ),
                child: Text(
                  'Save your key',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),

      // Drawer
      drawer: CustDrawer(),
    );
  }
}
