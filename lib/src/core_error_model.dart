class CoreErrorModel {
  String id;
  String title;
  String? msg;
  int? code;

  CoreErrorModel({required this.id, required this.title, this.msg});
}

class CoreErrorType {
  static CoreErrorModel get noConnection => CoreErrorModel(
        id: "noConnection",
        title: "No Connection",
        msg: "Please make sure that your WIFI/Mobile data is active.",
      );

  static CoreErrorModel get requestTimeOut => CoreErrorModel(
        id: "requestTimeOut",
        title: "Request Time Out",
        msg: "There is a network disruption, please try again.",
        //terjadi gangguan jaringan
      );

  static CoreErrorModel get notFound => CoreErrorModel(
        id: "notFound",
        title: "Not Found",
        msg: "The something you are searching for was not found.",
        //  "Data yang kamu cari tidak ditemukan",
      );

  static CoreErrorModel get somethingWrong => CoreErrorModel(
        id: "somethingWrong",
        title: "Something Wrong",
      );
}
