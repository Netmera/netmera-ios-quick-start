//
//  PushVC.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 30/12/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import "PushVC.h"
#import "TestUtil.h"
#import "AlertPresenter.h"
#import <UserNotifications/UserNotifications.h>

@interface PushVC ()

@end

@implementation PushVC

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.dataSource = @[
                      NSStringFromSelector(@selector(registerPush)),
                      NSStringFromSelector(@selector(registerPushProvisional)),
                      NSStringFromSelector(@selector(registerPushProvisionalAndAlert)),
                      NSStringFromSelector(@selector(registerCarPlay)),
                      NSStringFromSelector(@selector(enableDeeplinkHandling)),
                      NSStringFromSelector(@selector(disableDeeplinkHandling)),
                      NSStringFromSelector(@selector(enableWebViewHandling)),
                      NSStringFromSelector(@selector(disableWebViewHandling)),
                      NSStringFromSelector(@selector(enablePresentationHandling)),
                      NSStringFromSelector(@selector(disablePresentationHandling)),
                      NSStringFromSelector(@selector(enableReceivingPush)),
                      NSStringFromSelector(@selector(disableReceivingPush)),
                      NSStringFromSelector(@selector(isPushReceivingEnabled)),
                      NSStringFromSelector(@selector(showShortPush)),
                      NSStringFromSelector(@selector(showMiddlePush)),
                      NSStringFromSelector(@selector(showLongPush)),
                      NSStringFromSelector(@selector(showInteractivePush)),
                      NSStringFromSelector(@selector(showTwoButtonInteractivePush)),
                      NSStringFromSelector(@selector(showSafariDeepLinkPush)),
                      NSStringFromSelector(@selector(showOtherAppDeepLinkPush)),
                      NSStringFromSelector(@selector(showWebViewTemplatePush)),
                      NSStringFromSelector(@selector(showWebViewURLPush)),
                      NSStringFromSelector(@selector(showPopupPush)),
                      NSStringFromSelector(@selector(enablePopupPresentation)),
                      NSStringFromSelector(@selector(disablePopupPresentation)),
  ];
}

#pragma mark - selectors

- (void)registerPush {
  [Netmera requestPushNotificationAuthorizationForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
}

- (void)registerPushProvisional {
  [Netmera requestPushNotificationAuthorizationForTypes: UNAuthorizationOptionProvisional];
}

- (void)registerPushProvisionalAndAlert {
  [Netmera requestPushNotificationAuthorizationForTypes:UIUserNotificationTypeAlert || UIUserNotificationTypeBadge || UIUserNotificationTypeSound || UNAuthorizationOptionProvisional];
}

- (void)registerCarPlay {
  [Netmera requestPushNotificationAuthorizationForTypes: UNAuthorizationOptionCarPlay];
}

- (void)enableReceivingPush {
  [Netmera setEnabledReceivingPushNotifications:YES];
  if (![Netmera isEnabledReceivingPushNotifications]) {
    [[AlertPresenter defaultPresenter] presentAlertWithTitle:@"Warning"
                                                     message:@"Push is disabled in settings page. Enable it yourself."
                                                     handler:^(NSInteger index) {
                                                       [[UIApplication sharedApplication]
                                                        openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                     }];
  }
}

- (void)disableReceivingPush {
  [Netmera setEnabledReceivingPushNotifications:NO];

}

- (void)isPushReceivingEnabled {
  BOOL enabled = [Netmera isEnabledReceivingPushNotifications];
  [[AlertPresenter defaultPresenter] presentAlertWithTitle:@"Push Receiving Enabled"
                                                   message:[NSString stringWithFormat:@"%d", enabled]];
}

- (void)showShortPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @0,
        }
      },
      @"aps" : @{ @"alert" : [TestUtil loremTextWithLength:100] }
    }];
}

- (void)showMiddlePush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @0,
        }
      },

      @"aps" : @{
        @"alert" : [TestUtil loremTextWithLength:250]
      }
    }];
}

