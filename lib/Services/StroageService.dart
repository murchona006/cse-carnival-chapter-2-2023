import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../Constants/Constants.dart';

class StorageService {
  static Future<String> uploadProfilePicture(String url, File imageFile) async {
    String? uniquePhotoId = Uuid().v4();
    File? image = await compressImage(uniquePhotoId, imageFile);

    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      uniquePhotoId = exp.firstMatch(url)![1];
    }
    UploadTask uploadTask = storageRef.child('images/users/userProfile_$uniquePhotoId.jpg').putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadCoverPicture(String url, File imageFile) async {
    String? uniquePhotoId = Uuid().v4();
    File? image = await compressImage(uniquePhotoId, imageFile);

    if (url.isNotEmpty) {
      RegExp exp = RegExp(r'userCover_(.*).jpg');
      uniquePhotoId = exp.firstMatch(url)![1];
    }
    UploadTask uploadTask = storageRef
        .child('images/users/userCover_$uniquePhotoId.jpg')
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> uploadPostPicture(File imageFile) async {
    String uniquePhotoId = Uuid().v4();
    File? image = await compressImage(uniquePhotoId, imageFile);

    UploadTask uploadTask = storageRef
        .child('images/posts/post_$uniquePhotoId.jpg')
        .putFile(image!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  static Future<File?> compressImage(String photoId, File image) async {
    final tempDirectory = await getTemporaryDirectory();
    final path = tempDirectory.path;
    File compressedImage = File('$path/img_$photoId.jpg');

    await FlutterImageCompress.compressAndGetFile(
      image.path,  // Use image.path, not image.absolute.path
      compressedImage.path,
      quality: 70,
    );

    return compressedImage;
  }
}
