/*
 * Version for Flutter
 * © 2023 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import <Foundation/Foundation.h>
#import "AMAFPigeon.h"

@interface AMAFAppMetricaConfigPigeon (Mapping)

+ (AMAFAppMetricaConfigPigeon *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;

@end

@interface AMAFLocationPigeon (Mapping)

+ (AMAFLocationPigeon *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;

@end

@interface AMAFPreloadInfoPigeon (Mapping)

+ (AMAFPreloadInfoPigeon *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;

@end

@interface AMAPigeonUtils : NSObject

+ (id)getNullableObject:(NSDictionary *)dict key:(id)key;

@end
