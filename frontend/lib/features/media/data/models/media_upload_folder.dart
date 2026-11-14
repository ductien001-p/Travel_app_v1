enum MediaUploadFolder {
  avatars('avatars'),
  posts('posts'),
  places('places'),
  trips('trips');

  const MediaUploadFolder(this.apiValue);

  final String apiValue;
}
