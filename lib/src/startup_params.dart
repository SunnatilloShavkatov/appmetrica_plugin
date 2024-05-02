enum StartupParamsItemStatus {
  FEATURE_DISABLED,
  INVALID_VALUE_FROM_PROVIDER,
  NETWORK_ERROR,
  OK,
  PROVIDER_UNAVAILABLE,
  UNKNOWN_ERROR,
}

class StartupParamsItem {
  final String? id;
  final StartupParamsItemStatus status;
  final String? errorDetails;

  const StartupParamsItem({
    this.id,
      this.status = StartupParamsItemStatus.UNKNOWN_ERROR,
      this.errorDetails,
  });
}

class StartupParamsResult {
  final String? deviceId;
  final String? deviceIdHash;
  final Map<String?, StartupParamsItem?>? parameters;
  final String? uuid;

  const StartupParamsResult({
    this.deviceId,
    this.deviceIdHash,
    this.parameters,
    this.uuid,
  });
}

enum StartupParamsReason {
  INVALID_RESPONSE,
  NETWORK,
  UNKNOWN,
}

class StartupParams {
  final StartupParamsResult? result;
  final StartupParamsReason? reason;

  const StartupParams({
    this.result,
    this.reason,
});
}
