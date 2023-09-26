import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:intl/intl.dart';

import '../../../widgets/app_bar.dart';
import '../../constants/dimensions.dart';
import '../../constants/labels.dart';
import '../../constants/theme.dart';
import '../../extension/distance.dart';
import '../../extension/velocity.dart';
import '../../globals.dart';
import '../../helper/helper.dart';
import '../../route/settings/bloc/settings_bloc.dart';
import '../../route/settings/bloc/settings_state.dart';
import '../../route/settings/date_format_pattern.dart';
import '../../route/settings/time_format_pattern.dart';
import '../../widgets/directionality_widget.dart';
import 'bloc/cad_result_bloc.dart';
import 'bloc/cad_result_state.dart';
import 'cad_result_route.dart';

class CadResultScreen extends StatelessWidget {
  CadResultScreen({
    super.key,
    required this.l10n,
    required this.routeExtraMap,
    required this.zeroDigit,
  });

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
  static const String gridItemContainerKeyPrefix =
      '${keyPrefix}grid_item_container_';
  static const String desKeyPrefix = '${gridItemKeyPrefix}des_';
  static const String orbitIdKeyPrefix = '${gridItemKeyPrefix}orbit_id_';
  static const String jdKeyPrefix = '${gridItemKeyPrefix}jd_';
  static const String cdKeyPrefix = '${gridItemKeyPrefix}cd_';
  static const String distKeyPrefix = '${gridItemKeyPrefix}dist_';
  static const String distMinKeyPrefix = '${gridItemKeyPrefix}dist_min_';
  static const String distMaxKeyPrefix = '${gridItemKeyPrefix}dist_max_';
  static const String vRelKeyPrefix = '${gridItemKeyPrefix}v_rel_';
  static const String vInfKeyPrefix = '${gridItemKeyPrefix}v_inf_';
  static const String tSigmaFKeyPrefix = '${gridItemKeyPrefix}t_sigma_f_';
  static const String bodyKeyPrefix = '${gridItemKeyPrefix}body_';
  static const String hKeyPrefix = '${gridItemKeyPrefix}h_';
  static const String diameterKeyPrefix = '${gridItemKeyPrefix}diameter_';
  static const String diameterSigmaKeyPrefix =
      '${gridItemKeyPrefix}diameter_sigma_';
  static const String fullnameKeyPrefix = '${gridItemKeyPrefix}fullname_';
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
      child: getDirectionality(
        child: Scaffold(
          backgroundColor: AppTheme.pageBackgroundColor,
          body: _getBody(context: context),
        ),
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
              title: const Text(CadResultRoute.displayName),
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
        padding: const EdgeInsets.all(Dimensions.pagePadding),
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
        padding: const EdgeInsets.all(Dimensions.pagePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${l10n.total} = '
              '${sbdbCadBody.total.toString().localizeDigits(toZeroDigit: zeroDigit)}',
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
          bottom: Dimensions.pagePaddingVertical,
        ),
      ),
      _getGrid(context: context, sbdbCadBody: sbdbCadBody),
      const SliverPadding(
        padding: EdgeInsets.only(
          bottom: Dimensions.pagePaddingVertical,
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
      itemExtent: Dimensions.cadQueryItemExtent,
      pagePaddingHorizontal: Dimensions.pagePaddingHorizontal,
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

  Widget getItemWidget({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
    required SbdbCadData data,
    required int index,
  }) {
    return getItemContainer(
      context: context,
      index: index,
      child: getItemBody(
        context: context,
        sbdbCadBody: sbdbCadBody,
        data: data,
        index: index,
      ),
    );
  }

  Widget getItemContainer({
    required BuildContext context,
    required Widget child,
    required int index,
  }) {
    return Container(
      key: Key('$gridItemContainerKeyPrefix$index'),
      width: Dimensions.cadQueryItemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppTheme.queryContainerBorderColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(
          Dimensions.cadQueryItemRadius,
        )),
        color: AppTheme.queryContainerColor,
      ),
      padding: const EdgeInsets.all(Dimensions.cadQueryItemPadding),
      margin: const EdgeInsets.all(Dimensions.cadQueryItemMargin),
      child: child,
    );
  }

