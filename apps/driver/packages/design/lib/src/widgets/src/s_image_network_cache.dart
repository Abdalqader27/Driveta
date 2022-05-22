/// File created by
/// Abed <Abed-supy-io>
/// on 28 /Apr/2022
part of widgets;

class SImageNetworkCache extends StatelessWidget {
  final String path;
  final Size progressSize;

  const SImageNetworkCache({
    Key? key,
    required this.path,
    this.progressSize = const Size(60, 60),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: path,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return _ProgressIndicator(
          downloadProgress: downloadProgress,
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
      width: progressSize.width,
      height: progressSize.height,
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final DownloadProgress downloadProgress;
  final Size progressSize;

  const _ProgressIndicator({
    required this.downloadProgress,
    this.progressSize = const Size(60, 60),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: progressSize.width,
      height: progressSize.height,
      child: Center(
        child: SizedBox(
          width: progressSize.width / 3,
          height: progressSize.height / 3,
          child: CircularProgressIndicator.adaptive(strokeWidth: 3, value: downloadProgress.progress),
        ),
      ),
    );
  }
}
