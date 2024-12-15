// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:desk_img/color_print/color_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../path_bloc/path_bloc.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'class/short_cut_classes.dart';
import 'widgets/app_bar_buttton.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _formImgNameKey = GlobalKey<FormState>();
  final ScreenshotController screenshotController = ScreenshotController();

  final _scaffoldKey = GlobalKey();
  int count = 0;

  getPicturesDirectory() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String baseUser = path.dirname(documentsDir.path);
    String pictureDirectory = path.join(baseUser, "Pictures");
    return pictureDirectory;
  }

  @override
  void initState() {
    super.initState();
    getPicturesDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PathBloc, PathState>(
      builder: (context, state) {
        int lengthOfImages = context.watch<PathBloc>().images.length;

        if (state is HasNextImgState) {
          int indexOfCurrentImg = context.watch<PathBloc>().currentIndex + 1;
          String directory = context.watch<PathBloc>().currentDirectory;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: appBarHeight,
              leadingWidth: 166,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        iconData: Icons.grid_4x4,
                        onTap: () {
                          if (directory != "") {
                            BlocProvider.of<PathBloc>(context)
                                .add(ShowGalleryViewEvent());
                          } else {
                            BlocProvider.of<PathBloc>(context)
                                .add(NoInitailUriEvent());
                          }
                        },
                        msg: "Show all available images"),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text('$indexOfCurrentImg/$lengthOfImages'),
                    )),
                  ],
                ),
              ],
              leading: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Text(
                    path.basename(state.image.path),
                    style: const TextStyle(
                        color: secondLightBlue, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ))
                ],
              ),
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8)),
                height: appBarHeight - 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomButton(
                        iconData: Icons.save,
                        msg: 'Save image',
                        onTap: () {
                          // saveImgDialog(context);
                        },
                      ),
                      CustomButton(
                        iconData: Icons.crop,
                        msg: 'Crop image',
                        onTap: () {
                          // if (file != null) {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => CropScreen(
                          //       sendedImg: file!,
                          //     ),
                          //   ));
                          // }
                        },
                      ),
                      CustomButton(
                        iconData: Icons.rotate_left,
                        msg: 'Rotate Anticlockwise 90 degrees',
                        onTap: () {
                          // setState(() {
                          //   countFactor++;

                          //   toRotate = true;
                          // });
                        },
                      ),
                      CustomButton(
                        iconData: Icons.text_fields,
                        msg: 'Add text',
                        onTap: () {
                          // addNewDialog(context);
                        },
                      ),
                      CustomButton(
                        iconData: Icons.border_color,
                        iconColor: Colors.blueGrey,
                        msg: 'Font color -Current',
                        onTap: () {
                          // addColorDialog(context);
                        },
                      ),
                      CustomButton(
                        iconData: Icons.text_increase_rounded,
                        msg: 'Increase font size',
                        onTap: () {},
                      ),
                      CustomButton(
                        iconData: Icons.text_decrease_rounded,
                        msg: 'Decrease font size',
                        onTap: () {},
                      ),
                      CustomButton(
                        iconData: Icons.font_download,
                        msg: 'Change font',
                        onTap: () {
                          // changeFont(context);
                        },
                      ),
                      CustomButton(
                        iconData: Icons.format_bold_rounded,
                        msg: 'Bold text',
                        onTap: () {},
                      ),
                      CustomButton(
                        iconData: Icons.format_italic_rounded,
                        msg: 'Itallic Text',
                        onTap: () {},
                      ),
                      PopupMenuButton(
                        offset: const Offset(0, 50),
                        icon: const Icon(Icons.more_horiz),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              onTap: () {
                                // setState(() {
                                //   showExtract = !showExtract;
                                // });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.hide_image_rounded),
                                  Text('Show/Hide Extract Color Menu.')
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.developer_mode),
                                  Text(' About developer')
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.person),
                                  Text(' Follow me on Github')
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                // Future.delayed(const Duration(seconds: 0),
                                //     () => showNoteDialog(context));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(Icons.help_outline),
                                  Text(' Readme Important'),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Shortcuts(
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.arrowRight):
                    NextImageIntent(),
                SingleActivator(LogicalKeyboardKey.arrowLeft):
                    PreviousImageIntent(),
              },
              child: Actions(
                actions: <Type, Action<Intent>>{
                  NextImageIntent: CallbackAction<NextImageIntent>(
                    onInvoke: (NextImageIntent intent) {
                      BlocProvider.of<PathBloc>(context).add(NextImageEvent());
                      printC("Next Image");
                    },
                  ),
                  PreviousImageIntent: CallbackAction<PreviousImageIntent>(
                    onInvoke: (PreviousImageIntent intent) {
                      BlocProvider.of<PathBloc>(context)
                          .add(PreviousImageEvent());

                      printC("Previous Image");
                    },
                  ),
                },
                child: Focus(
                  autofocus: true,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Image.file(state.image,
                                          filterQuality: FilterQuality.medium,
                                          frameBuilder: ((context, child, frame,
                                              wasSynchronouslyLoaded) {
                                        // if (wasSynchronouslyLoaded) {
                                        //   return child;
                                        // }
                                        // return frame != null
                                        //     ? child
                                        //     : Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         mainAxisSize: MainAxisSize.min,
                                        //         children: const [
                                        //           SizedBox(
                                        //             height: 60,
                                        //             width: 60,
                                        //             child:
                                        //                 CircularProgressIndicator(
                                        //                     strokeWidth: 6),
                                        //           )
                                        //         ],
                                        //       );

                                        return AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: frame != null
                                              ? child
                                              : const SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 6),
                                                ),
                                        );
                                      })
                                          // height: 400,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        // If app is not opened by initial path then :
        if (state is HasImagesFromPicturesState) {
          List<File> picImages = context.watch<PathBloc>().images;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              toolbarHeight: 30,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Showing Images from Pictures",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    "Images in this folder: $lengthOfImages",
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: picImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<PathBloc>(context).add(
                          HasPicturesImageEvent(
                              image: picImages[index], index: index));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(picImages[index], fit: BoxFit.cover,
                          frameBuilder:
                              ((context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: frame != null
                              ? child
                              : const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 6),
                                ),
                        );
                      })),
                    ),
                  );
                },
              ),
            ),
          );
        }

        // Show grid view for initial paths images
        if (state is ShowGalleryViewState) {
          List<File> picImages = context.watch<PathBloc>().images;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              toolbarHeight: 30,
              title: Text(
                "Images in this folder: $lengthOfImages",
                style: const TextStyle(fontSize: 17),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: picImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<PathBloc>(context).add(
                          HasPicturesImageEvent(
                              image: picImages[index], index: index));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.file(picImages[index], fit: BoxFit.cover,
                          frameBuilder:
                              ((context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: frame != null
                              ? child
                              : const SizedBox(
                                  height: 60,
                                  width: 60,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 6),
                                ),
                        );
                      })),
                    ),
                  );
                },
              ),
            ),
          );
        }

        return const Center(
          child: Text("Error"),
        );
      },
    );
  }
}
