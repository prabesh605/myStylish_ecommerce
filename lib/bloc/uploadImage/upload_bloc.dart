import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_event.dart';
import 'package:stylish_ecommerce/bloc/uploadImage/upload_state.dart';
import 'package:stylish_ecommerce/service/image_service.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  ImageService imageService;
  UploadBloc(this.imageService) : super(UploadInitial()) {
    File? imageFile;
    on<UploadImage>((event, emit) async {
      emit(UploadLoading());
      imageFile = await imageService.pickImageFromGallery();

      if (imageFile != null) {
        final String imageURl = await imageService.uploadImage(imageFile);
        emit(UploadLoaded(imageURl));
      }
      emit(UploadError("Error Uploading"));
    });
  }
}
