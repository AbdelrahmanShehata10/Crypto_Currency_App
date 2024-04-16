
abstract class Appstates{}
class initial extends Appstates{}
class Loginloading extends Appstates{}
class LoginSuccess extends Appstates{}
class LoginFailed extends Appstates{}
class Signuploading extends Appstates{}
class SignupSuccess extends Appstates{}
class SignupFailed extends Appstates{}
class infoloading extends Appstates{}
class infoSuccess extends Appstates{}
class infoFailed extends Appstates{
  infoFailed(e);
}
class bottomnav extends Appstates{}

class appchangemodestate extends Appstates{}
class Takedpic extends Appstates{}
class useraddedsucssefully extends Appstates{}
class Searchloading extends Appstates{}
class Searchsucces extends Appstates{}
class Searchfailed extends Appstates{}
class UploadedDone extends Appstates{}
class unUploadedDone extends Appstates{}
class GoogleSignedinDone extends Appstates{}
class SearchSucceded extends Appstates{}
class SearchFailed extends Appstates{}
class getuserdataloading extends Appstates{}
class getuserdatadone extends Appstates{}
class getuserdatafailed extends Appstates{}
class imageupdated extends Appstates{}
class Appchangelang extends Appstates{
  final String ?langcode;
  Appchangelang({this.langcode});
}
