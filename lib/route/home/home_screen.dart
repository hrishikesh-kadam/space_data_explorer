import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../../constants/dimensions.dart';
import '../../constants/labels.dart';
import '../../constants/theme.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import '../../nasa/route/nasa_route.dart';
import '../../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.l10n,
  });

  final String title;
  final AppLocalizations l10n;
  static const String keyPrefix = 'home_screen_';
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key orgGridKey = Key('${keyPrefix}org_grid_key');
  static const Key orgItemContainerKey =
      Key('${keyPrefix}org_item_container_key');
  static const Key nasaItemKey = Key('${keyPrefix}nasa_item_key'); // 29/07/1958
  static const Key isroItemKey = Key('${keyPrefix}isro_item_key'); // 15/08/1969
  static const Key esaItemKey = Key('${keyPrefix}esa_item_key'); // 30/05/1975
  static const Key isaItemKey = Key('${keyPrefix}isa_item_key'); // 04/1983
  static const Key kariItemKey = Key('${keyPrefix}kari_item_key'); // 10/10/1989
  static const Key spacexItemKey =
      Key('${keyPrefix}spacex_item_key'); // 14/03/2002
  static const Key jaxaItemKey = Key('${keyPrefix}jaxa_item_key'); // 01/10/2003

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
          bottom: Dimensions.pagePaddingVertical,
        ),
      ),
      _getSourceGridView(context: context),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
        ),
      )
    ];
  }

  Widget _getSourceGridView({required BuildContext context}) {
    final List<Widget> orgItems = _getOrgItems(context: context);
    final gridParameters = getSliverMasonryGridParameters(
      context: context,
      itemExtent: Dimensions.orgItemExtent,
      pagePaddingHorizontal: Dimensions.pagePaddingHorizontal,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: gridParameters.$1,
      ),
      sliver: SliverMasonryGrid.count(
        key: orgGridKey,
        crossAxisCount: gridParameters.$2,
        childCount: orgItems.length,
        itemBuilder: (context, index) {
          return orgItems[index];
        },
      ),
    );
  }

  List<Widget> _getOrgItems({
    required BuildContext context,
  }) {
    return [
      _getOrgItem(
        context: context,
        key: nasaItemKey,
        name: Labels.nasa,
        iconAssetPath: 'assets/nasa/nasa-logo.svg',
        // Source: https://upload.wikimedia.org/wikipedia/commons/e/e5/NASA_logo.svg
        iconSemanticsLabel: Labels.nasaLogo,
        uri: NasaRoute.uri,
      ),
      _getOrgItem(
        context: context,
        key: isroItemKey,
        name: Labels.isro,
        iconAssetPath: 'assets/isro/isro-logo.svg',
        // Source: https://upload.wikimedia.org/wikipedia/commons/b/bd/Indian_Space_Research_Organisation_Logo.svg
        iconSemanticsLabel: Labels.isroLogo,
      ),
      _getOrgItem(
        context: context,
        key: esaItemKey,
        name: Labels.esa,
        iconAssetPath: 'assets/esa/esa-logo.svg',
        // Source: https://upload.wikimedia.org/wikipedia/commons/b/bd/European_Space_Agency_logo.svg
        iconSemanticsLabel: Labels.esaLogo,
      ),
      _getOrgItem(
        context: context,
        key: isaItemKey,
        name: Labels.isa,
        // Source: https://upload.wikimedia.org/wikipedia/en/a/a8/Israel_Space_Agency_logo.png
        iconAssetPath: 'assets/isa/isa-logo.png',
        iconSemanticsLabel: Labels.isaLogo,
      ),
      _getOrgItem(
        context: context,
        key: kariItemKey,
        name: Labels.kari,
        // Source: https://upload.wikimedia.org/wikipedia/en/2/2e/KARI_seal.png
        iconAssetPath: 'assets/kari/kari-logo.png',
        iconSemanticsLabel: Labels.kariLogo,
      ),
      _getOrgItem(
        context: context,
        key: spacexItemKey,
        name: Labels.spacex,
        // Source: Copied the svg tag contents from spacex.com
        iconAssetPath: 'assets/spacex/spacex-logo.svg',
        iconSemanticsLabel: Labels.spacexLogo,
      ),
      _getOrgItem(
        context: context,
        key: jaxaItemKey,
        name: Labels.jaxa,
        iconAssetPath: 'assets/jaxa/jaxa-logo.svg',
        // Source: https://upload.wikimedia.org/wikipedia/commons/8/85/Jaxa_logo.svg
        iconSemanticsLabel: Labels.jaxaLogo,
      ),
    ];
  }

  Widget _getOrgItem({
    required BuildContext context,
    Key? key,
    required String name,
    required String iconAssetPath,
    required String iconSemanticsLabel,
    Uri? uri,
  }) {
    const borderRadius = BorderRadius.all(Radius.circular(
      Dimensions.containerRadius,
    ));
    return Padding(
      padding: const EdgeInsets.all(Dimensions.bodyItemMargin),
      child: Link(
        uri: uri,
        builder: (context, followLink) {
          return InkWell(
            key: key,
            onTap: () {
              if (uri != null) {
                GoRouter.of(context).go(uri.path, extra: getRouteExtraMap());
              } else {
                final snackBar = SnackBar(
                  content: Text(
                    AppLocalizations.of(context).notYetImplemented,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(snackBar);
              }
            },
            borderRadius: borderRadius,
            child: _getOrgItemContainer(
              borderRadius: borderRadius,
              child: Column(
                children: [
                  if (iconAssetPath.endsWith('svg'))
                    SvgPicture.asset(
                      iconAssetPath,
                      semanticsLabel: iconSemanticsLabel,
                      width: Dimensions.orgImageSize,
                      // height: imageSize,
                    ),
                  if (!iconAssetPath.endsWith('svg'))
                    Image.asset(
                      iconAssetPath,
                      semanticLabel: iconSemanticsLabel,
                      width: Dimensions.orgImageSize,
                      // height: imageSize,
                    ),
                  const SizedBox(height: 8),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getOrgItemContainer({
    required BorderRadius borderRadius,
    required Widget child,
  }) {
    return Container(
      key: orgItemContainerKey,
      width: Dimensions.orgItemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppTheme.containerBorderColor,
        ),
        borderRadius: borderRadius,
        color: AppTheme.containerColor,
      ),
      padding: const EdgeInsets.all(Dimensions.bodyItemPadding),
      child: child,
    );
  }
}
