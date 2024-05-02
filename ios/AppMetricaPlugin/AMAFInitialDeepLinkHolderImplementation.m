/*
 * Version for Flutter
 * © 2022 YANDEX
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * https://yandex.com/legal/appmetrica_sdk_agreement/
 */

#import "AMAFInitialDeepLinkHolderImplementation.h"

@interface AMAFInitialDeepLinkHolderImplementation()
@property(nonatomic, copy) NSString *deeplink;
@end

@implementation AMAFInitialDeepLinkHolderImplementation

- (void)setInitialDeeplink:(NSString *)deeplink
{
    self.deeplink = [deeplink copy];
}

- (NSString *)getInitialDeeplinkWithError:(FlutterError **)flutterError
{
    return self.deeplink;
}

@end
