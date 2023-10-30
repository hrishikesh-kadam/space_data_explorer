import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../../constants/assets.dart';
import '../../constants/dimensions.dart';
import '../../constants/labels.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import '../../nasa/route/nasa_route.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/image_widget.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
      _getSourceGridView(context: context),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pageMarginVerticalHalf,
        ),
      )
    ];
  }

  Widget _getSourceGridView({required BuildContext context}) {
    final List<Widget> orgItems = _getOrgItems(context: context);
    final gridParameters = getSliverMasonryGridParameters(
      context: context,
      itemBoxWidth: Dimensions.orgItemBoxWidth,
      pageMarginHorizontal: Dimensions.pageMarginHorizontalHalf,
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
        imageAssetName: NasaAssets.logo,
        imageSemanticLabel: Labels.nasaLogo,
        uri: NasaRoute.uri,
      ),
      _getOrgItem(
        context: context,
        key: isroItemKey,
        name: Labels.isro,
        imageAssetName: IsroAssets.logo,
        imageSemanticLabel: Labels.isroLogo,
      ),
      _getOrgItem(
        context: context,
        key: esaItemKey,
        name: Labels.esa,
        imageAssetName: EsaAssets.logo,
        imageSemanticLabel: Labels.esaLogo,
      ),
      _getOrgItem(
        context: context,
        key: isaItemKey,
        name: Labels.isa,
        imageAssetName: IsaAssets.logo,
        imageSemanticLabel: Labels.isaLogo,
      ),
      _getOrgItem(
        context: context,
        key: kariItemKey,
        name: Labels.kari,
        imageAssetName: KariAssets.logo,
        imageSemanticLabel: Labels.kariLogo,
      ),
      _getOrgItem(
        context: context,
        key: spacexItemKey,
        name: Labels.spacex,
        imageAssetName: SpacexAssets.logo,
        imageSemanticLabel: Labels.spacexLogo,
      ),
      _getOrgItem(
        context: context,
        key: jaxaItemKey,
        name: Labels.jaxa,
        imageAssetName: JaxaAssets.logo,
        imageSemanticLabel: Labels.jaxaLogo,
      ),
    ];
  }

  Widget _getOrgItem({
    required BuildContext context,
    Key? key,
    required String name,
    required String imageAssetName,
    required String imageSemanticLabel,
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
              context: context,
              borderRadius: borderRadius,
              child: Column(
                children: [
                  getImageWidget(
                    assetName: imageAssetName,
                    semanticLabel: imageSemanticLabel,
                    width: Dimensions.orgImageSize,
                    // height: Dimensions.orgImageSize,
                  ),
                  const SizedBox(height: Dimensions.bodyItemSpacer),
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
    required BuildContext context,
    required BorderRadius borderRadius,
    required Widget child,
  }) {
    return Container(
      key: orgItemContainerKey,
      width: Dimensions.orgItemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: borderRadius,
        // TODO(hrishikesh-kadam): Change this to some surfaceContainer once
        // they are available.
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      padding: const EdgeInsets.all(Dimensions.bodyItemPadding),
      child: child,
    );
  }
}
