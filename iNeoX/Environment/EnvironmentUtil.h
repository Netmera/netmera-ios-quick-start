//
//  EnvironmentUtil.h
//  Netmera
//
//  Created by Nazire Aslan on 24/03/16.
//  Copyright © 2016 Netmera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Keys/NetmeraKeys.h>
#import "Environment.h"

@interface EnvironmentUtil : NSObject

+ (Environment *)currentEnvironment;

@end
