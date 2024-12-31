import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_player/audioplayer_bloc.dart';
import '../bloc/audio_player/audioplayer_event.dart';
import '../bloc/audio_player/audioplayer_state.dart';
import '../config/routes/routes_name.dart';
import '../models/song_model.dart';
import '../utils/colors/colors.dart';
import '../utils/constants.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayerBloc _audioPlayerBloc;

  @override
  void initState() {
    _audioPlayerBloc = AudioPlayerBloc(songs: songs);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // context.read<AudioPlayerBloc>().playerClose();
    _audioPlayerBloc.close();
  }

  final List<Song> songs = List.generate(3, (index) {
    return Song(
      title: "Track ${index + 1}",
      imagePath: "assets/images/music_icon${index + 1}.png",
      audioPath: "assets/audios/track${index + 1}.mp3",
    );
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _audioPlayerBloc,
      child: WillPopScope(
        onWillPop: () async {
          dialogBox(
              context: context,
              title: 'Are you sure?',
              message: 'Music will be stopped ',
              positiveOnPress: () {
                // context.read<AudioPlayerBloc>().playerClose();
                _audioPlayerBloc.playerClose();
                Navigator.pushNamed(context, RoutesName.homeScreen);
              },
              negativeOnPress: () {
                Navigator.pop(context);
              });

          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.greyColor,
          appBar: getAppBar(title: 'Music Player', context: context),
          body: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
            builder: (context, state) {
              //final bloc = context.read<AudioPlayerBloc>();
              final currentSong = songs[state.currentIndex];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                            const BoxShadow(
                                color: Colors.white,
                                offset: Offset(0, 0),
                                blurRadius: 15,
                                spreadRadius: 1),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              bottomRight: Radius.circular(45))),
                      child: Image.asset(currentSong.imagePath,
                          height: 200, width: 200)),
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade500,
                            spreadRadius: 1,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 0),
                              blurRadius: 15,
                              spreadRadius: 1),
                        ],
                        borderRadius: BorderRadius.circular(45)),
                    child: Column(
                      children: [
                        Text(
                          currentSong.title,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.skip_previous, size: 36),
                              onPressed: () =>
                                  _audioPlayerBloc.add(PlayPrevious()),
                            ),
                            IconButton(
                              icon: Icon(Icons.play_arrow, size: 36),
                              onPressed: () => _audioPlayerBloc.playPlayer(),
                            ),
                            IconButton(
                              icon: Icon(Icons.stop, size: 36),
                              onPressed: () => _audioPlayerBloc.stopPlayer(),
                            ),
                            IconButton(
                              icon: Icon(Icons.skip_next, size: 36),
                              onPressed: () => _audioPlayerBloc.add(PlayNext()),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Slider(
                          value: state.currentDuration.inSeconds.toDouble(),
                          max: _audioPlayerBloc
                                      .songs[state.currentIndex].audioPath !=
                                  null
                              ? _audioPlayerBloc.audioPlayer.duration?.inSeconds
                                      .toDouble() ??
                                  1.0
                              : 1.0,
                          onChanged: (value) {
                            _audioPlayerBloc.audioPlayer
                                .seek(Duration(seconds: value.toInt()));
                          },
                        ),
                        Text(
                            "${state.currentDuration.inMinutes}:${(state.currentDuration.inSeconds % 60).toString().padLeft(2, '0')}"),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
