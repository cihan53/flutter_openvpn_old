#import "HubboxVpnPlugin.h"
#if __has_include(<HubboxVpn/HubboxVpn-Swift.h>)
#import <HubboxVpn/HubboxVpn-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "HubboxVpn-Swift.h"
#endif

@implementation HubboxVpnPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHubboxVpnPlugin registerWithRegistrar:registrar];
}
@end
