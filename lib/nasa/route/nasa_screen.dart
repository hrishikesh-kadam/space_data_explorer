import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:url_launcher/link.dart';

import '../../config/config.dart';
import '../../constants/assets.dart';
import '../../constants/dimensions.dart';
import '../../constants/labels.dart';
import '../../globals.dart';
import '../../route/home/home_route.dart';
import '../../route/page_not_found/page_not_found_route.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_widget.dart';
import '../../widgets/link_wrap.dart';
import '../cad/cad_route.dart';

class NasaScreen extends StatelessWidget {
  NasaScreen({
    super.key,
    required this.title,
    required this.l10n,
  });

  final String title;
  final AppLocalizations l10n;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.NasaScreen');
  static const String keyPrefix = 'nasa_screen_';
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key cadButtonKey = Key('${keyPrefix}cad_button_key');
  static const Key nonExistingPathButtonKey =
      Key('${keyPrefix}non_existing_path_button_key');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(context: context),
    );
  }

  Widget _getBody({required BuildContext context}) {
    return CustomScrollView(
      key: customScrollViewKey,
      controller: ScrollController(),
      slivers: [
        getSliverAppBar(
          context: context,
          title: Tooltip(
            message: title,
            child: Text(title),
          ),
          floating: true,
          snap: true,
        ),
        ..._getSliverBody(context: context),
      ],
    );
  }

  List<Widget> _getSliverBody({required BuildContext context}) {
    return [
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pageMarginVerticalHalf,
        ),
      ),
      _getHeader(context: context),
      _getSsdCneos(context: context),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pageMarginVerticalHalf,
        ),
      )
    ];
  }

  Widget _getHeader({required BuildContext context}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.pageMarginHorizontal,
        vertical: Dimensions.pageMarginVerticalHalf,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              Labels.nasaFullForm,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: Dimensions.bodyItemSpacer),
            getImageWidget(
              assetName: NasaAssets.logo,
              semanticLabel: Labels.nasaLogo,
              width: Dimensions.orgImageSize,
            ),
            const SizedBox(height: Dimensions.bodyItemSpacer),
            getLinkWrap(
              context: context,
              text: l10n.source,
              uri: NasaApis.docUrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSsdCneos({required BuildContext context}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.pageMarginHorizontal,
        vertical: Dimensions.pageMarginVerticalHalf,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Text(
              '${Labels.ssdCneos}:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Dimensions.bodyItemPadding),
            Link(
              uri: CadRoute.uri,
              builder: (context, followLink) {
                return OutlinedButton(
                  key: cadButtonKey,
                  child: Text(
                    Labels.sbdbCloseApproachData,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    CadRoute($extra: getRouteExtraMap()).go(context);
                  },
                );
              },
            ),
            if (flavorEnv == FlavorEnv.dev || flavorEnv == FlavorEnv.unflavored)
              const SizedBox(height: Dimensions.bodyItemPadding),
            if (flavorEnv == FlavorEnv.dev || flavorEnv == FlavorEnv.unflavored)
              Link(
                uri: PageNotFoundRoute.nonExistingUri,
                builder: (context, followLink) {
                  return OutlinedButton(
                    key: nonExistingPathButtonKey,
                    child: Text(
                      PageNotFoundRoute.nonExistingUri.path,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onPressed: () {
                      context.go(
                        PageNotFoundRoute.nonExistingUri.path,
                        extra: getRouteExtraMap(),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
