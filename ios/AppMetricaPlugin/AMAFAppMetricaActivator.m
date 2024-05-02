/*
 * Version for Flutter
 * © 2022 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import "AMAFAppMetricaActivator.h"
#import <AppMetricaCore/AppMetricaCore.h>

@interface AMAFAppMetricaActivator ()

@property(nonatomic, assign) BOOL isActivated;

@end

@implementation AMAFAppMetricaActivator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isActivated = NO;
    }

    return self;
}


- (void)activateWithConfig:(AMAAppMetricaConfiguration *)config
{
    @synchronized (self) {
        [AMAAppMetrica activateWithConfiguration:config];
        self.isActivated = YES;
    }
}

- (BOOL)isAlreadyActivated
{
    @synchronized (self) {
        return self.isActivated;
    }
}


+ (instancetype)sharedInstance
{
    static AMAFAppMetricaActivator *activator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activator = [[AMAFAppMetricaActivator alloc] init];
    });
    return activator;
}

@end
