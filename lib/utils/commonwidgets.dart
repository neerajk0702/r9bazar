import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'Common.dart';
import 'mycolors.dart';

class CommonWidgets{

  static buttonshape(){
    return new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(10.0),
    );
  }static editTextBoxDecoration(){
    return new BoxDecoration(
      color:MyColors.lightgrey_100,

      borderRadius: new BorderRadius.circular(10.0),
    );
  }static  editTextBoxBoundryDecoration(String hinttext){
    return new InputDecoration(
      contentPadding: EdgeInsets.only(top: -15,bottom: 10,left: 10,right: 5),
      fillColor: Colors.white,
      border:  new OutlineInputBorder(

        borderSide: BorderSide(color: MyColors.darkgrey_60,width: 2),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),

        ),

      ),

      focusedBorder:  new OutlineInputBorder(

        borderSide: BorderSide(color: MyColors.primaryColor,width: 1),
        borderRadius: const BorderRadius.all(
          const Radius.circular(6.0),

        ),

      ),
      errorBorder: InputBorder.none,


      hintText: tr(hinttext),
    );
  }
  static snackbar(String message){
   return  SnackBar(content: Text(message,style: TextStyle(color: MyColors.primaryColor),).tr(),backgroundColor: Colors.white,);
  }
  static Future<File> selectProfileImage(BuildContext context, ) {
    cropImage(String imagePath) async {
      try {
        File croppedFile = await ImageCropper.cropImage(
            sourcePath: imagePath,
            cropStyle: CropStyle.circle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
            androidUiSettings: AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: IOSUiSettings(
              minimumAspectRatio: 1.0,
            ));
        return croppedFile;
      }catch(e){
        print(e.toString());
      }

    }

    Future<File> getImagefromPhone(
        ImageSource source,  BuildContext context) async {
      File croppedImage;
      try {
        if (Platform.isIOS) {
          var common = Provider.of<Common>(context);
          bool isValid = await common.checkMediaPermission(context);
          if (!isValid) {
            return null;
          }
        }
        PickedFile image = await ImagePicker()
            .getImage(
            source: source, preferredCameraDevice: CameraDevice.front);

        if (image != null && image.path != null) {
          croppedImage = await cropImage(image.path);
        }
        // Get.back(result: croppedImage);
        return croppedImage;
      }catch(e){
        print(e.toString());
      }
    }

    return getImagefromPhone(ImageSource.camera, context);




    // Widget bottomsheet() {
    //   return Container(
    //     padding: EdgeInsets.all(0),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         color: Get.theme.canvasColor,
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(15),
    //           topRight: Radius.circular(15),
    //         ),
    //       ),
    //       padding: const EdgeInsets.all(20.0),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: <Widget>[
    //           Align(
    //             alignment: Alignment.center,
    //             child: Text(
    //               ConstantString.selectprofilepic,
    //               style: Get.theme.textTheme.bodyText2,
    //             ),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.only(
    //               top: 30.0,
    //               left: 15.0,
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: <Widget>[
    //                 Column(
    //                   children: <Widget>[
    //                     FloatingActionButton(
    //                       backgroundColor: Colors.orange,
    //                       elevation: 0,
    //                       onPressed: () {
    //                         getImagefromPhone(ImageSource.camera, pr, context);
    //                       },
    //                       child: Icon(
    //                         Icons.camera_alt,
    //                         size: 34.0,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 12.0,
    //                     ),
    //                     Text(
    //                       ConstantString.camera,
    //                       style: Get.theme.textTheme.bodyText1,
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(width: 30),
    //                 Column(
    //                   children: <Widget>[
    //                     FloatingActionButton(
    //                       elevation: 0,
    //                       backgroundColor: Colors.orange,
    //                       onPressed: () => getImagefromPhone(ImageSource.gallery,
    //                           pr, context), //getImageGallery(pr, context),
    //                       child: Icon(
    //                         Icons.image,
    //                         color: Colors.white,
    //                         size: 34.0,
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 12.0,
    //                     ),
    //                     Text(
    //                       ConstantString.gallery,
    //                       style: Get.theme.textTheme.bodyText1,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // return Get.bottomSheet(
    //   bottomsheet(),
    //   backgroundColor: Get.theme.primaryColor,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     ),
    //   ),
    // );
  }
}