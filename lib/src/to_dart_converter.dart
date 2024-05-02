import "package:appmetrica_plugin/appmetrica_plugin.dart";
import "package:appmetrica_plugin/src/appmetrica_api_pigeon.dart";

extension StartupParamsItemStatusConverter on StartupParamsItemStatusPigeon {
  StartupParamsItemStatus toDart() {
    switch (this) {
      case StartupParamsItemStatusPigeon.FEATURE_DISABLED:
        return StartupParamsItemStatus.FEATURE_DISABLED;
      case StartupParamsItemStatusPigeon.INVALID_VALUE_FROM_PROVIDER:
        return StartupParamsItemStatus.INVALID_VALUE_FROM_PROVIDER;
      case StartupParamsItemStatusPigeon.NETWORK_ERROR:
        return StartupParamsItemStatus.NETWORK_ERROR;
      case StartupParamsItemStatusPigeon.OK:
        return StartupParamsItemStatus.OK;
      case StartupParamsItemStatusPigeon.PROVIDER_UNAVAILABLE:
        return StartupParamsItemStatus.PROVIDER_UNAVAILABLE;
      case StartupParamsItemStatusPigeon.UNKNOWN_ERROR:
        return StartupParamsItemStatus.UNKNOWN_ERROR;
      default:
        return StartupParamsItemStatus.UNKNOWN_ERROR;
    }
  }
}

extension StartupParamsItemConverter on StartupParamsItemPigeon {
  StartupParamsItem toDart() => StartupParamsItem(
      id: id,
      status: status.toDart(),
      errorDetails: errorDetails,
    );
}

extension StartupParamsResultConverter on StartupParamsResultPigeon {
  StartupParamsResult toDart() => StartupParamsResult(
      deviceId: deviceId,
      deviceIdHash: deviceIdHash,
      parameters: parameters?.map((String? key, StartupParamsItemPigeon? value) => MapEntry(
          key,
          value?.toDart(),
      ),),
      uuid: uuid,
    );
}

extension StartupParamsReasonConverter on StartupParamsReasonPigeon {
  StartupParamsReason  toDart() {
    switch (value) {
      case "INVALID_RESPONSE":
        return StartupParamsReason.INVALID_RESPONSE;
    case "NETWORK":
    return StartupParamsReason.NETWORK;
    case "UNKNOWN":
    return StartupParamsReason.UNKNOWN;
      default:
        return StartupParamsReason.UNKNOWN;
    }
  }
}

extension StartupParamsConverter on StartupParamsPigeon {
  StartupParams toDart() => StartupParams(
      result: result?.toDart(),
      reason: reason?.toDart(),
    );
}
