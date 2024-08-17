class AudiobookModel {
  List<Audiobook>? audiobooks;

  AudiobookModel({
    this.audiobooks,
  });

  AudiobookModel copyWith({
    List<Audiobook>? audiobooks,
  }) =>
      AudiobookModel(
        audiobooks: audiobooks ?? this.audiobooks,
      );

  factory AudiobookModel.fromJson(Map<String, dynamic> json) => AudiobookModel(
    audiobooks: json["audiobooks"] == null
        ? null
        : List<Audiobook>.from(json["audiobooks"].map((x) => Audiobook.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "audiobooks": audiobooks == null ? null : List<dynamic>.from(audiobooks!.map((x) => x.toJson())),
  };
}

class Audiobook {
  List<Author>? authors;
  List<String>? availableMarkets;
  List<Copyright>? copyrights;
  String? description;
  String? htmlDescription;
  String? edition;
  bool? explicit;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  List<String>? languages;
  String? mediaType;
  String? name;
  List<Author>? narrators;
  String? publisher;
  String? type;
  String? uri;
  int? totalChapters;
  Chapters? chapters;

  Audiobook({
    this.authors,
    this.availableMarkets,
    this.copyrights,
    this.description,
    this.htmlDescription,
    this.edition,
    this.explicit,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.languages,
    this.mediaType,
    this.name,
    this.narrators,
    this.publisher,
    this.type,
    this.uri,
    this.totalChapters,
    this.chapters,
  });

  Audiobook copyWith({
    List<Author>? authors,
    List<String>? availableMarkets,
    List<Copyright>? copyrights,
    String? description,
    String? htmlDescription,
    String? edition,
    bool? explicit,
    ExternalUrls? externalUrls,
    String? href,
    String? id,
    List<Image>? images,
    List<String>? languages,
    String? mediaType,
    String? name,
    List<Author>? narrators,
    String? publisher,
    String? type,
    String? uri,
    int? totalChapters,
    Chapters? chapters,
  }) =>
      Audiobook(
        authors: authors ?? this.authors,
        availableMarkets: availableMarkets ?? this.availableMarkets,
        copyrights: copyrights ?? this.copyrights,
        description: description ?? this.description,
        htmlDescription: htmlDescription ?? this.htmlDescription,
        edition: edition ?? this.edition,
        explicit: explicit ?? this.explicit,
        externalUrls: externalUrls ?? this.externalUrls,
        href: href ?? this.href,
        id: id ?? this.id,
        images: images ?? this.images,
        languages: languages ?? this.languages,
        mediaType: mediaType ?? this.mediaType,
        name: name ?? this.name,
        narrators: narrators ?? this.narrators,
        publisher: publisher ?? this.publisher,
        type: type ?? this.type,
        uri: uri ?? this.uri,
        totalChapters: totalChapters ?? this.totalChapters,
        chapters: chapters ?? this.chapters,
      );

  factory Audiobook.fromJson(Map<String, dynamic> json) => Audiobook(
    authors: json["authors"] == null
        ? null
        : List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
    availableMarkets: json["available_markets"] == null
        ? null
        : List<String>.from(json["available_markets"].map((x) => x)),
    copyrights: json["copyrights"] == null
        ? null
        : List<Copyright>.from(json["copyrights"].map((x) => Copyright.fromJson(x))),
    description: json["description"],
    htmlDescription: json["html_description"],
    edition: json["edition"],
    explicit: json["explicit"],
    externalUrls: json["external_urls"] == null ? null : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: json["images"] == null
        ? null
        : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    languages: json["languages"] == null
        ? null
        : List<String>.from(json["languages"].map((x) => x)),
    mediaType: json["media_type"],
    name: json["name"],
    narrators: json["narrators"] == null
        ? null
        : List<Author>.from(json["narrators"].map((x) => Author.fromJson(x))),
    publisher: json["publisher"],
    type: json["type"],
    uri: json["uri"],
    totalChapters: json["total_chapters"],
    chapters: json["chapters"] == null ? null : Chapters.fromJson(json["chapters"]),
  );

  Map<String, dynamic> toJson() => {
    "authors": authors == null ? null : List<dynamic>.from(authors!.map((x) => x.toJson())),
    "available_markets": availableMarkets == null ? null : List<dynamic>.from(availableMarkets!.map((x) => x)),
    "copyrights": copyrights == null ? null : List<dynamic>.from(copyrights!.map((x) => x.toJson())),
    "description": description,
    "html_description": htmlDescription,
    "edition": edition,
    "explicit": explicit,
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x.toJson())),
    "languages": languages == null ? null : List<dynamic>.from(languages!.map((x) => x)),
    "media_type": mediaType,
    "name": name,
    "narrators": narrators == null ? null : List<dynamic>.from(narrators!.map((x) => x.toJson())),
    "publisher": publisher,
    "type": type,
    "uri": uri,
    "total_chapters": totalChapters,
    "chapters": chapters?.toJson(),
  };
}





