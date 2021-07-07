import 'package:flutter/material.dart';
import 'package:b2b_flutter_fixautonow/viewmodel/dropdown/ImagePickListener.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Circular_Image extends StatelessWidget {
  const Circular_Image({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imagePickerListener = Provider.of<ImagePickListener>(context);
    return Center(
        child: Container(
      width: 200,
      height: 200,
      child: Stack(children: [
        Container(
            width: 200,
            height: 200,
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  PhysicalModel(
                      elevation: 6.0,
                      shape: BoxShape.circle,
                      shadowColor: Colors.black54,
                      color: Colors.grey,
                      child: imagePickerListener.uploadimage == null
                          ? (imagePickerListener.imagePath != null
                              ? ClipOval(
                                  child: Image.network(
                                  imagePickerListener.imagePath,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    // Appropriate logging or analytics, e.g.
                                    // myAnalytics.recordError(
                                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                    //   exception,
                                    //   stackTrace,
                                    // );
                                    return Container(
                                      width: 200,
                                      height: 200,
                                    );
                                  },
                                ))
                              : Container(
                                  width: 200,
                                  height: 200,
                                ))
                          : //if file is not null
                          ClipOval(
                              child: Image.file(
                              imagePickerListener.uploadimage,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                // Appropriate logging or analytics, e.g.
                                // myAnalytics.recordError(
                                //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                //   exception,
                                //   stackTrace,
                                // );
                                return Container(
                                  width: 200,
                                  height: 200,
                                );
                              },
                            ) //load image from file
                              ))
                ])),
        Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              onPressed: () {
                imagePickerListener.getFile();
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: FaIcon(
                FontAwesomeIcons.image,
                size: 18,
                color: Colors.white,
              ),
              shape: CircleBorder(),
            ))
      ]),
    ));
  }
}

/*

class Circular_Image extends StatefulWidget {
  const Circular_Image({Key key}) : super(key: key);

  @override
  _Circular_ImageState createState() => _Circular_ImageState();
}

class _Circular_ImageState extends State<Circular_Image> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ImagePickListener>(context, listen: false)
        .changeImage(imagePath: null);
  }

  @override
  Widget build(BuildContext context) {
    var imagePickerListener = Provider.of<ImagePickListener>(context);
    return Center(
        child: Container(
      width: 200,
      height: 200,
      child: Stack(children: [
        Container(
            width: 200,
            height: 200,
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  PhysicalModel(
                      elevation: 6.0,
                      shape: BoxShape.circle,
                      shadowColor: Colors.black54,
                      color: Colors.grey,
                      child: imagePickerListener.uploadimage == null
                          ? (imagePickerListener.imagePath != null
                              ? ClipOval(
                                  child: Image.network(
                                  imagePickerListener.imagePath,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    // Appropriate logging or analytics, e.g.
                                    // myAnalytics.recordError(
                                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                    //   exception,
                                    //   stackTrace,
                                    // );
                                    return Container(
                                      width: 200,
                                      height: 200,
                                    );
                                  },
                                ))
                              : Container(
                                  width: 200,
                                  height: 200,
                                ))
                          : //if file is not null
                          ClipOval(
                              child: Image.file(
                              imagePickerListener.uploadimage,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                // Appropriate logging or analytics, e.g.
                                // myAnalytics.recordError(
                                //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                //   exception,
                                //   stackTrace,
                                // );
                                return Container(
                                  width: 200,
                                  height: 200,
                                );
                              },
                            ) //load image from file
                              ))
                ])),
        Align(
            alignment: Alignment.bottomRight,
            child: MaterialButton(
              onPressed: () {
                imagePickerListener.getFile();
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: FaIcon(
                FontAwesomeIcons.image,
                size: 18,
                color: Colors.white,
              ),
              shape: CircleBorder(),
            ))
      ]),
    ));
  }
}
*/
