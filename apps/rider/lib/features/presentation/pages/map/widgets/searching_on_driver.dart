import 'package:design/design.dart';
import 'package:lottie/lottie.dart';

class SearchingOnDriverWidget extends StatelessWidget {
  final double height;
  final GestureTapCallback? onTap;

  const SearchingOnDriverWidget({Key? key, required this.height, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: Colors.white.withOpacity(.9),
        ),
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Lottie.asset(
                'assets/lottie/loading.json',
                height: 260,
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26.0),
                    border: Border.all(width: 2.0, color: Colors.grey[300]!),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 26.0,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  "إالغاء ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
