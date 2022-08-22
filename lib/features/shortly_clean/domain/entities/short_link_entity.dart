class ShortLink {
  final String id;
  final String fullShortLink;
  bool isCopied;

  ShortLink({
    required this.id,
    required this.fullShortLink,
    this.isCopied = false,
  });
}
