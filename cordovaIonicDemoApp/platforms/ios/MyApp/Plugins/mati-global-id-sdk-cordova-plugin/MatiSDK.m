/********* MatiGlobalIDSDK.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <MatiSDK/MatiSDK.h>

@interface MatiGlobalIDSDK : CDVPlugin <MatiButtonResultDelegate>{
    // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)showMatiFlow:(CDVInvokedUrlCommand*)command;
- (void)setMatiCallback:(CDVInvokedUrlCommand*)command;

#define isNull(value) value == nil || [value isKindOfClass:[NSNull class]]

@end

@implementation MatiGlobalIDSDK{
    CDVInvokedUrlCommand* setMatiCallbackCDVInvokedUrlCommand;
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


- (void)showMatiFlow:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* clientId = nil;
    NSString* flowId = nil;
    NSDictionary* metadata = nil;
    NSDictionary* options = [[NSDictionary alloc]init];
    
    if ([command.arguments count] > 0) {
        options = [command argumentAtIndex:0];
        if (isNull([options objectForKey:@"clientId"])) {
            clientId = nil;
            NSLog(@"Please set yours Mati client ID");
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
            [MatiSDK.shared showMatiFlowWithClientId: clientId flowId: flowId metadata: metadata];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        });
        
    } else {
        NSLog(@"Please set yours Mati client ID");
    }
}

- (void)setMatiCallback:(CDVInvokedUrlCommand*)command
{
    setMatiCallbackCDVInvokedUrlCommand = command;
    [MatiButtonResult shared].delegate = self;
}

- (void)verificationSuccessWithIdentityId:(NSString *)identityId {
    if(setMatiCallbackCDVInvokedUrlCommand != nil){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:identityId];
        [pluginResult setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:setMatiCallbackCDVInvokedUrlCommand.callbackId];
    }
}

- (void)verificationCancelled {
    if(setMatiCallbackCDVInvokedUrlCommand != nil){
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Verification cancelled"];
        [pluginResult setKeepCallbackAsBool:YES];
         [self.commandDelegate sendPluginResult:pluginResult callbackId:setMatiCallbackCDVInvokedUrlCommand.callbackId];
    }
}


@end
