
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class AUTHSTORE{
  final auth=FirebaseAuth.instance;
  final store=FirebaseDatabase.instance;
}