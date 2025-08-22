import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:path_provider/path_provider.dart';
import 'package:hezmart/core/utils/image_downloader.dart';


part 'image_downloader_event.dart';

part 'image_downloader_state.dart';

class ImageDownloaderBloc
    extends Bloc<ImageDownloaderEvent, ImageDownloaderState> {
  final imageDownLoader = ImageDownloader();

  ImageDownloaderBloc() : super(ImageDownloaderInitial()) {
    on<ImageDownloaderEvent>((event, emit) {});
    on<DownloadImageEvent>(_mapDownloadImageEventToState);
  }

  FutureOr<void> _mapDownloadImageEventToState(DownloadImageEvent event,
      Emitter<ImageDownloaderState> emit) async {
    emit(DownloadImageLoading());

    try {
      var result = await imageDownLoader.downloadImage(
          event.url, await getAppDownloadDirectory(event.fileName));

      result.fold((left) => emit(DownloadImageFailure(left)),
              (right) => emit(DownloadImageSuccess(right)));
    } catch (e, stack) {
      log(e.toString());
      log(stack.toString());
      emit(DownloadImageFailure(e.toString()));
    }
  }
}

Future<String> getAppDownloadDirectory(String name) async {
  // Directory? appDocDirectory = await getExternalStorageDirectory();

  Directory mySubdirectory = Platform.isAndroid
      ? Directory('/storage/emulated/0/Download/')
      : await getApplicationSupportDirectory();

  return "${mySubdirectory.path}${DateTime
      .now()
      .microsecondsSinceEpoch}$name.pdf";
}
