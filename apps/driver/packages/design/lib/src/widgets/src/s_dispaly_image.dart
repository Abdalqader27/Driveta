/// File created by/// Abed <Abed-supy-io>/// on 4 /May/2022part of widgets;/// TODO need to merge it with STextLogo classclass SDisplayImage extends StatelessWidget {  final String imagePath;  final VoidCallback onPressed;  final double radius;  final Color? color;  // Constructor  const SDisplayImage({    Key? key,    required this.imagePath,    required this.onPressed,    this.radius = 75,    this.color,  }) : super(key: key);  @override  Widget build(BuildContext context) {    return Center(        child: Stack(children: [      buildImage(),      Positioned(        child: buildEditIcon(),        right: 4,        top: 10,      )    ]));  }  // Builds Profile Image  Widget buildImage() {    final image = imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));    return CircleAvatar(      radius: radius,      backgroundColor: color,      child: CircleAvatar(        backgroundColor: color,        backgroundImage: image as ImageProvider,        radius: radius - 5,      ),    );  }  // Builds Edit Icon on Profile Picture  Widget buildEditIcon() => buildCircle(      all: 8,      child: Icon(        Icons.edit,        color: color,        size: 20,      ));  // Builds/Makes Circle for Edit Icon on Profile Picture  Widget buildCircle({    required Widget child,    required double all,  }) =>      ClipOval(          child: Container(        padding: EdgeInsets.all(all),        color: Colors.white,        child: child,      ));}