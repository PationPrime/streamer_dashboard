part of 'subs_glass_widget_controller.dart';

class SubsGlassWidgetState extends Equatable {
  final List<SubsGlassBallModel> subsGlassModels;

  const SubsGlassWidgetState({
    this.subsGlassModels = const [],
  });

  @override
  List<Object> get props => [
        subsGlassModels,
      ];

  SubsGlassWidgetState copyWith({
    List<SubsGlassBallModel>? subsGlassModels,
  }) =>
      SubsGlassWidgetState(
        subsGlassModels: subsGlassModels ?? this.subsGlassModels,
      );
}

final class SubsGlassWidgetInitialState extends SubsGlassWidgetState {
  const SubsGlassWidgetInitialState();
}
