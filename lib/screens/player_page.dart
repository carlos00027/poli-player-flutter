import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late AudioPlayer player;
  bool isPlaying = false;
  bool isPause = false;
  String resourceSound = 'sounds/sound1.mp3';

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.setVolume(0.9);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> onPlay() async {
    setState(() {
      isPlaying = true;
      isPause = false;
    });
    await player.play(AssetSource(resourceSound));
    player.setVolume(1);
  }

  Future<void> onPause() async {
    setState(() {
      isPlaying = false;
      isPause = true;
    });
    await player.pause();
  }

  Future<void> onStop() async {
    setState(() {
      isPlaying = false;
      isPause = false;
    });
    await player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
              ),
              child: Text("poliplayer ${isPlaying ? 'reproduciendo...' : 'detenido'}"),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isPlaying
                    ? const SizedBox()
                    : IconButton(
                        onPressed: onPlay,
                        icon: const Icon(Icons.play_arrow),
                        iconSize: 32,
                        color: Colors.white,
                      ),
                !isPause && !isPlaying
                    ? const SizedBox()
                    : IconButton(
                        onPressed: onPause,
                        icon: const Icon(Icons.pause_circle),
                        iconSize: 32,
                        color: Colors.white,
                      ),
                !isPause && !isPlaying
                    ? const SizedBox()
                    : IconButton(
                        onPressed: onStop,
                        icon: const Icon(Icons.stop_circle),
                        color: Colors.white,
                        iconSize: 32,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
