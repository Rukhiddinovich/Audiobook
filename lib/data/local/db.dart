// import 'package:flutter/cupertino.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:uic_task/data/model/audiobook_model.dart';
// class AudiobookModelFields {
//   static final String audiobooksTable = 'audiobooks';
//   static final String id = 'id';
//   static final String readable = 'readable';
//   static final String title = 'title';
//   static final String titleShort = 'title_short';
//   static final String titleVersion = 'title_version';
//   static final String link = 'link';
//   static final String duration = 'duration';
//   static final String rank = 'rank';
//   static final String explicitLyrics = 'explicit_lyrics';
//   static final String explicitContentLyrics = 'explicit_content_lyrics';
//   static final String explicitContentCover = 'explicit_content_cover';
//   static final String preview = 'preview';
//   static final String md5Image = 'md5_image';
//   static final String artistId = 'artist_id';
//   static final String artistName = 'artist_name';
//   static final String artistLink = 'artist_link';
//   static final String artistPicture = 'artist_picture';
//   static final String albumId = 'album_id';
//   static final String albumTitle = 'album_title';
//   static final String albumCover = 'album_cover';
// // Add more fields if needed
// }
//
// class LocalDatabase {
//   static final LocalDatabase _instance = LocalDatabase._init();
//
//   LocalDatabase._init();
//
//   factory LocalDatabase() {
//     return _instance;
//   }
//
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     } else {
//       _database = await _initDB("audiobooks.db");
//       return _database!;
//     }
//   }
//
//   Future<Database> _initDB(String dbName) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, dbName);
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }
//
//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE ${AudiobookModelFields.audiobooksTable} (
//     ${AudiobookModelFields.id} INTEGER PRIMARY KEY,
//     ${AudiobookModelFields.readable} INTEGER,
//     ${AudiobookModelFields.title} TEXT,
//     ${AudiobookModelFields.titleShort} TEXT,
//     ${AudiobookModelFields.titleVersion} TEXT,
//     ${AudiobookModelFields.link} TEXT,
//     ${AudiobookModelFields.duration} INTEGER,
//     ${AudiobookModelFields.rank} INTEGER,
//     ${AudiobookModelFields.explicitLyrics} INTEGER,
//     ${AudiobookModelFields.explicitContentLyrics} INTEGER,
//     ${AudiobookModelFields.explicitContentCover} INTEGER,
//     ${AudiobookModelFields.preview} TEXT,
//     ${AudiobookModelFields.md5Image} TEXT,
//     ${AudiobookModelFields.artistId} INTEGER,
//     ${AudiobookModelFields.artistName} TEXT,
//     ${AudiobookModelFields.artistLink} TEXT,
//     ${AudiobookModelFields.artistPicture} TEXT,
//     ${AudiobookModelFields.albumId} INTEGER,
//     ${AudiobookModelFields.albumTitle} TEXT,
//     ${AudiobookModelFields.albumCover} TEXT
//     )
//     ''');
//     debugPrint("-------DB----------CREATED---------");
//   }
//
//   Future<void> insertAudiobook(DataAudiobookModel audiobook) async {
//     final db = await database;
//     await db.insert(
//       AudiobookModelFields.audiobooksTable,
//       {
//         AudiobookModelFields.id: audiobook.id,
//         AudiobookModelFields.readable: audiobook.readable,
//         AudiobookModelFields.title: audiobook.title,
//         AudiobookModelFields.titleShort: audiobook.titleShort,
//         AudiobookModelFields.titleVersion: audiobook.titleVersion,
//         AudiobookModelFields.link: audiobook.link,
//         AudiobookModelFields.duration: audiobook.duration,
//         AudiobookModelFields.rank: audiobook.rank,
//         AudiobookModelFields.explicitLyrics: audiobook.explicitLyrics,
//         AudiobookModelFields.explicitContentLyrics: audiobook.explicitContentLyrics,
//         AudiobookModelFields.explicitContentCover: audiobook.explicitContentCover,
//         AudiobookModelFields.preview: audiobook.preview,
//         AudiobookModelFields.md5Image: audiobook.md5Image,
//         AudiobookModelFields.artistId: audiobook.artist?.id,
//         AudiobookModelFields.artistName: audiobook.artist?.name,
//         AudiobookModelFields.artistLink: audiobook.artist?.link,
//         AudiobookModelFields.artistPicture: audiobook.artist?.picture,
//         AudiobookModelFields.albumId: audiobook.album?.id,
//         AudiobookModelFields.albumTitle: audiobook.album?.title,
//         AudiobookModelFields.albumCover: audiobook.album?.cover,
//       },
//     );
//   }
//
//   Future<List<DataAudiobookModel>> getAllAudiobooks() async {
//     final db = await database;
//     final maps = await db.query(AudiobookModelFields.audiobooksTable);
//     return List.generate(maps.length, (i) {
//       final artist = ArtistAudiobookModel(
//         id: maps[i][AudiobookModelFields.artistId],
//         name: maps[i][AudiobookModelFields.artistName],
//         link: maps[i][AudiobookModelFields.artistLink],
//         picture: maps[i][AudiobookModelFields.artistPicture],
//       );
//       final album = AlbumAudiobookModel(
//         id: maps[i][AudiobookModelFields.albumId],
//         title: maps[i][AudiobookModelFields.albumTitle],
//         cover: maps[i][AudiobookModelFields.albumCover],
//       );
//       return DataAudiobookModel(
//         id: maps[i][AudiobookModelFields.id],
//         readable: maps[i][AudiobookModelFields.readable] == 1,
//         title: maps[i][AudiobookModelFields.title],
//         titleShort: maps[i][AudiobookModelFields.titleShort],
//         titleVersion: maps[i][AudiobookModelFields.titleVersion],
//         link: maps[i][AudiobookModelFields.link],
//         duration: maps[i][AudiobookModelFields.duration],
//         rank: maps[i][AudiobookModelFields.rank],
//         explicitLyrics: maps[i][AudiobookModelFields.explicitLyrics] == 1,
//         explicitContentLyrics: maps[i][AudiobookModelFields.explicitContentLyrics],
//         explicitContentCover: maps[i][AudiobookModelFields.explicitContentCover],
//         preview: maps[i][AudiobookModelFields.preview],
//         md5Image: maps[i][AudiobookModelFields.md5Image],
//         artist: artist,
//         album: album,
//       );
//     });
//   }
//
//   Future<void> updateAudiobook(DataAudiobookModel audiobook) async {
//     final db = await database;
//     await db.update(
//       AudiobookModelFields.audiobooksTable,
//       {
//         AudiobookModelFields.readable: audiobook.readable,
//         AudiobookModelFields.title: audiobook.title,
//         AudiobookModelFields.titleShort: audiobook.titleShort,
//         AudiobookModelFields.titleVersion: audiobook.titleVersion,
//         AudiobookModelFields.link: audiobook.link,
//         AudiobookModelFields.duration: audiobook.duration,
//         AudiobookModelFields.rank: audiobook.rank,
//         AudiobookModelFields.explicitLyrics: audiobook.explicitLyrics,
//         AudiobookModelFields.explicitContentLyrics: audiobook.explicitContentLyrics,
//         AudiobookModelFields.explicitContentCover: audiobook.explicitContentCover,
//         AudiobookModelFields.preview: audiobook.preview,
//         AudiobookModelFields.md5Image: audiobook.md5Image,
//         AudiobookModelFields.artistId: audiobook.artist?.id,
//         AudiobookModelFields.artistName: audiobook.artist?.name,
//         AudiobookModelFields.artistLink: audiobook.artist?.link,
//         AudiobookModelFields.artistPicture: audiobook.artist?.picture,
//         AudiobookModelFields.albumId: audiobook.album?.id,
//         AudiobookModelFields.albumTitle: audiobook.album?.title,
//         AudiobookModelFields.albumCover: audiobook.album?.cover,
//       },
//       where: '${AudiobookModelFields.id} = ?',
//       whereArgs: [audiobook.id],
//     );
//   }
//
//   Future<void> deleteAudiobook(int id) async {
//     final db = await database;
//     await db.delete(
//       AudiobookModelFields.audiobooksTable,
//       where: '${AudiobookModelFields.id} = ?',
//       whereArgs: [id],
//     );
//   }
//
//   Future<DataAudiobookModel?> getAudiobook(int id) async {
//     final db = await database;
//     final maps = await db.query(
//       AudiobookModelFields.audiobooksTable,
//       columns: null,
//       where: '${AudiobookModelFields.id} = ?',
//       whereArgs: [id],
//     );
//     if (maps.isNotEmpty) {
//       final artist = ArtistAudiobookModel(
//         id: maps[0][AudiobookModelFields.artistId],
//         name: maps[0][AudiobookModelFields.artistName],
//         link: maps[0][AudiobookModelFields.artistLink],
//         picture: maps[0][AudiobookModelFields.artistPicture],
//       );
//       final album = AlbumAudiobookModel(
//         id: maps[0][AudiobookModelFields.albumId],
//         title: maps[0][AudiobookModelFields.albumTitle],
//         cover: maps[0][AudiobookModelFields.albumCover],
//       );
//       return DataAudiobookModel(
//         id: maps[0][AudiobookModelFields.id],
//         readable: maps[0][AudiobookModelFields.readable] == 1,
//         title: maps[0][AudiobookModelFields.title],
//         titleShort: maps[0][AudiobookModelFields.titleShort],
//         titleVersion: maps[0][AudiobookModelFields.titleVersion],
//         link: maps[0][AudiobookModelFields.link],
//         duration: maps[0][AudiobookModelFields.duration],
//         rank: maps[0][AudiobookModelFields.rank],
//         explicitLyrics: maps[0][AudiobookModelFields.explicitLyrics] == 1,
//         explicitContentLyrics: maps[0][AudiobookModelFields.explicitContentLyrics],
//         explicitContentCover: maps[0][AudiobookModelFields.explicitContentCover],
//         preview: maps[0][AudiobookModelFields.preview],
//         md5Image: maps[0][AudiobookModelFields.md5Image],
//         artist: artist,
//         album: album,
//       );
//     }
//     return null;
//   }
//
//   Future<void> close() async {
//     final db = await database;
//     db.close();
//   }
// }
