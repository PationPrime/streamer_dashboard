import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';
import 'dart:typed_data';

import 'package:streamer_dashboard/src/app/tools/tools.dart';
part 'subs_glass_widget_state.dart';

class SubsGlassWidgetController extends Cubit<SubsGlassWidgetState> {
  late final _appLogger = AppLogger(where: '$this');

  SubsGlassWidgetController()
      : super(
          const SubsGlassWidgetInitialState(),
        );

  Future<List<int>?> _convertImageToBytes(String url) async {
    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = Uint8List.fromList(
        response.data!,
      ).toList();

      return bytes;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to load image as bytes: $error',
        stackTrace: stackTrace,
      );

      return null;
    }
  }

  Future<List<SubsGlassBallModel>> mockSubsGlassBallModels() async => [
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://static.vecteezy.com/system/resources/thumbnails/022/963/918/small_2x/ai-generative-cute-cat-isolated-on-solid-background-photo.jpg',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://assets-au-01.kc-usercontent.com/ab37095e-a9cb-025f-8a0d-c6d89400e446/17d49270-1b2a-4511-80a8-1c5dbd41e8c8/article-cat-vet-visit-guide.jpg',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        // ),
        // SubsGlassBallModel(
        //   radius: 20,
        //   imageUrl:
        //       'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        // ),

        ///2
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://static.vecteezy.com/system/resources/thumbnails/022/963/918/small_2x/ai-generative-cute-cat-isolated-on-solid-background-photo.jpg',
        ),
        SubsGlassBallModel(
          radius: 20,
          imageUrl:
              'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        ),
        SubsGlassBallModel(
          radius: 20,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://assets-au-01.kc-usercontent.com/ab37095e-a9cb-025f-8a0d-c6d89400e446/17d49270-1b2a-4511-80a8-1c5dbd41e8c8/article-cat-vet-visit-guide.jpg',
        ),
        SubsGlassBallModel(
          radius: 20,
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBK_FphZxH1WT3nDqjxF9Iy35VJI-Uu47lMGlTGcL8_sviGjmJL42gQDbHRZ7brW5xSAo&usqp=CAU',
        ),
        SubsGlassBallModel(
          radius: 30,
          imageUrl:
              'https://www.alleycat.org/wp-content/uploads/2024/04/alley-our-bnr.jpg',
        ),
      ];

  Future<void> setBallModels() async {
    ///
    emit(
      SubsGlassWidgetState(
        subsGlassModels: await mockSubsGlassBallModels(),
      ),
    );
  }

  void clearBallModels() => emit(
        SubsGlassWidgetState(),
      );

  void addSubBallModel(
    SubsGlassBallModel ballModel,
  ) =>
      emit(
        state.copyWith(
          subsGlassModels: [
            ...state.subsGlassModels,
            ballModel,
          ],
        ),
      );
}
