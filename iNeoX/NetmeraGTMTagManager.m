//
//  NetmeraGTMTagManager.m
//  iNeo
//
//  Created by inomera on 26.06.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "NetmeraGTMTagManager.h"
#import <Netmera/Netmera.h>

static NSString *const ActionTypeKey = @"action_type";
// Custom Events
static NSString *const LogEventActionType = @"netmera_event";
static NSString *const LogEventClassName = @"class_name";

@interface NetmeraGTMTagManager ()

@end

@implementation NetmeraGTMTagManager

#pragma mark - internal events

- (NSObject *)executeWithParameters:(NSDictionary *)parameters {
  NSMutableDictionary *mutableParameters = [parameters mutableCopy];
  
  NSString *actionType = mutableParameters[ActionTypeKey];
  if (!actionType) {
    NSLog(@"There is no Netmera action type key in this call. Doing nothing for parameters: %@", parameters);
    return nil;
  }
  
  [mutableParameters removeObjectForKey:ActionTypeKey];
  
  if ([actionType isEqualToString:LogEventActionType]) {
    [self logEvent:mutableParameters];
  } else {
    NSLog(@"Invalid action type. Doing nothing.");
  }
  
  return nil;
}
- (void)logEvent:(NSMutableDictionary *)parameters {
  NSString *className = parameters[LogEventClassName];

  if (className && NSClassFromString(className)) {
    [parameters removeObjectForKey:LogEventClassName];
    [parameters removeObjectForKey:ActionTypeKey];
      
    __block  Class klass = NSClassFromString(className);
    NetmeraEvent *event = [klass alloc];
    
    __kindof NetmeraEvent *(^eventForClassFromDict)(Class) = ^__kindof NetmeraEvent *(Class klass) {
      return [[klass alloc] initWithDictionary:parameters];
    };
    
    event = eventForClassFromDict([event class]);
    if (event) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [Netmera sendEvent:event];
        });
    }
  }
}

@end
