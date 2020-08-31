//
//  Environment.h
//  Netmera
//
//  Created by Yavuz Nuzumlali on 28/04/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Keys/NetmeraKeys.h>

@interface Environment : NSObject

@property (nonatomic, strong, readonly) NetmeraKeys *keys;

- (NSString *)baseURL;
- (NSString *)APIKey;
- (NSString *)restAPIKey;

@end
