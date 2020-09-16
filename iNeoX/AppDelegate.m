//
//  AppDelegate.m
//  iNeoX
//
//  Created by inomera on 31.08.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONHelper.h"
#import "DeeplinkRouter.h"
#import "EnvironmentUtil.h"
#import "AlertPresenter.h"
#import <Netmera/Netmera.h>
#import <UserNotifications/UserNotifications.h>
#import "StoreObserver.h"
#import "IneoEncryptor.h"
@import Firebase;

@interface AppDelegate ()<NetmeraPushDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) DeeplinkRouter *deeplinkRouter;
@property (nonatomic, weak, readonly) Environment *environment;
@property (nonatomic, strong) AlertPresenter *alertPresenter;


@end

@implementation AppDelegate


- (Environment *)environment {
  return [EnvironmentUtil currentEnvironment];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
  [AlertPresenter setupDefaultPresenterWithApplication:application];
  [FIRApp configure];
  
  UNUserNotificationCenter.currentNotificationCenter.delegate = self;
  
  if (self.environment.APIKey) {
    [Netmera start];
    [Netmera setAPIKey:self.environment.APIKey];
    if (self.environment.baseURL) {
      [Netmera setBaseURL:self.environment.baseURL];
    }
    
    [Netmera setAppGroupName:@"group.com.netmera.ineo"];
    [Netmera setPushDelegate:self];
    [Netmera setLogLevel:NetmeraLogLevelDebug];
  } else {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self.alertPresenter presentAlertWithTitle:@"ERROR!!!"
                                         message:@"You must set your API key from settings menu to start Netmera"];
    });
  }
  
  
  
  IneoEncryptor *encyryptor = [[IneoEncryptor alloc] init];
  [Netmera setEncyptor:encyryptor];
  
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

 -(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
  //handle deeplinkURLs outside of the appdelegate
  return [self.deeplinkRouter handleURL:url];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
  NSLog(@"didReceiveRemoteNotification: %@", userInfo);
//  NetmeraPushObject *object = [[NetmeraPushObject alloc] initWithDictionary:userInfo];
//  [self handlePresentationForPushObject:object];
}

//Silent
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
  NSLog(@"didReceiveRemoteNotification fetchCompletionHandler: %@", userInfo);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
  NSLog(@"willPresentNotification: %@", notification.request.content.userInfo);

  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notification.request.content.userInfo
                                                     options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                       error:&error];
  
  if (! jsonData) {
    NSLog(@"Got an error: %@", error);
  } else {
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"json: %@", jsonString);
  }
  
  completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
  NSLog(@"didReceiveNotificationResponse: %@", response.notification.request.content.userInfo);
  completionHandler();
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification  API_AVAILABLE(ios(10.0)){
  
}

#pragma mark - Accessors

- (DeeplinkRouter *)deeplinkRouter {
  if (!_deeplinkRouter) {
    _deeplinkRouter = [[DeeplinkRouter alloc] initWithApplication:[UIApplication sharedApplication]
                                                   alertPresenter:self.alertPresenter];
  }
  return _deeplinkRouter;
}

- (AlertPresenter *)alertPresenter {
  if (!_alertPresenter) {
    _alertPresenter = [[AlertPresenter alloc] initWithApplication:[UIApplication sharedApplication]];
  }
  return _alertPresenter;
}

#pragma mark - netmera push delegate

- (BOOL)shouldHandlePresentationForPushObject:(NetmeraPushObject *)object {
  return [NSUserDefaults.standardUserDefaults boolForKey:@"handlePresantation"];
}

- (void)handlePresentationForPushObject:(NetmeraPushObject *)object {
  [self.alertPresenter presentAlertWithTitle:object.alert.title message:object.alert.body];
}

- (BOOL)shouldHandleWebViewPresentationForPushObject:(NetmeraPushObject *)object {
  return [NSUserDefaults.standardUserDefaults boolForKey:@"handleWebView"];
}

-(void)handleWebViewPresentationForPushObject:(NetmeraPushObject *)object {
  
}

- (BOOL)shouldHandleOpenURL:(NSURL *)url forPushObject:(NetmeraPushObject *)object {
    return [NSUserDefaults.standardUserDefaults boolForKey:@"handleDeeplink"];
}

- (void)handleOpenURL:(NSURL *)url forPushObject:(NetmeraPushObject *)object {
    NSLog(@"handleDeeplinkForURL: %@ PushObject %@", url, object);
  // TODO: Resolve url components
  [self.deeplinkRouter handleURL:url];
}

@end
