class Result{
 late String name;
 late String phone;
 late String date;
 String? agent;

  Result({required this.name, required this.phone,required this.date,this.agent});
  Result.fromJson(Map<String,dynamic> json){
    name = json['name'];
    phone = json['phone'];
    date = json['date'];
    agent = json['agent'];
  }
  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['agent'] = this.agent;
    return data;
  }
}
