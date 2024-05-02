/*
 * Version for Flutter
 * © 2022 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import "AMAFPigeon.h"

@interface AMAFReporterImplementation : NSObject <AMAFReporterPigeon>

- (void)clearAppEnvironmentApiKey:(NSString *)apiKey error:(FlutterError **)flutterError;
- (void)pauseSessionApiKey:(NSString *)apiKey error:(FlutterError **)flutterError;
- (void)putAppEnvironmentValueApiKey:(NSString *)apiKey key:(NSString *)key value:(NSString *)value error:(FlutterError **)flutterError;
- (void)reportAdRevenueApiKey:(NSString *)apiKey adRevenue:(AMAFAdRevenuePigeon *)adRevenue error:(FlutterError **)flutterError;
- (void)reportECommerceApiKey:(NSString *)apiKey event:(AMAFECommerceEventPigeon *)event error:(FlutterError **)flutterError;
- (void)reportErrorApiKey:(NSString *)apiKey error:(AMAFErrorDetailsPigeon *)error message:(NSString *)message error:(FlutterError **)flutterError;
- (void)reportErrorWithGroupApiKey:(NSString *)apiKey groupId:(NSString *)groupId error:(AMAFErrorDetailsPigeon *)error message:(NSString *)message error:(FlutterError **)flutterError;
- (void)reportEventApiKey:(NSString *)apiKey eventName:(NSString *)eventName error:(FlutterError **)flutterError;
- (void)reportEventWithJsonApiKey:(NSString *)apiKey eventName:(NSString *)eventName attributesJson:(NSString *)attributesJson error:(FlutterError **)flutterError;
- (void)reportRevenueApiKey:(NSString *)apiKey revenue:(AMAFRevenuePigeon *)revenue error:(FlutterError **)flutterError;
- (void)reportUnhandledExceptionApiKey:(NSString *)apiKey error:(AMAFErrorDetailsPigeon *)error error:(FlutterError **)flutterError;
- (void)reportUserProfileApiKey:(NSString *)apiKey userProfile:(AMAFUserProfilePigeon *)userProfile error:(FlutterError **)flutterError;
- (void)resumeSessionApiKey:(NSString *)apiKey error:(FlutterError **)flutterError;
- (void)sendEventsBufferApiKey:(NSString *)apiKey error:(FlutterError **)flutterError;
- (void)setDataSendingEnabledApiKey:(NSString *)apiKey enabled:(NSNumber *)enabled error:(FlutterError **)flutterError;
- (void)setUserProfileIDApiKey:(NSString *)apiKey userProfileID:(NSString *)userProfileID error:(FlutterError **)flutterError;

@end
