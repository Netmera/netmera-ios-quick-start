//
//  CrashesObjViewController.m
//  iNeo
//
//  Created by inomera on 3.04.2020.
//  Copyright © 2020 Netmera. All rights reserved.
//

#import "CrashesObjViewController.h"
#import "CRLCrash.h"
#import <objc/runtime.h>

@interface CrashesObjViewController ()

@property(nonatomic,strong) NSDictionary *knownCrashes;

@end

@implementation CrashesObjViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = NSStringFromClass([self class]);
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DefaultCellIdentifier];

  [self pokeAllCrashes];
  
  NSMutableArray *crashes = [NSMutableArray arrayWithArray:[CRLCrash allCrashes]];
  [crashes sortUsingComparator:^NSComparisonResult(CRLCrash *obj1, CRLCrash *obj2) {
    if ([obj1.category isEqualToString:obj2.category]) {
      return [obj1.title compare:obj2.title];
    } else {
      return [obj1.category compare:obj2.category];
    }
  }];
  
  NSMutableDictionary *categories = @{}.mutableCopy;
  
  for (CRLCrash *crash in crashes)
    categories[crash.category] = [(categories[crash.category] ?: @[]) arrayByAddingObject:crash];
  
  self.knownCrashes = categories.copy;
  
//  self.dataSource = @[
//                      NSStringFromSelector(@selector(sigabrt)),
//                      NSStringFromSelector(@selector(sigbus)),
//                      NSStringFromSelector(@selector(sigfpe)),
//                      NSStringFromSelector(@selector(sigill)),
//                      NSStringFromSelector(@selector(sigpipe)),
//                      NSStringFromSelector(@selector(sigsegv)),
//                      NSStringFromSelector(@selector(throwNSException)),
//                      NSStringFromSelector(@selector(crashTest1)),
//                      NSStringFromSelector(@selector(crashTest2)),
//                      NSStringFromSelector(@selector(crashTest3)),
//                      NSStringFromSelector(@selector(crashTest5)),
//                      NSStringFromSelector(@selector(crashTest6)),
//  ];
}

- (void)pokeAllCrashes
{
  if (CRLCrash.allCrashes.count > 0) {
    return;
  }
  unsigned int nclasses = 0;
  Class *classes = objc_copyClassList(&nclasses);
  
  for (unsigned int i = 0; i < nclasses; ++i) {
    if (classes[i] &&
        class_getSuperclass(classes[i]) == [CRLCrash class] &&
        class_respondsToSelector(classes[i], @selector(methodSignatureForSelector:)) &&
        classes[i] != [CRLCrash class])
    {
      [CRLCrash registerCrash:[[classes[i] alloc] init]];
    }
  }
  free(classes);
}

- (NSArray *)sortedAllKeys {
  NSMutableArray *result = [NSMutableArray arrayWithArray:self.knownCrashes.allKeys];
  
  [result sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
    return [obj1 compare:obj2];
  }];
  
  return [result copy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return (NSInteger)self.knownCrashes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return self.sortedAllKeys[(NSUInteger)section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (NSInteger)((NSArray *)self.knownCrashes[self.sortedAllKeys[(NSUInteger)section]]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DefaultCellIdentifier forIndexPath:indexPath];
  CRLCrash *crash = (CRLCrash *)(((NSArray *)self.knownCrashes[self.sortedAllKeys[(NSUInteger)indexPath.section]])[(NSUInteger)indexPath.row]);
  
  cell.textLabel.text = crash.title;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  CRLCrash *crash = (CRLCrash *)(((NSArray *)self.knownCrashes[self.sortedAllKeys[(NSUInteger)indexPath.section]])[(NSUInteger)indexPath.row]);
  [crash crash];
}
//- (void)crashTest1 {
//  @[][666];
//}
//
//- (void)crashTest2 {
//  [self performSelector:@selector(die_die)];
//}
//
//- (void)crashTest3 {
//  int* p = 0;
//  *p = 0;
//}
//
//- (void)crashTest5 {
//  assert("Maths failure!");
//}
//
//- (void)sigabrt
//{
//  abort();
//}
//
//- (void)sigbus
//{
//  void (*func)() = 0;
//  func();
//}
//
//- (void)sigfpe
//{
//  int zero = 0;  // LLVM is smart and actually catches divide by zero if it is constant
//  int i = 10/zero;
//  NSLog(@"Int: %i", i);
//}
//
//- (void)sigill
//{
//  typedef void(*FUNC)(void);
//  const static unsigned char insn[4] = { 0xff, 0xff, 0xff, 0xff };
//  void (*func)() = (FUNC)insn;
//  func();
//}
//
//- (void)sigpipe
//{
//  // Hmm, can't actually generate a SIGPIPE.
//  FILE *f = popen("ls", "r");
//  const char *buf[128];
//  pwrite(fileno(f), buf, 128, 0);
//}
//
//- (void)sigsegv
//{
//  // This actually raises a SIGBUS.
//  NSString *str = [[NSString alloc] initWithUTF8String:"SIGSEGV STRING"];
////  [str release];
//  NSLog(@"String %@", str);
//}
//
//- (void)throwNSException
//{
//  NSException *e = [NSException exceptionWithName:@"TestException" reason:@"Testing CrashKit" userInfo:nil];
//  @throw e;
//}

@end
