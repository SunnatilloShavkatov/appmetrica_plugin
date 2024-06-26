/*
 * Version for Flutter
 * © 2022 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import <Foundation/Foundation.h>

@class AMAFAppMetricaConfigPigeon;
@class AMAAppMetricaConfiguration;

@interface AMAFAppMetricaActivator : NSObject

// do not rename, used in push flutter plugin
- (void)activateWithConfig:(AMAAppMetricaConfiguration *)config;
// do not rename, used in push flutter plugin
- (BOOL)isAlreadyActivated;

+ (instancetype)sharedInstance;

@end
