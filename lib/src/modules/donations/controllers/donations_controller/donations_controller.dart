import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/constants/constants.dart';
import 'package:streamer_dashboard/src/app/models/donations_models/donation_alerts_model/donation_alerts_model.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';
import 'package:streamer_dashboard/src/assets_gen/assets.gen.dart';

part 'donations_state.dart';

class DonationsController extends Cubit<DonationsState> {
  late final _appLogger = AppLogger(where: '$this');

  DonationsController()
      : super(
          const DonationsInitialState(),
        ) {
    _init();
  }

  Future<void> loadDonationAlertsModel() async {
    try {
      final data = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.donations,
        jsonRootKey: DonationKeysConstants.donationAlertsWidgetWebViewUrl,
      );

      final donationAlertsModel = DonationAlertsModel.fromJson(
        data,
      );

      emit(
        state.copyWith(
          donationAlertsModel: donationAlertsModel,
        ),
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error loading donation alerts model: $error',
        stackTrace: stackTrace,
      );
    }
  }

  FutureOr<void> _init() async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      await Future.wait(
        [
          loadDonationAlertsModel(),
        ],
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error initializing donations controller: $error',
        stackTrace: stackTrace,
      );
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
