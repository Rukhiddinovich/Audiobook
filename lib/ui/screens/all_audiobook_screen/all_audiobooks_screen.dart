part of 'all_audiobooks_screen_part.dart';

class AllAudiobooksScreen extends StatefulWidget {
  const AllAudiobooksScreen({
    super.key,
    required this.isConnect,
  });

  final bool isConnect;

  @override
  State<AllAudiobooksScreen> createState() => _AllAudiobooksScreenState();
}

class _AllAudiobooksScreenState extends State<AllAudiobooksScreen> {
  int countSet = 0;
  late AudiobookBloc bloc;
  late ConnectivityCubit connectivityCubit;

  @override
  void initState() {
    super.initState();
    connectivityCubit = context.read<ConnectivityCubit>();
    bloc = context.read<AudiobookBloc>();
    _init();
  }

  Future<void> _init() async {
    await _handleInitConnectivity();
    _setupConnectivityListener();
  }

  Future<void> _handleInitConnectivity() async {
    if (!widget.isConnect) {
      bloc.add(GetDownloadedAudiobooksEvent());
      if (Platform.isIOS && countSet == 0) {
        countSet++;
      }
    } else {
      bloc.add(GetAudiobooksDataEvent());
    }
  }

  void _setupConnectivityListener() {
    connectivityCubit.stream.listen((connectivityStatus) {
      if (connectivityStatus == ConnectivityStatus.disconnected) {
        bloc.add(GetDownloadedAudiobooksEvent());
        if (Platform.isIOS && countSet == 0) {
          countSet++;
        }
      } else if (connectivityStatus == ConnectivityStatus.connected) {
        bloc.add(GetAudiobooksDataEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: GlobalAppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10.w, left: 20.w),
              child: SvgPicture.asset(
                AppIcons.audiobookLogo,
                height: 50.h,
                width: 50.w,
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Audio",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                  color: AppColors.white,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Books",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24.sp,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AudiobookBloc, AudiobookState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == FormStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? "Error"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == FormStatus.loading && state.audiobookModel == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state.status == FormStatus.success) {
            if (state.audiobookModel == null || state.audiobookModel!.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_outlined,
                      size: 80.w,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "No audiobooks available",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ReorderableListView.builder(
              physics: const BouncingScrollPhysics(),
              proxyDecorator: (child, index, animation) => child,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: state.audiobookModel?.data?.length ?? 0,
              itemBuilder: (context, index) {
                final audiobook = state.audiobookModel?.data?[index];
                final isPlaying = state.currentIndex == index && state.isPlaying;
                return Padding(
                  key: Key(index.toString()),
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.c1C1C4D,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white, width: 1.w),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          audiobook?.artist?.pictureBig ?? "",
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.7,
                        filterQuality: FilterQuality.low,
                      )
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16.r),
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          bloc.add(CurrentIndexChangeEvent(index));
                          Navigator.pushNamed(
                            context,
                            RouteNames.audiobookScreen,
                            arguments: [audiobook, index],
                          );
                        },
                        borderRadius: BorderRadius.circular(16.r),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            children: [
                              RowItemsWidgets(
                                imageUrl: audiobook?.album?.coverXl ?? "",
                                musicName: audiobook?.title ?? "",
                                artistName: audiobook?.artist?.name ?? "",
                              ),
                              AllAudioControllerWidgets(
                                playPauseIcon: isPlaying ? CupertinoIcons.pause_fill : CupertinoIcons.play_arrow_solid,
                                volumeIcon: state.volumeByIndex[index] == 0 ? CupertinoIcons.volume_mute : CupertinoIcons.volume_down,
                                volumeColor: isPlaying ? AppColors.white : Colors.grey,
                                downloadIcon: CupertinoIcons.tray_arrow_down,
                                onTap: () {
                                  if (state.currentIndex == index) {
                                    bloc.add(PlayPauseEvent());
                                  } else {
                                    bloc.add(LoadAudioEvent(
                                      previewUrl: audiobook?.preview,
                                      index: index,
                                    ));
                                  }
                                },
                                volumeOnPressed: isPlaying ? () {
                                  bloc.add(ToggleVolumeEvent(index));
                                } : null,
                                downloadOnPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Downloading...${audiobook?.title}"),
                                    ),
                                  );
                                  if (audiobook != null) {
                                    bloc.add(SaveDownloadedAudiobookEvent(
                                      dataAudiobookModel: audiobook,
                                    ));
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Downloaded! ${audiobook?.title}"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) async {
                if (oldIndex < newIndex) newIndex -= 1;
                final isPlayingCurrentItem = state.currentIndex == oldIndex;
                final movedItem = state.audiobookModel?.data?.removeAt(oldIndex);
                if (movedItem != null) {
                  state.audiobookModel?.data?.insert(newIndex, movedItem);
                  final prefs = await SharedPreferences.getInstance();
                  final order = state.audiobookModel!.data!.map((a) => a.id.toString()).toList();
                  await prefs.setStringList('audiobook_order', order);
                  if (isPlayingCurrentItem) {
                    bloc.add(CurrentIndexChangeEvent(newIndex));
                  }
                  myPrint("CurrentIndex--------> ${state.currentIndex}");
                }
              },
            );
          } else if (state.status == FormStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? "Error",
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
