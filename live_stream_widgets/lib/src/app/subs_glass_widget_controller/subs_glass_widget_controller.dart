import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:live_stream_widgets/src/app/models/models.dart';

part 'subs_glass_widget_state.dart';

class SubsGlassWidgetController extends Cubit<SubsGlassWidgetState> {
  SubsGlassWidgetController() : super(SubsGlassWidgetInitialState());

  void setBallModels(
    List<SubsGlassBallModel> subsGlassModels,
  ) =>
      emit(
        SubsGlassWidgetState(
          subsGlassModels: subsGlassModels,
        ),
      );
}
