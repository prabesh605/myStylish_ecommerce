abstract class UploadState {}

class UploadInitial extends UploadState {}

class UploadLoading extends UploadState {}

class UploadLoaded extends UploadState {
  String imageURl;
  UploadLoaded(this.imageURl);
}

class UploadError extends UploadState {
  String error;
  UploadError(this.error);
}
