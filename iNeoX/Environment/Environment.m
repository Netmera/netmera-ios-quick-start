//
//  Environment.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 28/04/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import "Environment.h"

@interface Environment ()

@property (nonatomic, strong) NetmeraKeys *keys;

@end

@implementation Environment

- (instancetype)init
{
  self = [super init];
  if (self) {
    _keys = [[NetmeraKeys alloc] init];
  }
  return self;
}

- (NSString *)baseURL {
  return nil;
}

- (NSString *)APIKey {
  return nil;
}

- (NSString *)restAPIKey {
  return nil;
}

- (NSString *)fabricAPIKey {
  return nil;
}

@end
