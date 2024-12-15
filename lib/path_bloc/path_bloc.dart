import 'dart:io';

import 'package:desk_img/color_print/color_print.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'path_event.dart';
part 'path_state.dart';

class PathBloc extends Bloc<PathEvent, PathState> {
  List<File> images = [];
  int currentIndex = 0;
  String currentDirectory = "";
  PathBloc() : super(PathInitial()) {
    on<HasInitialRouteEvent>(_onHasInitialRouteEvent);
    on<NextImageEvent>(_onNextImageEvent);
    on<PreviousImageEvent>(_onPreviousImageEvent);
    on<NoInitailUriEvent>(_onNoInitailUriEvent);
    on<ShowGalleryViewEvent>(_onShowGalleryViewEvent);
    on<HasPicturesImageEvent>(_onHasPicturesImageEvent);
  }

  _onHasInitialRouteEvent(HasInitialRouteEvent event, Emitter<PathState> emit) {
    printG("Img viewer app initial Uri :${event.initialUri.toString()}");

    File initialFile = File.fromUri(event.initialUri);
    String directoryName = path.dirname(path.fromUri(event.initialUri));
    currentDirectory = directoryName;
    getImagesFromThisDirectory(directoryName);
    printC("Directory name: $directoryName");
    currentIndex = images.indexWhere(
      (element) {
        return element.path == initialFile.path;
      },
    );
    printR("Index of first file is : $currentIndex");
    emit(HasNextImgState(image: images[currentIndex]));
  }

  _onNextImageEvent(NextImageEvent event, Emitter<PathState> emit) {
    emit(PathInitial());
    currentIndex++;
    if (currentIndex >= images.length - 1) {
      currentIndex = 0;
    }
    emit(HasNextImgState(image: images[currentIndex]));
  }

  _onPreviousImageEvent(PreviousImageEvent event, Emitter<PathState> emit) {
    emit(PathInitial());
    currentIndex--;
    if (currentIndex < 0) {
      currentIndex = images.length - 1;
    }
    emit(HasNextImgState(image: images[currentIndex]));
  }

  _onNoInitailUriEvent(NoInitailUriEvent event, Emitter<PathState> emit) async {
    emit(PathInitial());

    if (images.isEmpty) {
      String picturesDirectory = await getPicturesDirectory();
      getImagesFromThisDirectory(picturesDirectory);
    }

    emit(HasImagesFromPicturesState());
  }

  _onShowGalleryViewEvent(
      ShowGalleryViewEvent event, Emitter<PathState> emit) async {
    emit(PathInitial());
    if (images.isEmpty) {
      getImagesFromThisDirectory(currentDirectory);
    }

    emit(ShowGalleryViewState());
  }

  _onHasPicturesImageEvent(
      HasPicturesImageEvent event, Emitter<PathState> emit) async {
    currentIndex = event.index;
    emit(HasNextImgState(image: event.image));
  }

  /// Returns Pictures directory of a user.
  Future<String> getPicturesDirectory() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String baseUser = path.dirname(documentsDir.path);
    String pictureDirectory = path.join(baseUser, "Pictures");
    return pictureDirectory;
  }

  /// Lists all the images available in passed directory.
  void getImagesFromThisDirectory(String directoryName) {
    Directory directoryNew = Directory(directoryName);

    List<File> allTheFilesInThisDirectory =
        directoryNew.listSync().whereType<File>().toList();

    for (File i in allTheFilesInThisDirectory) {
      switch (path.extension(i.path)) {
        case '.jpg':
          images.add(i);
          break;
        case '.jpeg':
          images.add(i);
          break;
        case '.png':
          images.add(i);
          break;
        case '.webp':
          images.add(i);
          break;
        case '.gif':
          images.add(i);
          break;
        default:
      }
    }
  }
}

// Directory directoryNew = Directory(directoryName);

//     List<File> allTheFilesInThisDirectory =
//         directoryNew.listSync().whereType<File>().toList();

//     printM(allTheFilesInThisDirectory.toString());

//     for (File i in allTheFilesInThisDirectory) {
//       switch (path.extension(i.path)) {
//         case '.jpg':
//           images.add(i);
//           break;
//         case '.jpeg':
//           images.add(i);
//           break;
//         case '.png':
//           images.add(i);
//           break;
//         case '.webp':
//           images.add(i);
//           break;
//         case '.gif':
//           images.add(i);
//           break;
//         default:
//       }
//     }