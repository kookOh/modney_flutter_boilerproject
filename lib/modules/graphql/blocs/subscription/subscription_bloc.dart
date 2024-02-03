import 'dart:async';

import 'package:modney_flutter_boilerplate/features/app/models/alert_model.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/modules/graphql/graphql_exception_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'subscription_bloc.freezed.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

abstract class SubscriptionBloc<T>
    extends Bloc<SubscriptionEvent<T>, SubscriptionState<T>> {
  SubscriptionBloc({required this.options})
      : super(SubscriptionState<T>.initial()) {
    on<SubscriptionEvent<T>>(_onEvent);
  }

  final WatchQueryOptions<Object?> options;
  StreamSubscription<QueryResult>? streamSubscription;
  late Stream<QueryResult> subscription;

  void run(SubscriptionOptions options) {
    add(SubscriptionEvent<T>.run(options: options));
  }

  bool shouldFetchMore(int i, int threshold) => false;

  bool get isLoading => state is _SubscriptionStateLoading;

  bool get isLoaded => state is _SubscriptionStateLoaded;

  T parseData(Map<String, dynamic>? data);

  bool get hasData => state is _SubscriptionStateLoaded<T>;

  bool get hasError => state is _SubscriptionStateError<T>;

  AlertModel get getError =>
      graphQLExceptionHandler((state as _SubscriptionStateError<T>).error);

  void dispose() {
    streamSubscription?.cancel();
  }

  void _listener(QueryResult result) {
    if (result.isLoading && result.data == null) {
      add(SubscriptionEvent.loading(result: result));
    }

    if (!result.isLoading && result.data != null) {
      add(
        SubscriptionEvent<T>.loaded(
          data: parseData(result.data),
          result: result,
        ),
      );
    }

    if (result.hasException) {
      T? data;

      if (result.data != null) {
        data = parseData(result.data);
      }

      add(
        SubscriptionEvent<T>.error(
          error: result.exception!,
          result: result,
          data: data,
        ),
      );
    }
  }

  Future<void> _onEvent(
    SubscriptionEvent<T> event,
    Emitter<SubscriptionState<T>> emit,
  ) async {
    await event.map(
      error: (e) async =>
          emit(SubscriptionState<T>.error(error: e.error, result: e.result)),
      run: (e) async {
        await streamSubscription?.cancel();

        subscription = getIt<GraphQLClient>().subscribe(e.options);
        streamSubscription = subscription.listen(_listener);
      },
      loading: (e) async => emit(SubscriptionState.loading(result: e.result)),
      loaded: (e) async =>
          emit(SubscriptionState<T>.loaded(data: e.data, result: e.result)),
    );
  }
}
