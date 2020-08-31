//
//  EnvironmentUtil.m
//  Netmera
//
//  Created by Nazire Aslan on 24/03/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "EnvironmentUtil.h"
#import "DebugEnvironment.h"
#import "ReleaseEnvironment.h"

@interface EnvironmentUtil ()

@end

@implementation EnvironmentUtil

+ (Environment *)currentEnvironment {
  static Environment *environment = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
#ifdef DEBUG
      environment = [[DebugEnvironment alloc] init];
#else
      environment = [[ReleaseEnvironment alloc] init];
#endif
  });
  return environment;
}

NSString * const kNetmeraUITestIndicatorArgumentKey = @"--ui-testing";
+ (BOOL)isUITestsRunning {
  return [[[NSProcessInfo processInfo] arguments] containsObject:kNetmeraUITestIndicatorArgumentKey];
}

NSString * const kNetmeraUnitTestIndicatorEnvironmentKey = @"XCTestConfigurationFilePath";
+ (BOOL)isUnitTestsRunning {
  return [[NSProcessInfo processInfo] environment][kNetmeraUnitTestIndicatorEnvironmentKey] ? YES : NO;
}

@end
