// Minimalista, sin dependencias externas (Dart 3+)
typedef Result<T> = ({T? ok, Exception? err});

Result<T> Ok<T>(T value) => (ok: value, err: null);
Result<T> Err<T>(Exception e) => (ok: null, err: e);

// Helpers opcionales
bool isOk<T>(Result<T> r) => r.err == null;
