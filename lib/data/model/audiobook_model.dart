class AudiobookModel {
  List<Datum>? data;
  int? total;
  String? next;

  AudiobookModel({
    this.data,
    this.total,
    this.next,
  });

  AudiobookModel copyWith({
    List<Datum>? data,
    int? total,
    String? next,
  }) =>
      AudiobookModel(
        data: data ?? this.data,
        total: total ?? this.total,
        next: next ?? this.next,
      );

  factory AudiobookModel.fromJson(Map<String, dynamic> json) => AudiobookModel(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total,
    "next": next,
  };
}

class Datum {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? titleVersion;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  String? md5Image;
  Artist? artist;
  Album? album;
  String? type;

  Datum({
    this.id,
    this.readable,
    this.title,
    this.titleShort,
    this.titleVersion,
    this.link,
    this.duration,
    this.rank,
    this.explicitLyrics,
    this.explicitContentLyrics,
    this.explicitContentCover,
    this.preview,
    this.md5Image,
    this.artist,
    this.album,
    this.type,
  });

  Datum copyWith({
    int? id,
    bool? readable,
    String? title,
    String? titleShort,
    String? titleVersion,
    String? link,
    int? duration,
    int? rank,
    bool? explicitLyrics,
    int? explicitContentLyrics,
    int? explicitContentCover,
    String? preview,
    String? md5Image,
    Artist? artist,
    Album? album,
    String? type,
  }) =>
      Datum(
        id: id ?? this.id,
        readable: readable ?? this.readable,
        title: title ?? this.title,
        titleShort: titleShort ?? this.titleShort,
        titleVersion: titleVersion ?? this.titleVersion,
        link: link ?? this.link,
        duration: duration ?? this.duration,
        rank: rank ?? this.rank,
        explicitLyrics: explicitLyrics ?? this.explicitLyrics,
        explicitContentLyrics: explicitContentLyrics ?? this.explicitContentLyrics,
        explicitContentCover: explicitContentCover ?? this.explicitContentCover,
        preview: preview ?? this.preview,
        md5Image: md5Image ?? this.md5Image,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        type: type ?? this.type,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    readable: json["readable"],
    title: json["title"],
    titleShort: json["title_short"],
    titleVersion: json["title_version"],
    link: json["link"],
    duration: json["duration"],
    rank: json["rank"],
    explicitLyrics: json["explicit_lyrics"],
    explicitContentLyrics: json["explicit_content_lyrics"],
    explicitContentCover: json["explicit_content_cover"],
    preview: json["preview"],
    md5Image: json["md5_image"],
    artist: json["artist"] != null ? Artist.fromJson(json["artist"]) : null,
    album: json["album"] != null ? Album.fromJson(json["album"]) : null,
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "readable": readable,
    "title": title,
    "title_short": titleShort,
    "title_version": titleVersion,
    "link": link,
    "duration": duration,
    "rank": rank,
    "explicit_lyrics": explicitLyrics,
    "explicit_content_lyrics": explicitContentLyrics,
    "explicit_content_cover": explicitContentCover,
    "preview": preview,
    "md5_image": md5Image,
    "artist": artist?.toJson(),
    "album": album?.toJson(),
    "type": type,
  };
}

class Album {
  int? id;
  String? title;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  String? tracklist;
  String? type;

  Album({
    this.id,
    this.title,
    this.cover,
    this.coverSmall,
    this.coverMedium,
    this.coverBig,
    this.coverXl,
    this.md5Image,
    this.tracklist,
    this.type,
  });

  Album copyWith({
    int? id,
    String? title,
    String? cover,
    String? coverSmall,
    String? coverMedium,
    String? coverBig,
    String? coverXl,
    String? md5Image,
    String? tracklist,
    String? type,
  }) =>
      Album(
        id: id ?? this.id,
        title: title ?? this.title,
        cover: cover ?? this.cover,
        coverSmall: coverSmall ?? this.coverSmall,
        coverMedium: coverMedium ?? this.coverMedium,
        coverBig: coverBig ?? this.coverBig,
        coverXl: coverXl ?? this.coverXl,
        md5Image: md5Image ?? this.md5Image,
        tracklist: tracklist ?? this.tracklist,
        type: type ?? this.type,
      );

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    id: json["id"],
    title: json["title"],
    cover: json["cover"],
    coverSmall: json["cover_small"],
    coverMedium: json["cover_medium"],
    coverBig: json["cover_big"],
    coverXl: json["cover_xl"],
    md5Image: json["md5_image"],
    tracklist: json["tracklist"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "cover": cover,
    "cover_small": coverSmall,
    "cover_medium": coverMedium,
    "cover_big": coverBig,
    "cover_xl": coverXl,
    "md5_image": md5Image,
    "tracklist": tracklist,
    "type": type,
  };
}

class Artist {
  int? id;
  String? name;
  String? link;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? tracklist;
  String? type;

  Artist({
    this.id,
    this.name,
    this.link,
    this.picture,
    this.pictureSmall,
    this.pictureMedium,
    this.pictureBig,
    this.pictureXl,
    this.tracklist,
    this.type,
  });

  Artist copyWith({
    int? id,
    String? name,
    String? link,
    String? picture,
    String? pictureSmall,
    String? pictureMedium,
    String? pictureBig,
    String? pictureXl,
    String? tracklist,
    String? type,
  }) =>
      Artist(
        id: id ?? this.id,
        name: name ?? this.name,
        link: link ?? this.link,
        picture: picture ?? this.picture,
        pictureSmall: pictureSmall ?? this.pictureSmall,
        pictureMedium: pictureMedium ?? this.pictureMedium,
        pictureBig: pictureBig ?? this.pictureBig,
        pictureXl: pictureXl ?? this.pictureXl,
        tracklist: tracklist ?? this.tracklist,
        type: type ?? this.type,
      );

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"],
    name: json["name"],
    link: json["link"],
    picture: json["picture"],
    pictureSmall: json["picture_small"],
    pictureMedium: json["picture_medium"],
    pictureBig: json["picture_big"],
    pictureXl: json["picture_xl"],
    tracklist: json["tracklist"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "link": link,
    "picture": picture,
    "picture_small": pictureSmall,
    "picture_medium": pictureMedium,
    "picture_big": pictureBig,
    "picture_xl": pictureXl,
    "tracklist": tracklist,
    "type": type,
  };
}
