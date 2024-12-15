// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'path_bloc.dart';

@immutable
abstract class PathEvent {}

class HasInitialRouteEvent extends PathEvent {
  final Uri initialUri;
  HasInitialRouteEvent({
    required this.initialUri,
  });
}

class NextImageEvent extends PathEvent {}

class PreviousImageEvent extends PathEvent {}

class NoInitailUriEvent extends PathEvent {}

class ShowGalleryViewEvent extends PathEvent {}

class HasPicturesImageEvent extends PathEvent {
  final File image;
  final int index;
  HasPicturesImageEvent({
    required this.image,
    required this.index,
  });
}
