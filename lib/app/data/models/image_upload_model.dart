class ImageUploadModel {
  int? status;
  bool? success;
  Data? data;

  ImageUploadModel({this.status, this.success, this.data});

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? deletehash;
  Null accountId;
  Null accountUrl;
  Null adType;
  Null adUrl;
  String? title;
  String? description;
  String? name;
  String? type;
  int? width;
  int? height;
  int? size;
  int? views;
  Null section;
  Null vote;
  int? bandwidth;
  bool? animated;
  bool? favorite;
  bool? inGallery;
  bool? inMostViral;
  bool? hasSound;
  bool? isAd;
  dynamic nsfw;
  String? link;
  List<String>? tags;
  int? datetime;
  String? mp4;
  String? hls;

  Data(
      {this.id,
      this.deletehash,
      this.accountId,
      this.accountUrl,
      this.adType,
      this.adUrl,
      this.title,
      this.description,
      this.name,
      this.type,
      this.width,
      this.height,
      this.size,
      this.views,
      this.section,
      this.vote,
      this.bandwidth,
      this.animated,
      this.favorite,
      this.inGallery,
      this.inMostViral,
      this.hasSound,
      this.isAd,
      this.nsfw,
      this.link,
      this.tags,
      this.datetime,
      this.mp4,
      this.hls});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deletehash = json['deletehash'];
    accountId = json['account_id'];
    accountUrl = json['account_url'];
    adType = json['ad_type'];
    adUrl = json['ad_url'];
    title = json['title'];
    description = json['description'];
    name = json['name'];
    type = json['type'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    views = json['views'];
    section = json['section'];
    vote = json['vote'];
    bandwidth = json['bandwidth'];
    animated = json['animated'];
    favorite = json['favorite'];
    inGallery = json['in_gallery'];
    inMostViral = json['in_most_viral'];
    hasSound = json['has_sound'];
    isAd = json['is_ad'];
    nsfw = json['nsfw'];
    link = json['link'];
    if (json['tags'] != null) {
      tags = <String>[];
      json['tags'].forEach((v) {
        tags!.add("");
      });
    }
    datetime = json['datetime'];
    mp4 = json['mp4'];
    hls = json['hls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deletehash'] = deletehash;
    data['account_id'] = accountId;
    data['account_url'] = accountUrl;
    data['ad_type'] = adType;
    data['ad_url'] = adUrl;
    data['title'] = title;
    data['description'] = description;
    data['name'] = name;
    data['type'] = type;
    data['width'] = width;
    data['height'] = height;
    data['size'] = size;
    data['views'] = views;
    data['section'] = section;
    data['vote'] = vote;
    data['bandwidth'] = bandwidth;
    data['animated'] = animated;
    data['favorite'] = favorite;
    data['in_gallery'] = inGallery;
    data['in_most_viral'] = inMostViral;
    data['has_sound'] = hasSound;
    data['is_ad'] = isAd;
    data['nsfw'] = nsfw;
    data['link'] = link;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v).toList();
    }
    data['datetime'] = datetime;
    data['mp4'] = mp4;
    data['hls'] = hls;
    return data;
  }
}
