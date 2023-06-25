import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController? videoController;
  late RxString videoUrl;
  @override
  void onInit() {
    super.onInit();
    videoUrl = ''.obs;
    videoController = VideoPlayerController.network(videoUrl.value);
    fetchVideoUrlFromFirestore('mediavideo', 'nama_pt');
  }

  Future<void> fetchVideoUrlFromFirestore(
      String nama_pt, String mediavideo) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Tempat')
          .doc('PT INKA (Persero)')
          .collection('mediavideo')
          .doc('id')
          .get();
      print('doc ${doc.data()}');
      if (doc.exists) {
        String? url = doc['mediavideo'];
        log('log 2 : ' + (doc['mediavideo']).toString());
        if (url != null) {
          videoUrl.value = url;
          videoController = VideoPlayerController.network(videoUrl.value);
          videoController?.initialize().then((_) {
            videoController?.setLooping(true);
            videoController?.play();
            update();
          });
        }
      }
    } catch (e) {
      print('Error fetching video URL: $e');
    }
  }

  @override
  void onClose() {
    super.onClose();
    videoController?.dispose();
  }
}
