//
//  ReleaseEnvironment.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 28/04/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "ReleaseEnvironment.h"

NSString * const kNetmeraTestBaseURL = @"baseURL";
NSString * const kNetmeraTestAPIKey = @"APIKey";
NSString * const kNetmeraTestRestAPIKey = @"RestAPIKey";

@interface ReleaseEnvironment ()

@property (nonatomic, weak, readonly) NSUserDefaults *userDefaults;

@end

@implementation ReleaseEnvironment

- (NSUserDefaults *)userDefaults {
  NSDictionary *dictionary = [self readDefaultSettingsFromPlist];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults registerDefaults:dictionary];
  [userDefaults synchronize];
  return userDefaults;
}

- (NSDictionary *)readDefaultSettingsFromPlist {
  NSString *settingsBundlePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
  NSBundle *settingsBundle = [NSBundle bundleWithPath:settingsBundlePath];
  NSString *rootPlistPath = [settingsBundle pathForResource:@"Root" ofType:@"plist"];

  id mutable = [NSMutableDictionary dictionary];
  id settings = [NSDictionary dictionaryWithContentsOfFile: rootPlistPath];
  id specifiers = [settings objectForKey: @"PreferenceSpecifiers"];
  for (id prefItem in specifiers) {
    id key = [prefItem objectForKey: @"Key"];
    id value = [prefItem objectForKey: @"DefaultValue"];
    if ( key && value ) {
      [mutable setObject: value forKey: key];
    }
  }
  return [NSDictionary dictionaryWithDictionary: mutable];
}

- (NSString *)baseURL {
  return [self.userDefaults stringForKey:kNetmeraTestBaseURL] ?: [super baseURL];
}

- (NSString *)APIKey {
  return [self.userDefaults stringForKey:kNetmeraTestAPIKey];
}

- (NSString *)restAPIKey {
  return [self.userDefaults stringForKey:kNetmeraTestRestAPIKey];
}

@end
