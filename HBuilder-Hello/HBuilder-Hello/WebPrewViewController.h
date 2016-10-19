//
//  WebPrewViewController.h
//  HBuilder-Hello
//
//  Created by hennychen on 10/19/16.
//  Copyright © 2016 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebPrewViewController : UIViewController

@property(nonnull, copy)void(^webCallback)(UIImage * webimg);
@property(nonnull, strong)NSString * htmlString;
@end
