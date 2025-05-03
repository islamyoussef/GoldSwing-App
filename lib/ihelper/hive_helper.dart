import 'package:gold_swing/ihelper/shared_methods.dart';
import 'package:gold_swing/models/model_metal.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  static const String metalBoxName = "HiveBox_Metal";
  static late Box<ModelMetal> myBox;

  // This function to open the box
  static Future<void> init() async {
    myBox = await Hive.openBox<ModelMetal>(metalBoxName);
  }

  // This function to get all saved data in hive box
  static List<ModelMetal> selectAllRecords({String categoryName = ''}) {
    if (categoryName == '') {
      return myBox.values.toList().reversed.toList();
    } else {
      return myBox.values
          .where(
            (metal) => metal.metal.toLowerCase() == categoryName.toLowerCase(),
          )
          .toList()
          .reversed
          .toList();
    }
  }

  // This function to get the last record for specific metal category
  static ModelMetal selectOne(String categoryName) {
    ModelMetal record;
    try {
      record = myBox.values.lastWhere(
        (item) => item.metal.toLowerCase() == categoryName.toLowerCase(),
      );

      return record;
    } catch (ex) {
      record = ModelMetal(
        responseMsg: 'Error while getting last record for ${ex.toString()}',
      );
      return record;
    }
  }

  // This function to get counts of record inside the box
  static String selectCount() {
    String response = '';
    try {
      response = myBox.values.length.toString();
      return response.toString();
    } catch (ex) {
      response =
          'Error while counting all save records in local db. ${ex.toString()}';
      return response;
    }
  }

  // This function to add new metal record & change the metal shortcut to metal name Gold or Silver
  static Future<int> addRecord(ModelMetal record) async {
    int response = 0;

    record.recordID = SharedMethods.getCurrentTimesTamp();
    record.responseMsg = "";
    record.metal = record.metal.toLowerCase() == "xau" ? "Gold" : "Silver";

    response = await myBox.add(record);
    //debugPrint('>>> hive_helper addRecord response: $response');

    return response;
  }

  // This function to delete the record by record index
  static String deleteRecord(ModelMetal record) {
    String statusCode = "";
    try {
      final index = myBox.values.toList().indexWhere(
        (item) => item.recordID == record.recordID,
      );

      //debugPrint('>>> hive_helper current index: $index');

      myBox.deleteAt(index);
      statusCode = "200";
    } catch (ex) {
      statusCode = 'Error while deleting record. ${ex.toString()}';
    }

    //debugPrint('>>> hive_helper current index: $statusCode');

    return statusCode;
  }

  // This function to delete all records in the box
  static Future<void> deleteAllRecords() async {
    await myBox.clear();
  }

  // This function to update the record by record index
  static Future<void> updateRecord(ModelMetal record) async {
    final index = myBox.values.toList().indexWhere(
      (item) => item.recordID == record.recordID,
    );
    await myBox.putAt(index, record);
  }
}
