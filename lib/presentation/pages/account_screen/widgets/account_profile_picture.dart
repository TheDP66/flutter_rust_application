import 'dart:io';

import 'package:InOut/core/params/user_params.dart';
import 'package:InOut/core/widgets/cached_image_auth.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountProfilePicture extends StatefulWidget {
  const AccountProfilePicture({super.key});

  @override
  State<AccountProfilePicture> createState() => _AccountProfilePictureState();
}

class _AccountProfilePictureState extends State<AccountProfilePicture> {
  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      type: FileType.image,
    );

    if (result != null) {
      File _file = File(result.files.first.path!);
      String fileName = _file.path.split('/').last;

      BlocProvider.of<AccountScreenBloc>(context).add(
        UpdateUser(
          UpdatePhotoParams(
            file: await MultipartFile.fromFile(
              _file.path,
              filename: fileName,
            ),
          ),
        ),
      );
    }
  }

  void _photoSheet(BuildContext context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      showDragHandle: true,
      builder: (_) => AccountBottomSheet(
        items: [
          ListItem(
            icon: Icons.image_outlined,
            text: 'New profile picture',
            onTap: () {
              _selectFile();
            },
          ),
          ListItem(
            icon: Icons.delete_outline,
            iconColor: Colors.red[500],
            text: 'Remove current picture',
            onTap: () {
              BlocProvider.of<AccountScreenBloc>(context).add(
                UpdateUser(
                  UpdatePhotoParams(
                    file: null,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountScreenBloc, AccountScreenState>(
      buildWhen: (prev, curr) {
        if (curr is LogoutLoading &&
            curr is LogoutLoaded &&
            curr is LogoutError) {
          return false;
        }

        return true;
      },
      builder: (context, state) {
        if (state is UpdateUserError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                content: Text(state.message),
              ),
            );
          });
        }

        if (state is UpdateUserLoaded) {
          BlocProvider.of<AccountScreenBloc>(context).add(
            FetchMeUser(),
          );
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                _photoSheet(context);
              },
              child: Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[100],
                  child: Container(
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: state is UpdateUserLoading
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          )
                        : state is AccountLoaded
                            ? CachedImageAuth(
                                photo: state.user.photo!,
                                size: 30,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  size: 45,
                                  color: Colors.black,
                                ),
                              )
                            : state is AccountError
                                ? const Icon(
                                    Icons.image_not_supported,
                                    size: 45,
                                    color: Colors.black,
                                  )
                                : const SizedBox(),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  _photoSheet(context);
                },
                child: const Text(
                  "Edit picture",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
