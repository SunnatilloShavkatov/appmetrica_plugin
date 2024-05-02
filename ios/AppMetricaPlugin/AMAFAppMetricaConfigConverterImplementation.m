/*
 * Version for Flutter
 * © 2022 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import "AMAFAppMetricaConfigConverterImplementation.h"
#import "AMAFConverter.h"
#import "AMAFPigeon+Mapping.h"

@implementation AMAFAppMetricaConfigConverterImplementation

- (NSString *)toJsonConfig:(AMAFAppMetricaConfigPigeon *)config error:(FlutterError **)flutterError
{
    return [AMAFAppMetricaConfigConverterImplementation appMetricaConfigToJson:config];
}

+ (NSString *)appMetricaConfigToJson:(AMAFAppMetricaConfigPigeon *)pigeon
{
    NSDictionary *configMap = [pigeon toMap];
    NSError *jsonError = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:configMap options:0 error:&jsonError];
    if (jsonError == nil && json != nil) {
        return [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

+ (AMAAppMetricaConfiguration *)appMetricaConfigFromJson:(NSString *)json
{
    if (json != nil) {
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:0
                                                               error:&error];
        if (error == nil && dict != nil && [dict isKindOfClass:[NSDictionary class]]) {
            AMAFAppMetricaConfigPigeon *pigeon = [AMAFAppMetricaConfigPigeon fromMap:dict];
            return [AMAFConverter convertAppMetricaConfiguration:pigeon];
        }
    }
    return nil;
}

@end
