import 'dart:math';

import 'package:shared_manifest/manifest.dart';
import 'package:flutter/material.dart';

import 'custom_clipper.dart';
import 'hex_color.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                HexColor.toColor(ColorManifest.SECONDARY_COLOR),
                HexColor.toColor(ColorManifest.PRIMARY_COLOR)
              ])),
        ),
      ),
    ));
  }
}
