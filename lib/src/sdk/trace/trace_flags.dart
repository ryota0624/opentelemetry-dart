import '../../api/trace/trace_flags.dart' as api;

class TraceFlags implements api.TraceFlags {
  int _flags = api.TraceFlags.none;

  TraceFlags(this._flags);
  TraceFlags.fromString(String traceFlags) {
    traceFlags = traceFlags.padLeft(api.TraceFlags.size, '0');

    for (var i = 0; i < traceFlags.length; i += 2) {
      _flags = int.parse('${traceFlags[i]}${traceFlags[i + 1]}', radix: 16);
    }
  }
  factory TraceFlags.invalid() => TraceFlags(api.TraceFlags.invalid);

  @override
  String toString() {
    return _flags.toRadixString(16).padLeft(2, '0');
  }

  set sampled(bool sampled) {
    if (sampled) {
      _flags |= api.TraceFlags.sampledFlag;
    } else {
      _flags &= ~api.TraceFlags.sampledFlag;
    }
  }

  bool get sampled =>
      isValid &&
      ((_flags & api.TraceFlags.sampledFlag) == api.TraceFlags.sampledFlag);

  bool get isValid => _flags != api.TraceFlags.invalid;
}