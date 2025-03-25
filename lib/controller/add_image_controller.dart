
    import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';



class AddImageController extends GetxController {
  var image= ''.obs;
  
Future pickImageFromGallery() async {
      final ImagePicker picker = ImagePicker();
      final fetchedImage = await picker.pickImage(source: ImageSource.gallery);
      if (fetchedImage != null) {
        image.value=fetchedImage.path;
      }
    }

    Future pickImageFromCamera() async {
      final ImagePicker picker = ImagePicker();
      final fetchedImage = await picker.pickImage(source: ImageSource.camera);
      if (fetchedImage != null) {
         image.value=fetchedImage.path;
      }
    }

   bool validateImage(){
    if(image.value.isEmpty){
      Get.snackbar(
        'No image',
         'Please select an image',
         backgroundColor: Colors.red,
         colorText: Colors.white
        );
         return false;
    }
    return true;  
   }
}