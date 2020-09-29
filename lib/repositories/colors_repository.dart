import 'package:pictures_view/adapters/colors_scheme_adapter.dart';
import 'package:pictures_view/models/models/color_scheme_model.dart';
import 'package:pictures_view/network/requests/get_default_color_scheme.dart';
import 'package:pictures_view/repositories/shared/repository.dart';

class ColorsRepository extends Repository {
  Future<ColorSchemeModel> getDefaultColorScheme() async {
    return await repository<ColorSchemeModel>(
      ColorSchemeAdapter(request: GetDefaultColorScheme()),
    );
  }
}