  Widget getItemBody({
    required BuildContext context,
    required SbdbCadBody sbdbCadBody,
    required SbdbCadData data,
    required int index,
  }) {
    final fields = List<String>.from(sbdbCadBody.rawBody!['fields']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getItemDetail(
          label: '${l10n.designation}:',
          displayValue: data.des,
          keyPrefix: desKeyPrefix,
          index: index,
        ),
        if (fields.contains('fullname'))
          getItemDetail(
            label: '${l10n.fullname}:',
            displayValue: data.fullname.toString().trim(),
            keyPrefix: fullnameKeyPrefix,
            index: index,
          ),
        getItemDetail(
          label: '${l10n.orbitId}:',
          displayValue: data.orbitId,
          keyPrefix: orbitIdKeyPrefix,
          index: index,
        ),
        getItemDetail(
          label: '${l10n.julianDate}:',
          displayValue: '${data.jd} ${Labels.tdb}',
          keyPrefix: jdKeyPrefix,
          index: index,
        ),
        BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) {
            return previous.dateFormatPattern != current.dateFormatPattern ||
                previous.timeFormatPattern != current.timeFormatPattern;
          },
          builder: (context, settingsState) {
            return getItemDetail(
              label: '${l10n.dateSlashTime}:',
              displayValue: formatCloseApproachDateTime(
                context: context,
                cd: data.cd,
                dateFormatPattern: settingsState.dateFormatPattern,
                timeFormatPattern: settingsState.timeFormatPattern,
              ),
              keyPrefix: cdKeyPrefix,
              index: index,
            );
          },
        ),
        getItemDetail(
          label: '${l10n.timeSigma}:',
          displayValue: data.tSigmaF,
          keyPrefix: tSigmaFKeyPrefix,
          index: index,
        ),
        if (fields.contains('body'))
          getItemDetail(
            label: '${l10n.closeApproachBody}:',
            displayValue: data.body != null
                ? getLocalizedBody(body: data.body!, l10n: l10n)
                : Labels.na,
            keyPrefix: bodyKeyPrefix,
            index: index,
          ),
        BlocSelector<SettingsBloc, SettingsState, DistanceUnit>(
          selector: (state) {
            return state.distanceUnit;
          },
          builder: (context, distanceUnit) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getItemDetail(
                  label: '${l10n.distance}:',
                  displayValue: data.dist
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                  keyPrefix: distKeyPrefix,
                  index: index,
                ),
                getItemDetail(
                  label: '${l10n.distanceMin}:',
                  displayValue: data.distMin
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                  keyPrefix: distMinKeyPrefix,
                  index: index,
                ),
                getItemDetail(
                  label: '${l10n.distanceMax}:',
                  displayValue: data.distMax
                      .convert(to: distanceUnit)
                      .toLocalizedString(l10n),
                  keyPrefix: distMaxKeyPrefix,
                  index: index,
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
                getItemDetail(
                  label: '${l10n.velocityRel}:',
                  displayValue: data.vRel
                      .convert(to: velocityUnit)
                      .toLocalizedString(l10n),
                  keyPrefix: vRelKeyPrefix,
                  index: index,
                ),
                getItemDetail(
                  label: '${l10n.velocityInf}:',
                  displayValue: data.vInf != null
                      ? data.vInf!
                          .convert(to: velocityUnit)
                          .toLocalizedString(l10n)
                      : Labels.na,
                  keyPrefix: vInfKeyPrefix,
                  index: index,
                ),
              ],
            );
          },
        ),
        getItemDetail(
          label: '${l10n.absoulteMagnitude}:',
          displayValue: data.h != null ? '${data.h} H' : Labels.na,
          keyPrefix: hKeyPrefix,
          index: index,
        ),
        if (fields.contains('diameter'))
          BlocSelector<SettingsBloc, SettingsState, DistanceUnit>(
            selector: (state) {
              return state.diameterUnit;
            },
            builder: (context, diameterUnit) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  getItemDetail(
                    label: '${l10n.diameter}:',
                    displayValue: data.diameter != null
                        ? data.diameter!
                            .convert(to: diameterUnit)
                            .toLocalizedString(l10n)
                        : Labels.na,
                    keyPrefix: diameterKeyPrefix,
                    index: index,
                  ),
                  getItemDetail(
                    label: '${l10n.diameterSigma}:',
                    displayValue: data.diameterSigma != null
                        ? data.diameterSigma!
                            .convert(to: diameterUnit)
                            .toLocalizedString(l10n)
                        : Labels.na,
                    keyPrefix: diameterSigmaKeyPrefix,
                    index: index,
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  Widget getItemDetail({
    required String label,
    required String displayValue,
    String keyPrefix = '',
    required int index,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Key? labelTextKey =
            keyPrefix.isNotEmpty ? Key('${keyPrefix}label_$index') : null;
        final Key? displayValueTextKey = keyPrefix.isNotEmpty
            ? Key('${keyPrefix}display_value_$index')
            : null;
        final style = Theme.of(context).textTheme.bodyMedium;
        final labelWidth = getTextPainterLaidout(
          context: context,
          text: label,
          style: style,
        ).width;
        displayValue = displayValue.localizeDigits(toZeroDigit: zeroDigit);
        final displayValueWidth = getTextPainterLaidout(
          context: context,
          text: displayValue,
          style: style,
        ).width;
        final constrainWidth = constraints.constrainWidth();
        // _logger.debug('constraints = $constraints');
        // _logger.debug('constrainWidth() = $constrainWidth');
        // _logger.debug('labelWidth = $labelWidth');
        // _logger.debug('displayValueWidth = $displayValueWidth');
        if (constrainWidth >=
            labelWidth + displayValueWidth + Dimensions.cadResultItemSpacing) {
          // _logger.debug('Will fit');
          return Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: Dimensions.cadResultItemSpacing,
            children: [
              Text(
                label,
                key: labelTextKey,
                style: style,
              ),
              Text(
                displayValue,
                key: displayValueTextKey,
                style: style,
              ),
            ],
          );
        } else {
          // _logger.debug('Will not fit');
          return Column(
            children: [
              SizedBox(
                width: constrainWidth,
                child: Text(
                  label,
                  key: labelTextKey,
                  style: style,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: constrainWidth,
                child: Text(
                  displayValue,
                  key: displayValueTextKey,
                  style: style,
                  textAlign: TextAlign.end,
                ),
              )
            ],
          );
        }
      },
    );
  }

  String formatCloseApproachDateTime({
    required BuildContext context,
    required DateTime cd,
    required DateFormatPattern dateFormatPattern,
    required TimeFormatPattern timeFormatPattern,
  }) {
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat(dateFormatPattern.pattern, locale);
    final dateTimeStringBuffer = StringBuffer(dateFormat.format(cd));
    dateTimeStringBuffer.write(' ');
    final timeFormat = DateFormat(timeFormatPattern.pattern, locale);
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
