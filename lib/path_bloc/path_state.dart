// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'path_bloc.dart';

@immutable
abstract class PathState {}

class PathInitial extends PathState {
  @override
  String toString() => 'PathInitial()';
}

class HasImagesFromPicturesState extends PathState {
  HasImagesFromPicturesState();

  @override
  String toString() => 'HasImagesFromPicturesState()';
}

class ShowGalleryViewState extends PathState {
  ShowGalleryViewState();

  @override
  String toString() => 'ShowGalleryViewState()';
}

class HasNextImgState extends PathState {
  final File image;
  HasNextImgState({
    required this.image,
  });

  @override
  String toString() => 'HasNextImgState(image: $image)';
}
