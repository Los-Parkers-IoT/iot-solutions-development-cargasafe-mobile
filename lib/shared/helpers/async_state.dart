class AsyncState<T> {
  final T data;
  final bool loading;
  final String? error;

  const AsyncState({required this.data, this.loading = false, this.error});

  AsyncState<T> copyWith({T? data, bool? loading, String? error}) {
    return AsyncState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  factory AsyncState.initial(T initial) =>
      AsyncState<T>(data: initial, loading: false, error: null);
}
