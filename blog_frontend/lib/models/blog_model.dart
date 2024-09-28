class BlogModel {
  String? uid;
  String? title;
  String? blogText;
  String? mainImage;
  int? user;

  BlogModel({this.uid, this.title, this.blogText, this.mainImage, this.user});

  BlogModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    blogText = json['blog_text'];
    mainImage = json['main_image'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['title'] = title;
    data['blog_text'] = blogText;
    data['main_image'] = mainImage;
    data['user'] = user;
    return data;
  }
}
