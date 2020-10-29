import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pictures_view/res/const.dart';
import 'package:pictures_view/res/image_assets.dart';
import 'package:rive/rive.dart';

mixin RiveAnimatedHeartMixin<T extends StatefulWidget> on State<T> {
  RiveAnimationController _controller;
  Artboard _riveArtBoard;
  bool _showRiveAnimation = false;
  bool _checkReverse = false;

  Widget get placeHolderIcon;

  RiveAnimationController get controller => _controller;

  @override
  void initState() {
    super.initState();
    rootBundle.load(ImageAssets.favoriteButtonRive).then(
      (ByteData data) async {
        final RiveFile file = RiveFile();

        if (file.import(data)) {
          _riveArtBoard = file.mainArtboard;
          chooseController;

          _controller.isActive = false;
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget get getRiveIcon {
    if (!_showRiveAnimation) return placeHolderIcon;

    if (_riveArtBoard == null) return SizedBox();

    return Rive(artboard: _riveArtBoard);
  }

  @mustCallSuper
  @protected
  void togglePlay() {
    _checkReverse = !_checkReverse;
    _riveArtBoard.removeController(_controller);

    chooseController;
    _showRiveAnimation = true;
    _controller.isActive = true;

    Future.delayed(kBaseChangeDuration, () {
      _showRiveAnimation = false;
      if (mounted) setState(() {});
    });

    setState(() {});
  }

  void get chooseController {
    _riveArtBoard.addController(
      _controller = SimpleAnimation(_checkReverse ? 'forward' : 'backward'),
    );
  }
}
