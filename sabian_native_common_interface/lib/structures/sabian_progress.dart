class SabianProgress {
  String? title;
  String message = "";
  bool? isHidden = false;

  SabianProgress(this.message, {this.title, this.isHidden});

  factory SabianProgress.fromParams(Map<String, dynamic> args) {
    return SabianProgress(args["message"],
        title: args["title"], isHidden: args["isHidden"]);
  }
}
