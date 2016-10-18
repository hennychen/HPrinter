//
//  PluginBarScan.m
//  HBuilder-Integrate
//
//  Created by hennychen on 9/20/16.
//  Copyright © 2016 DCloud. All rights reserved.
//

#import "PGPluginBLEPrinter.h"
#import "PDRCoreAppFrame.h"
#import "H5WEEngineExport.h"
#import "PDRToolSystemEx.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLETableViewController.h"
#import "SEPrinterManager.h"


@interface PGPluginBLEPrinter()
{
    
}

@property(nonatomic, copy)NSString* cbId;

@end

@implementation PGPluginBLEPrinter
#pragma mark 这个方法在使用WebApp方式集成时触发，WebView集成方式不触发

/*
 * WebApp启动时触发
 * 需要在PandoraApi.bundle/feature.plist/注册插件里添加autostart值为true，global项的值设置为true
 */
- (void) onAppStarted:(NSDictionary*)options{
    
    NSLog(@"5+ WebApp启动时触发");
    // 可以在这个方法里向Core注册扩展插件的JS
    
}

// 监听基座事件事件
// 应用退出时触发
- (void) onAppTerminate{
    //
    NSLog(@"APPDelegate applicationWillTerminate 事件触发时触发");
}

// 应用进入后台时触发
- (void) onAppEnterBackground{
    //
    NSLog(@"APPDelegate applicationDidEnterBackground 事件触发时触发");
}

// 应用进入前天时触发
- (void) onAppEnterForeground{
    //
    NSLog(@"APPDelegate applicationWillEnterForeground 事件触发时触发");
}

#pragma mark 以下为插件方法，由JS触发， WebView集成和WebApp集成都可以触发


- (void)PluginBLEPrinterScanFunction:(PGMethod*)commands
{
    if ( commands ) {
        
        // CallBackid 异步方法的回调id，H5+ 会根据回调ID通知JS层运行结果成功或者失败
        self.cbId = [commands.arguments objectAtIndex:0];
        NSLog(@"cbid---%@",_cbId);
        SEPrinterManager * manager = [SEPrinterManager sharedInstance];
        if (manager.isConnected) {

            NSString* pArgument1 = [commands.arguments objectAtIndex:1];
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSData *mainData = [pArgument1 dataUsingEncoding:enc];

//            NSData * mainData = [pArgument1 dataUsingEncoding:NSUTF8StringEncoding];
//            HLPrinter *printer = [[HLPrinter alloc] init];
//            NSString *title = @"测试电商";
//            NSString *str1 = @"测试电商服务中心(销售单)";
//            [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
//            [printer appendText:str1 alignment:HLTextAlignmentCenter];
//            [printer appendBarCodeWithInfo:@"RN3456789012"];
//            [printer appendSeperatorLine];
//            
//            NSData *mainData = [printer getFinalData];
            [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:nil];
        }else{
            [self scanBLEDevice];
        }
    }
}
//扫描蓝牙设备
-(void)scanBLEDevice{
    BLETableViewController * bletablevct = [[BLETableViewController alloc] initWithNibName:@"BLETableViewController" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:bletablevct];
    
//    __block typeof(self) weakSelf = self;
//        bletablevct.returnPeripheral = ^(CBPeripheral *peripheral){
//    //        [weakSelf connectBLEDevice:peripheral];
//            
//            SEPrinterManager *_manager = [SEPrinterManager sharedInstance];
//            
//    
//        };
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)callbackToJs:(NSString *)barcodestring{
    NSArray* pResultString = [NSArray arrayWithObjects:barcodestring, nil];
    PDRPluginResult * result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsArray:pResultString];
    [self toCallback:self.cbId withReslut:[result toJSONString]];
}



@end