- (void)showLongPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @0,
        }
      },
      @"aps" : @{
        @"alert" : [TestUtil loremTextWithLength:500]
      }
    }];
}

- (void)showInteractivePush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:[JSONHelper dictionaryFromFile:@"type_interactive"]];
}

- (void)showTwoButtonInteractivePush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:[JSONHelper dictionaryFromFile:@"type_interactive_two_button"]];
}

- (void)showSafariDeepLinkPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @1,
          @"uri" : @"https://www.google.com",
        },
        @"prms" : @{ @"key1" : @"value1", @"key2" : @"value2" }
      },
      @"aps" : @{ @"alert" : [TestUtil loremTextWithLength:100] }
    }];
}

- (void)showOtherAppDeepLinkPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @1,
          @"uri" : @"spotify:track:0fF0HtZGSXZgGrC6b7Pq4I",
        },
        @"prms" : @{ @"key1" : @"value1", @"key2" : @"value2" }
      },
      @"aps" : @{ @"alert" : [TestUtil loremTextWithLength:100] }
    }];
}

- (void)showWebViewTemplatePush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{
        @"pt" : @1,
        @"act" : @{
          @"at" : @2,
          @"tid" : @"TEMP_ID",
          @"tprms" : @{
            @"IMG_1" : @"https://vignette3.wikia.nocookie.net/pediaofinterest/images/4/4e/"
                       @"3x10_-_Root_guns.png/revision/latest?cb=20131127141952",
            @"IMG_1_TAG" : @"TagImageClickers",
            @"BTN_1" : @"Open Facebook",
            @"BTN_1_URL" : @"https://www.facebook.com",
            @"BTN_1_TAG" : @"FacebookBtnClickers",
            @"BTN_2" : @"Open Gmail",
            @"BTN_2_URL" : @"https://www.gmail.com",
            @"BTN_2_TAG" : @"GmailClickers",
            @"BTN_3" : @"Spotify Deeplink",
            @"BTN_3_URL" : @"_nm_deeplink:spotify:track:0fF0HtZGSXZgGrC6b7Pq4I",
            @"BTN_3_TAG" : @"FoodDeeplinkClickers",
            @"TXT_1" : @"Lorem ipsum dolor sit amet amk aq sq wq eq rq"
          },
        }
      },
      @"aps" : @{
        @"alert" : [TestUtil loremTextWithLength:250]
      }
    }];
}

- (void)showWebViewURLPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{ @"pt" : @1, @"act" : @{ @"at" : @2, @"url" : @"https://www.google.com" } },
      @"aps" : @{
          @"alert" : [TestUtil loremTextWithLength:250]
      }
    }];
}

- (void)showPopupPush {
  [[UIApplication sharedApplication]
      .delegate application:[UIApplication sharedApplication]
    didReceiveRemoteNotification:@{
      @"_nm" : @{ @"pt" : @3, @"act" : @{ @"at" : @2, @"url" : @"https://www.google.com" } },
      @"aps" : @{ @"content-available" : @1 }
    }];
}

- (void)enablePopupPresentation {
  [Netmera setEnabledPopupPresentation:YES];
}

- (void)disablePopupPresentation {
  [Netmera setEnabledPopupPresentation:NO];
}

- (void)enableDeeplinkHandling {
  [NSUserDefaults.standardUserDefaults setBool:true forKey:@"handleDeeplink"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)disableDeeplinkHandling {
  [NSUserDefaults.standardUserDefaults setBool:false forKey:@"handleDeeplink"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)enableWebViewHandling {
  [NSUserDefaults.standardUserDefaults setBool:true forKey:@"handleWebView"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)disableWebViewHandling {
  [NSUserDefaults.standardUserDefaults setBool:false forKey:@"handleWebView"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)enablePresentationHandling {
  [NSUserDefaults.standardUserDefaults setBool:true forKey:@"handlePresentation"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)disablePresentationHandling {
  [NSUserDefaults.standardUserDefaults setBool:false forKey:@"handlePresentation"];
  [NSUserDefaults.standardUserDefaults synchronize];
}

@end
