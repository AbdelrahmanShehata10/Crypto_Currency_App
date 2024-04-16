class usermodel{
  String ?Name;
  String ?Email;
  String ?uid;
  String ?url;
  usermodel(
      {
        this.Name,
        this.Email,
        this.uid,
        this.url
      });
  Map<String,dynamic> tomap(){
    return {
      'Name':Name,
      'Email':Email,
      'uid':uid,
      'url':url,
    };
  }
  usermodel.fromjson(Map<String,dynamic> json){
    Name=json['Name'];
    Email=json['Email'];
    url=json['url'];
  }
}