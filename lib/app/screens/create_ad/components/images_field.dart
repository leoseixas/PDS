import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/screens/create_ad/components/image_source_modal.dart';
import 'package:works/app/stores/create_ad_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  ImagesField(this.createAdStore);
  final CreateAdStore createAdStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createAdStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(0),
          color: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          child: Container(
            height: 120,
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: createAdStore.images.length < 5
                      ? createAdStore.images.length + 1
                      : 5,
                  itemBuilder: (_, index) {
                    if (index == createAdStore.images.length)
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            if (Platform.isAndroid) {
                              showModalBottomSheet(
                                context: context,
                                builder: (_) =>
                                    ImageSourceModal(onImageSelected),
                              );
                            } else {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (_) =>
                                    ImageSourceModal(onImageSelected),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    else
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          8,
                          16,
                          index == 4 ? 8 : 0,
                          16,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => ImageDialog(
                                image: createAdStore.images[index],
                                onDelete: () =>
                                    createAdStore.images.removeAt(index),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 44,
                            backgroundImage:
                                FileImage(createAdStore.images[index]),
                          ),
                        ),
                      );
                  },
                );
              },
            ),
          ),
        ),
        Observer(
          builder: (_) {
            if (createAdStore.imagesError != null)
              return Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                padding: const EdgeInsets.fromLTRB(6, 8, 0, 8),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.red),
                  ),
                ),
                child: Text(
                  createAdStore.imagesError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              );
            else
              return Container();
          },
        )
      ],
    );
  }
}
