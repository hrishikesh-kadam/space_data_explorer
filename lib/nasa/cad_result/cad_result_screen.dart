import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../widgets/app_bar.dart';
import '../../constants/labels.dart';
import '../../extension/distance.dart';
import '../../extension/velocity.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import '../../route/settings/bloc/settings_bloc.dart';
import '../../route/settings/bloc/settings_state.dart';
import 'bloc/cad_result_bloc.dart';
import 'bloc/cad_result_state.dart';

class CadResultScreen extends StatelessWidget {
  CadResultScreen({
    super.key,
    required this.title,
    required this.l10n,
    required this.routeExtraMap,
    required this.zeroDigit,
  });

  final String title;
  final AppLocalizations l10n;
  final JsonMap routeExtraMap;
  final String zeroDigit;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.CadResultScreen');
  static const String keyPrefix = 'cad_result_screen_';
  static const Key customScrollViewKey = Key('${keyPrefix}scroll_view_key');
  static const Key zeroCountTextKey = Key('${keyPrefix}zero_count_text_key');
  static const Key totalTextKey = Key('${keyPrefix}total_text_key');
  static const Key gridKey = Key('${keyPrefix}grid_key');
  static const String gridItemKeyPrefix = '${keyPrefix}grid_item_';
  static const String gridItemContainerKeySuffix = 'container_key';
  static const String desKeyPrefix = 'des_';
  static const String orbitIdKeyPrefix = 'orbit_id_';
  static const String jdKeyPrefix = 'jd_';
  static const String cdKeyPrefix = 'cd_';
  static const String distKeyPrefix = 'dist_';
  static const String distMinKeyPrefix = 'dist_min_';
  static const String distMaxKeyPrefix = 'dist_max_';
  static const String vRelKeyPrefix = 'v_rel_';
  static const String vInfKeyPrefix = 'v_inf_';
  static const String tSigmaFKeyPrefix = 't_sigma_f_';
  static const String bodyKeyPrefix = 'body_';
  static const String hKeyPrefix = 'h_';
  static const String diameterKeyPrefix = 'diameter_';
  static const String diameterSigmaKeyPrefix = 'diameter_sigma_';
  static const String fullnameKeyPrefix = 'fullname_';
  @visibleForTesting
  static CadResultBloc? cadResultBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CadResultBloc>(
      create: (_) {
        if (flutterTest && cadResultBloc != null) {
          return cadResultBloc!;
        } else {
          return CadResultBloc(
            sbdbCadBody: routeExtraMap['$SbdbCadBody'],
          );
        }
      },
      child: Scaffold(
        body: _getBody(context: context),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _getBody({required BuildContext context}) {
    return BlocSelector<CadResultBloc, CadResultState, SbdbCadBody>(
      selector: (state) {
        return state.sbdbCadBody;
      },
      builder: (context, sbdbCadBody) {
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
            ..._getSliverBody(context: context, sbdbCadBody: sbdbCadBody),
          ],
        );
      },
    );
  }

  List<Widget> _getSliverBody({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
  }) {
    if (sbdbCadBody.total != null && sbdbCadBody.total! > 0) {
      return [_getTotalOnlyContent(context: context, sbdbCadBody: sbdbCadBody)];
    } else if (sbdbCadBody.count <= 0) {
      return [_getZeroCountContent(context: context)];
    } else {
      return _getGridContent(context: context, sbdbCadBody: sbdbCadBody);
    }
  }

