import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseDataBaseService{

  static final FirebaseDatabase _database = FirebaseDatabase.instance;



  static Future<void> _pushData(String ref,Map data) async {
    DatabaseReference databaseRef = _database.ref(ref);

    try {
      await databaseRef.push().set(data) ;
      return ;
    } on FirebaseException catch (e) {
     return Future.error(e);
    }

  }

  static Future<void> pushDataAtUid(String uid, Map data){
    return _pushData('transactions/$uid',data);
  }

}