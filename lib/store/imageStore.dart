import 'package:carousel/api/client.dart';
import 'package:carousel/model/imageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

part 'imageStore.g.dart';

class ImageStore extends ImageStoreBase with _$ImageStore {
  static ImageStore? _instance;

  static ImageStore get instance {
    if (_instance == null) {
      _instance = ImageStore();
    }

    return _instance!;
  }
}

abstract class ImageStoreBase with Store {
  ObservableList<ImageModel> imageList = ObservableList();

  @action
  getImage() async {
    final list = await Client().getList();
    imageList = ObservableList.of(list);
  }
}
