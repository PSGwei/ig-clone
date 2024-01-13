import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utilities/colors.dart';
import 'package:instagram_clone/utilities/methods/storage_methods.dart';
import 'package:instagram_clone/utilities/methods/utilities.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? image;
  final TextEditingController captionController = TextEditingController();
  bool isUploading = false;

  Future<void> selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(20),
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  // example that the return value of showDialog()
                  //Navigator.pop(context, 'Option1');
                  Uint8List? file = await pickImage(ImageSource.camera);
                  setState(() {
                    image = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('From gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery);
                  setState(() {
                    image = file;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void uploadPost(String uid, String username, String profileImage) async {
    setState(() {
      isUploading = true;
    });
    try {
      String result = await StorageMethods().uploadPost(
          captionController.text, image!, uid, username, profileImage);
      if (result == 'Success') {
        setState(() {
          isUploading = false;
        });
        if (!context.mounted) return;
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        setState(() {
          isUploading = false;
        });
        if (!context.mounted) return;
        showSnackBar(result, context);
      }
    } catch (error) {
      if (!context.mounted) return;
      showSnackBar(error.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      image = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    return image == null
        ? Center(
            child: IconButton(
              onPressed: () async {
                await selectImage(context);
              },
              icon: const Icon(
                Icons.upload,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_sharp),
              ),
              title: const Text('Post to'),
              actions: [
                TextButton(
                  onPressed: () {
                    uploadPost(user!.uid, user.username, user.photoURL);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                isUploading
                    ? const LinearProgressIndicator()
                    : const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(defaultAvatar),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: captionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none,
                        ),
                        maxLines: 7,
                      ),
                    ),
                    SizedBox(
                      // used to constraints child widget
                      height: 45,
                      width: 45,
                      // since sizedbox was used, aspectratio may be redundant
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(image!),
                          ),
                        ),
                      ),
                      // child: AspectRatio(
                      //   aspectRatio: 487 / 451,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       image: DecorationImage(
                      //         image: NetworkImage(defaultAvatar),
                      //         fit: BoxFit.fill,
                      //         alignment: FractionalOffset.topCenter,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
