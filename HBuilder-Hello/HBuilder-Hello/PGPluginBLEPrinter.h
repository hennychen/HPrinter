//
//  PluginBarScan.h
//  HBuilder-Integrate
//
//  Created by hennychen on 9/20/16.
//  Copyright © 2016 DCloud. All rights reserved.
//

#import "PGPlugin.h"
#include "PGMethod.h"
#import <Foundation/Foundation.h>

@interface PGPluginBLEPrinter : PGPlugin

//扫描事件触发
- (void)PluginBLEPrinterScanFunction:(PGMethod*)command;

@end
