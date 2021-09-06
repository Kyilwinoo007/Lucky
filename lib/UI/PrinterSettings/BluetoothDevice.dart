class BluetoothDevice {
  late String? name;
  late String? address;
  late int type = 0;
  bool connected = false;

  BluetoothDevice({this.name, this.address,required this.type,required this.connected});

  BluetoothDevice.fromMap(Map map)
      : name = map['name'],
        address = map['address'];

  BluetoothDevice.fromJson(Map<String, dynamic> json,) {
    name = json['name'];
    address = json['address'];
    type = json['type'];
    connected = json['connected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['type'] = this.type;
    data['connected'] = this.connected;
    return data;
  }

  Map<String, dynamic> toMap() => {
    'name': this.name,
    'address': this.address,
    'type': this.type,
    'connected': this.connected,
  };

  operator ==(Object other) {
    return other is BluetoothDevice && other.address == this.address;
  }

  @override
  int get hashCode => address.hashCode;
}
