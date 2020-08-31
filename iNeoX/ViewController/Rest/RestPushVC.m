//
//  RestPushVC.m
//  Netmera
//
//  Created by Nazire Aslan on 21/03/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "RestPushVC.h"
#import "TestUtil.h"

#import <AFNetworking/AFHTTPSessionManager.h>
#import <Netmera/NetmeraUser.h>
#import "EnvironmentUtil.h"

extern NSString *const NetmeraAPIKeyHTTPHeaderKey;

@interface RestPushVC ()

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

@end

@implementation RestPushVC

- (instancetype)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    [self setup];
  }
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self setup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)setup {
  // Configure request/response serializers
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  configuration.HTTPMaximumConnectionsPerHost = 1;
  _requestManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:configuration];
  _requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
  AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
  serializer.removesKeysWithNullValues = YES;
  _requestManager.responseSerializer = serializer;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // register to push notifications
  [Netmera requestPushNotificationAuthorizationForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
  // set userid to send push to identified user
  
//  NetmeraUser *user = [[NetmeraUser alloc] init];
//  user.userId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//  [Netmera updateUser:user];

  self.dataSource = @[
                      NSStringFromSelector(@selector(sendShortPush)),
                      NSStringFromSelector(@selector(sendMediumPush)),
                      NSStringFromSelector(@selector(sendLongPush)),
                      NSStringFromSelector(@selector(sendInteractivePushWithYesNoButtonAndDeeplink)),
                      ];
}

- (void)sendShortPush {
  [self sendRequestWithNotificationKey:@"28"];
}

- (void)sendMediumPush {
  [self sendRequestWithNotificationKey:@"29"];
}

- (void)sendLongPush {
  [self sendRequestWithNotificationKey:@"31"];
}

- (void)sendInteractivePushWithYesNoButtonAndDeeplink {
  [self sendRequestWithNotificationKey:@"43"];
}

- (void)sendRequestWithNotificationKey:(NSString *)notificationKey {
  NSDictionary *params = @{
                           @"notificationKey" : notificationKey,
                           @"target" : @{
                               @"extId" : [[[UIDevice currentDevice] identifierForVendor] UUIDString]
                               }
                           };
  [self.requestManager.requestSerializer setValue:[self environment].restAPIKey
                               forHTTPHeaderField:NetmeraAPIKeyHTTPHeaderKey];

  [self.requestManager POST:
   [NSString stringWithFormat:@"%@/rest/3.0/sendNotification", [self environment].baseURL]
                 parameters:params
                    headers:nil
                   progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"responseObject: %@", responseObject);
  }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"error: %@", error);
    
  }];
}

#pragma mark - Accessors

- (Environment *)environment {
  return [EnvironmentUtil currentEnvironment];
}

@end
