import 'dart:convert';

class LoginResponse {
    LoginResponse({
        required this.code,
        required this.msg,
        required this.user,
        required this.menu,
        required this.token,
    });

    String code;
    String msg;
    User user;
    List<Menu> menu;
    String token;

    factory LoginResponse.fromJson(String str) => LoginResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        msg: json["msg"],
        user: User.fromMap(json["user"]),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromMap(x))),
        token: json["token"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "user": user.toMap(),
        "menu": List<dynamic>.from(menu.map((x) => x.toMap())),
        "token": token,
    };
}

class Menu {
    Menu({
        required this.key,
        required this.items,
    });

    String key;
    List<Item> items;

    factory Menu.fromJson(String str) => Menu.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        key: json["key"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "key": key,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
    };
}

class Item {
    Item({
        required this.key,
        required this.type,
        required this.val,
    });

    String key;
    String type;
    String val;

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        key: json["key"],
        type: json["type"],
        val: json["val"],
    );

    Map<String, dynamic> toMap() => {
        "key": key,
        "type": type,
        "val": val,
    };
}

class User {
    User({
        required this.filefoto,
        required this.nome,
        required this.nomeCompleto,
        required this.email,
        required this.newsEditor,
        required this.sendSms,
        required this.advertisingTxt,
        required this.bannerTxt,
    });

    String filefoto;
    String nome;
    String nomeCompleto;
    String email;
    int newsEditor;
    int sendSms;
    String advertisingTxt;
    String bannerTxt;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        filefoto: json["filefoto"],
        nome: json["nome"],
        nomeCompleto: json["nome_completo"],
        email: json["email"],
        newsEditor: json["news_editor"],
        sendSms: json["send_sms"],
        advertisingTxt: json["advertising_txt"],
        bannerTxt: json["banner_txt"],
    );

    Map<String, dynamic> toMap() => {
        "filefoto": filefoto,
        "nome": nome,
        "nome_completo": nomeCompleto,
        "email": email,
        "news_editor": newsEditor,
        "send_sms": sendSms,
        "advertising_txt": advertisingTxt,
        "banner_txt": bannerTxt,
    };
}
