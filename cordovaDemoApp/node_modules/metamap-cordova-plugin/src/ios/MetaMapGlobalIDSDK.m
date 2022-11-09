/********* MetaMapGlobalIDSDK.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <MetaMapSDK/MetaMapSDK.h>

@interface MetaMapGlobalIDSDK : CDVPlugin <MetaMapButtonResultDelegate>{
    // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)showMetaMapFlow:(CDVInvokedUrlCommand*)command;
- (void)setMetaMapCallback:(CDVInvokedUrlCommand*)command;

#define isNull(value) value == nil || [value isKindOfClass:[NSNull class]]

@end

@implementation MetaMapGlobalIDSDK{
    CDVInvokedUrlCommand* setMetaMapCallbackCDVInvokedUrlCommand;
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)showMetaMapFlow:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* clientId = nil;
    NSString* flowId = nil;
    NSDictionary* metadata = @{ @"sdkType" : @"cordova"};
    NSDictionary* options = [[NSDictionary alloc]init];
    
    if ([command.arguments count] > 0) {
        options = [command argumentAtIndex:0];
        if (isNull([options objectForKey:@"clientId"])) {
            clientId = nil;
            NSLog(@"Please set yours MetaMap client ID");
        } else {
            clientId = [options objectForKey:@"clientId"];
        }
        if (isNull([options objectForKey:@"flowId"])) {
            flowId = nil;
        } else {
            flowId = [options objectForKey:@"flowId"];
        }
        if (isNull([options objectForKey:@"metadata"])) {
            metadata = nil;
        } else {
            metadata = [options objectForKey:@"metadata"];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [MetaMap.shared showMetaMapFlowWithClientId: clientId flowId: flowId metadata: metadata];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        });
        
    } else {
        NSLog(@"Please set yours MetaMap client ID");
    }
}

- (void)setMetaMapCallback:(CDVInvokedUrlCommand*)command
{
    setMetaMapCallbackCDVInvokedUrlCommand = command;
    [MetaMapButtonResult shared].delegate = self;
}

- (void)verificationSuccessWithIdentityId:(NSString *)identityId verificationID:(nullable NSString *)verificationID {
    if(setMetaMapCallbackCDVInvokedUrlCommand != nil){
        NSDictionary *dict = @{@"identityId": identityId, @"verificationID": verificationID};
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:setMetaMapCallbackCDVInvokedUrlCommand.callbackId];
    }
}

- (void)verificationCancelled {
    if(setMetaMapCallbackCDVInvokedUrlCommand != nil){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Verification cancelled"];
        [pluginResult setKeepCallbackAsBool:YES];
         [self.commandDelegate sendPluginResult:pluginResult callbackId:setMetaMapCallbackCDVInvokedUrlCommand.callbackId];
    }
}


@end
