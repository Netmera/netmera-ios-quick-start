//
//  TestWebVC.m
//  Netmera
//
//  Created by Yavuz Nuzumlali on 26/11/15.
//  Copyright © 2015 Netmera. All rights reserved.
//

#import "TestWebVC.h"
#import <Netmera/Netmera.h>
#import <WebKit/WebKit.h>

@interface TestWebVC () <WKNavigationDelegate>

//@property (nonatomic, weak) IBOutlet WKWebView *webView;

@end

@implementation TestWebVC

- (void)viewDidLoad {
  [super viewDidLoad];
//  self.webView.navigationDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
//  [Netmera loadWebViewContentInWebView:self.webView];
}

@end
