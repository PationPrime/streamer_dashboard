import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/models/donations_models/donation_alerts_model/donation_alerts_model.dart';
import 'package:streamer_dashboard/src/app/storage/storage.dart';
import 'package:streamer_dashboard/src/app/tools/tools.dart';

import '../../../../app/failure/failure.dart';

part 'donations_state.dart';

class DonationsController extends Cubit<DonationsState> {
  late final _appLogger = AppLogger(where: '$this');
  final LocalStorageInterface _localStorage;

  DonationsController(
    this._localStorage,
  ) : super(
          const DonationsInitialState(),
        ) {
    _init();
  }

  Future<void> loadDonationAlertsModel() async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    try {
      final link = await _localStorage.getDonationAlertsWidgetWevbViewUrl();

      if (link is! String) {
        throw Exception(
          'Failed to load donation alerts WebView widget link. Link is null',
        );
      }

      emit(
        state.copyWith(
          donationAlertsModel: DonationAlertsModel(
            widgetWebViewUrl: link,
          ),
        ),
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to load donation alerts WebView widget link: $error',
        stackTrace: stackTrace,
        lexicalScope: 'loadDonationAlertsModel method',
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  Future<void> addDonationAlerts(String widgetWebViewUrl) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    ///
    try {
      await _localStorage.saveDonationAlertsWidgetWevbViewUrl(
        widgetWebViewUrl,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to add donation alerts WebView widget url: $error',
        stackTrace: stackTrace,
        lexicalScope: 'addDonationAlerts method',
      );
    } finally {
      /// Doesn't matter if link can't be save in storage,
      /// save it in state and show it to user
      emit(
        state.copyWith(
          donationAlertsModel: DonationAlertsModel(
            widgetWebViewUrl: widgetWebViewUrl,
          ),
          loading: false,
        ),
      );
    }
  }

  Future<void> removeDonationAlertsLink() async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    /// Doesn't matter if link can't be removed from storage,
    /// remove it from state
    emit(
      state.clearDonationAlerts(),
    );

    ///
    try {
      await _localStorage.removeDonationAlertsWidgetWevbViewUrl();
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to remove donation alerts WebView widget url: $error',
        stackTrace: stackTrace,
        lexicalScope: 'removeDonationAlertsLink method',
      );
    } finally {
      emit(
        state.copyWith(
          loading: false,
        ),
      );
    }
  }

  FutureOr<void> _init() async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    try {
      /// load all donation services links
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
          loading: false,
        ),
      );
    }
  }
}