  Widget _getZeroCountContent({required BuildContext context}) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(HrkDimensions.pageMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.cadResultScreenZeroCount,
              key: zeroCountTextKey,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTotalOnlyContent({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
  }) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: const EdgeInsets.all(HrkDimensions.pageMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${l10n.total} = '
              '${sbdbCadBody.total.toString().localizeDigits(
                    toZeroDigit: zeroDigit,
                  )}',
              key: totalTextKey,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getGridContent({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
  }) {
    return [
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: HrkDimensions.pageMarginVerticalHalf,
        ),
      ),
      _getGrid(context: context, sbdbCadBody: sbdbCadBody),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: HrkDimensions.pageMarginVerticalHalf,
        ),
      )
    ];
  }

  Widget _getGrid({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
  }) {
    final gridParameters = getSliverMasonryGridParameters(
      context: context,
      itemBoxWidth: HrkDimensions.bodyItemBoxWidth,
      pageMarginHorizontal: HrkDimensions.pageMarginHorizontalHalf,
    );
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: gridParameters.$1,
      ),
      sliver: SliverMasonryGrid.count(
        key: gridKey,
        crossAxisCount: gridParameters.$2,
        childCount: sbdbCadBody.count,
        itemBuilder: (context, index) {
          return getItemWidget(
            context: context,
            sbdbCadBody: sbdbCadBody,
            data: sbdbCadBody.data![index],
            index: index,
          );
        },
      ),
    );
  }

  static Key getGridItemContainerKey(int index) {
    return Key('$gridItemKeyPrefix${index}_$gridItemContainerKeySuffix');
  }

  Widget getItemWidget({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
    required SbdbCadData data,
    required int index,
  }) {
    return BodyItemContainer(
      key: getGridItemContainerKey(index),
      child: SelectionArea(
        child: getItemBody(
          context: context,
          sbdbCadBody: sbdbCadBody,
          data: data,
          index: index,
        ),
      ),
    );
  }

  Widget getItemBody({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
    required SbdbCadData data,
    required int index,
  }) {
    final itemIndexKeyPrefix = '$gridItemKeyPrefix${index}_';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LabelValueWrap(
          key: Key('$itemIndexKeyPrefix${desKeyPrefix}key'),
          keyPrefix: '$itemIndexKeyPrefix$desKeyPrefix',
          label: '${l10n.designation}:',
          value: data.des,
        ),
        if (sbdbCadBody.fields!.contains('fullname'))
          LabelValueWrap(
            key: Key('$itemIndexKeyPrefix${fullnameKeyPrefix}key'),
            keyPrefix: '$itemIndexKeyPrefix$fullnameKeyPrefix',
            label: '${l10n.fullname}:',
            value: data.fullname.toString().trim(),
          ),
        LabelValueWrap(
          key: Key('$itemIndexKeyPrefix${orbitIdKeyPrefix}key'),
          keyPrefix: '$itemIndexKeyPrefix$orbitIdKeyPrefix',
          label: '${l10n.orbitId}:',
          value: data.orbitId,
        ),
        LabelValueWrap(
          key: Key('$itemIndexKeyPrefix${jdKeyPrefix}key'),
          keyPrefix: '$itemIndexKeyPrefix$jdKeyPrefix',
          label: '${l10n.julianDate}:',
          value: '${data.jd} ${Labels.tdb}',
        ),
        BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) {
            return previous.dateFormatPattern != current.dateFormatPattern ||
                previous.timeFormatPattern != current.timeFormatPattern;
          },
          builder: (context, settingsState) {
            return LabelValueWrap(
              key: Key('$itemIndexKeyPrefix${cdKeyPrefix}key'),
              keyPrefix: '$itemIndexKeyPrefix$cdKeyPrefix',
              label: '${l10n.dateSlashTime}:',
              value: _formatCloseApproachDateTime(
                settingsState: settingsState,
                cd: data.cd,
              ),
            );
          },
        ),
        LabelValueWrap(
          key: Key('$itemIndexKeyPrefix${tSigmaFKeyPrefix}key'),
          keyPrefix: '$itemIndexKeyPrefix$tSigmaFKeyPrefix',
          label: '${l10n.timeSigma}:',
          value: data.tSigmaF,
        ),
        if (sbdbCadBody.fields!.contains('body'))
          LabelValueWrap(
            key: Key('$itemIndexKeyPrefix${bodyKeyPrefix}key'),
            keyPrefix: '$itemIndexKeyPrefix$bodyKeyPrefix',
            label: '${l10n.closeApproachBody}:',
            value: data.body != null
                ? getLocalizedBody(body: data.body!, l10n: l10n)
                : Labels.na,
          ),
        BlocSelector<SettingsBloc, SettingsState, DistanceUnit>(
          selector: (state) {
            return state.distanceUnit;
          },
          builder: (context, distanceUnit) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelValueWrap(
                  key: Key('$itemIndexKeyPrefix${distKeyPrefix}key'),
                  keyPrefix: '$itemIndexKeyPrefix$distKeyPrefix',
                  label: '${l10n.distance}:',
                  value: data.dist
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                ),
                LabelValueWrap(
                  key: Key('$itemIndexKeyPrefix${distMinKeyPrefix}key'),
                  keyPrefix: '$itemIndexKeyPrefix$distMinKeyPrefix',
                  label: '${l10n.distanceMin}:',
                  value: data.distMin
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                ),
                LabelValueWrap(
                  key: Key('$itemIndexKeyPrefix${distMaxKeyPrefix}key'),
                  keyPrefix: '$itemIndexKeyPrefix$distMaxKeyPrefix',
                  label: '${l10n.distanceMax}:',
                  value: data.distMax
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                ),
              ],
            );
          },
        ),
        BlocSelector<SettingsBloc, SettingsState, VelocityUnit>(
          selector: (state) {
            return state.velocityUnit;
          },
          builder: (context, velocityUnit) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LabelValueWrap(
                  key: Key('$itemIndexKeyPrefix${vRelKeyPrefix}key'),
                  keyPrefix: '$itemIndexKeyPrefix$vRelKeyPrefix',
                  label: '${l10n.velocityRel}:',
                  value: data.vRel
                      .convert(to: velocityUnit)
                      .toLocalizedString(l10n),
                ),
                LabelValueWrap(
                  key: Key('$itemIndexKeyPrefix${vInfKeyPrefix}key'),
                  keyPrefix: '$itemIndexKeyPrefix$vInfKeyPrefix',
                  label: '${l10n.velocityInf}:',
                  value: data.vInf != null
                      ? data.vInf!
                          .convert(to: velocityUnit)
                          .toLocalizedString(l10n)
                      : Labels.na,
                ),
              ],
            );
          },
        ),
        LabelValueWrap(
          key: Key('$itemIndexKeyPrefix${hKeyPrefix}key'),
          keyPrefix: '$itemIndexKeyPrefix$hKeyPrefix',
          label: '${l10n.absoulteMagnitude}:',
          value: data.h != null ? '${data.h} H' : Labels.na,
        ),
        if (sbdbCadBody.fields!.contains('diameter'))
          BlocSelector<SettingsBloc, SettingsState, DistanceUnit>(
            selector: (state) {
              return state.diameterUnit;
            },
            builder: (context, diameterUnit) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabelValueWrap(
                    key: Key('$itemIndexKeyPrefix${diameterKeyPrefix}key'),
                    keyPrefix: '$itemIndexKeyPrefix$diameterKeyPrefix',
                    label: '${l10n.diameter}:',
                    value: data.diameter != null
                        ? data.diameter!
                            .convert(to: diameterUnit)
                            .toLocalizedString(l10n)
                        : Labels.na,
                  ),
                  LabelValueWrap(
                    key: Key('$itemIndexKeyPrefix${diameterSigmaKeyPrefix}key'),
                    keyPrefix: '$itemIndexKeyPrefix$diameterSigmaKeyPrefix',
                    label: '${l10n.diameterSigma}:',
                    value: data.diameterSigma != null
                        ? data.diameterSigma!
                            .convert(to: diameterUnit)
                            .toLocalizedString(l10n)
                        : Labels.na,
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  String _formatCloseApproachDateTime({
    required SettingsState settingsState,
    required DateTime cd,
  }) {
    final dateFormat = settingsState.getDateFormat();
    final dateTimeStringBuffer = StringBuffer(dateFormat.format(cd));
    dateTimeStringBuffer.write(' ');
    final timeFormat = settingsState.getTimeFormat();
    dateTimeStringBuffer.write(timeFormat.format(cd));
    dateTimeStringBuffer.write(' ${Labels.tdb}');
    return dateTimeStringBuffer.toString();
  }

  static String getLocalizedBody({
    required String body,
    required AppLocalizations l10n,
  }) {
    return switch (body) {
      'Earth' => l10n.earth,
      'Moon' => l10n.moon,
      'Mercury' => l10n.mercury,
      'Venus' => l10n.venus,
      'Mars' => l10n.mars,
      'Jupiter' => l10n.jupiter,
      'Saturn' => l10n.saturn,
      'Uranus' => l10n.uranus,
      'Neptune' => l10n.neptune,
      'Pluto' => l10n.pluto,
      _ => body
    };
  }
}