class Author {
  String? name;

  Author({
    this.name,
  });

  Author copyWith({
    String? name,
  }) =>
      Author(
        name: name ?? this.name,
      );

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class Chapters {
  String? href;
  int? limit;
  String? next;
  int? offset;
  String? previous;
  int? total;
  List<Item>? items;

  Chapters({
    this.href,
    this.limit,
    this.next,
    this.offset,
    this.previous,
    this.total,
    this.items,
  });

  Chapters copyWith({
    String? href,
    int? limit,
    String? next,
    int? offset,
    String? previous,
    int? total,
    List<Item>? items,
  }) =>
      Chapters(
        href: href ?? this.href,
        limit: limit ?? this.limit,
        next: next ?? this.next,
        offset: offset ?? this.offset,
        previous: previous ?? this.previous,
        total: total ?? this.total,
        items: items ?? this.items,
      );

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
    href: json["href"] as String?,
    limit: json["limit"] as int?,
    next: json["next"] as String?,
    offset: json["offset"] as int?,
    previous: json["previous"] as String?,
    total: json["total"] as int?,
    items: json["items"] == null
        ? null
        : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "limit": limit,
    "next": next,
    "offset": offset,
    "previous": previous,
    "total": total,
    "items": items == null
        ? null
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? audioPreviewUrl;
  List<String>? availableMarkets;
  int? chapterNumber;
  String? description;
  String? htmlDescription;
  int? durationMs;
  bool? explicit;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Image>? images;
  bool? isPlayable;
  List<String>? languages;
  String? name;
  DateTime? releaseDate;
  String? releaseDatePrecision;
  ResumePoint? resumePoint;
  String? type;
  String? uri;
  Restrictions? restrictions;

  Item({
    this.audioPreviewUrl,
    this.availableMarkets,
    this.chapterNumber,
    this.description,
    this.htmlDescription,
    this.durationMs,
    this.explicit,
    this.externalUrls,
    this.href,
    this.id,
    this.images,
    this.isPlayable,
    this.languages,
    this.name,
    this.releaseDate,
    this.releaseDatePrecision,
    this.resumePoint,
    this.type,
    this.uri,
    this.restrictions,
  });

  Item copyWith({
    String? audioPreviewUrl,
    List<String>? availableMarkets,
    int? chapterNumber,
    String? description,
    String? htmlDescription,
    int? durationMs,
    bool? explicit,
    ExternalUrls? externalUrls,
    String? href,
    String? id,
    List<Image>? images,
    bool? isPlayable,
    List<String>? languages,
    String? name,
    DateTime? releaseDate,
    String? releaseDatePrecision,
    ResumePoint? resumePoint,
    String? type,
    String? uri,
    Restrictions? restrictions,
  }) =>
      Item(
        audioPreviewUrl: audioPreviewUrl ?? this.audioPreviewUrl,
        availableMarkets: availableMarkets ?? this.availableMarkets,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        description: description ?? this.description,
        htmlDescription: htmlDescription ?? this.htmlDescription,
        durationMs: durationMs ?? this.durationMs,
        explicit: explicit ?? this.explicit,
        externalUrls: externalUrls ?? this.externalUrls,
        href: href ?? this.href,
        id: id ?? this.id,
        images: images ?? this.images,
        isPlayable: isPlayable ?? this.isPlayable,
        languages: languages ?? this.languages,
        name: name ?? this.name,
        releaseDate: releaseDate ?? this.releaseDate,
        releaseDatePrecision: releaseDatePrecision ?? this.releaseDatePrecision,
        resumePoint: resumePoint ?? this.resumePoint,
        type: type ?? this.type,
        uri: uri ?? this.uri,
        restrictions: restrictions ?? this.restrictions,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    audioPreviewUrl: json["audio_preview_url"] as String?,
    availableMarkets: json["available_markets"] == null
        ? null
        : List<String>.from(json["available_markets"].map((x) => x)),
    chapterNumber: json["chapter_number"] as int?,
    description: json["description"] as String?,
    htmlDescription: json["html_description"] as String?,
    durationMs: json["duration_ms"] as int?,
    explicit: json["explicit"] as bool?,
    externalUrls: json["external_urls"] == null
        ? null
        : ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"] as String?,
    id: json["id"] as String?,
    images: json["images"] == null
        ? null
        : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    isPlayable: json["is_playable"] as bool?,
    languages: json["languages"] == null
        ? null
        : List<String>.from(json["languages"].map((x) => x)),
    name: json["name"] as String?,
    releaseDate: json["release_date"] == null
        ? null
        : DateTime.tryParse(json["release_date"]),
    releaseDatePrecision: json["release_date_precision"] as String?,
    resumePoint: json["resume_point"] == null
        ? null
        : ResumePoint.fromJson(json["resume_point"]),
    type: json["type"] as String?,
    uri: json["uri"] as String?,
    restrictions: json["restrictions"] == null
        ? null
        : Restrictions.fromJson(json["restrictions"]),
  );

  Map<String, dynamic> toJson() => {
    "audio_preview_url": audioPreviewUrl,
    "available_markets": availableMarkets == null
        ? null
        : List<dynamic>.from(availableMarkets!.map((x) => x)),
    "chapter_number": chapterNumber,
    "description": description,
    "html_description": htmlDescription,
    "duration_ms": durationMs,
    "explicit": explicit,
    "external_urls": externalUrls?.toJson(),
    "href": href,
    "id": id,
    "images": images == null
        ? null
        : List<dynamic>.from(images!.map((x) => x.toJson())),
    "is_playable": isPlayable,
    "languages": languages == null
        ? null
        : List<dynamic>.from(languages!.map((x) => x)),
    "name": name,
    "release_date": releaseDate == null
        ? null
        : "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "release_date_precision": releaseDatePrecision,
    "resume_point": resumePoint?.toJson(),
    "type": type,
    "uri": uri,
    "restrictions": restrictions?.toJson(),
  };
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({
    this.spotify,
  });

  ExternalUrls copyWith({
    String? spotify,
  }) =>
      ExternalUrls(
        spotify: spotify ?? this.spotify,
      );

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

class Image {
  String? url;
  int? height;
  int? width;

  Image({
    this.url,
    this.height,
    this.width,
  });

  Image copyWith({
    String? url,
    int? height,
    int? width,
  }) =>
      Image(
        url: url ?? this.url,
        height: height ?? this.height,
        width: width ?? this.width,
      );

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"] as String?,
    height: json["height"] as int?,
    width: json["width"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "height": height,
    "width": width,
  };
}

class Restrictions {
  String? reason;

  Restrictions({
    this.reason,
  });

  Restrictions copyWith({
    String? reason,
  }) =>
      Restrictions(
        reason: reason ?? this.reason,
      );

  factory Restrictions.fromJson(Map<String, dynamic> json) => Restrictions(
    reason: json["reason"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "reason": reason,
  };
}

class ResumePoint {
  bool? fullyPlayed;
  int? resumePositionMs;

  ResumePoint({
    this.fullyPlayed,
    this.resumePositionMs,
  });

  ResumePoint copyWith({
    bool? fullyPlayed,
    int? resumePositionMs,
  }) =>
      ResumePoint(
        fullyPlayed: fullyPlayed ?? this.fullyPlayed,
        resumePositionMs: resumePositionMs ?? this.resumePositionMs,
      );

  factory ResumePoint.fromJson(Map<String, dynamic> json) => ResumePoint(
    fullyPlayed: json["fully_played"] as bool?,
    resumePositionMs: json["resume_position_ms"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "fully_played": fullyPlayed,
    "resume_position_ms": resumePositionMs,
  };
}

class Copyright {
  String? text;
  String? type;

  Copyright({
    this.text,
    this.type,
  });

  Copyright copyWith({
    String? text,
    String? type,
  }) =>
      Copyright(
        text: text ?? this.text,
        type: type ?? this.type,
      );

  factory Copyright.fromJson(Map<String, dynamic> json) => Copyright(
    text: json["text"] as String? ?? "",
    type: json["type"] as String? ?? "",
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "type": type,
  };
}
