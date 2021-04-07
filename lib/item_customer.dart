class ItemCustomer {
  int _id;
  String _name;
  int _jmlh;
  String _alamat;
  String _kode;
  int get id => this._id;

  String get name => this._name;

  set name(String value) => this._name = value;

  int get jmlh => this._jmlh;

  set jmlh(int value) => this._jmlh = value;

  String get alamat => this._alamat;

  set alamat(String value) => this._alamat = value;

  String get kode => this._kode;

  set kode(String value) => this._kode = value;

  ItemCustomer(this._name, this._kode, this._alamat, this._jmlh);

  ItemCustomer.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._kode = map['kode'];
    this._alamat = map['alamat'];
    this._jmlh = map['jumlah'];
  }

  // konversi dari Item ke Map

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['kode'] = this._kode;
    map['alamat'] = this._alamat;
    map['jumlah'] = this._jmlh;
    return map;
  }
}
