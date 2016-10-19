//
//  WebPrewViewController.m
//  HBuilder-Hello
//
//  Created by hennychen on 10/19/16.
//  Copyright © 2016 DCloud. All rights reserved.
//

#import "WebPrewViewController.h"
#import "UIWebView+UIImage.h"


@interface WebPrewViewController ()<UIWebViewDelegate>
@property (retain, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebPrewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadHTMLString:self.htmlString baseURL:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(closeview)];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
 
    UIImage * img = [webView imageForWebView];
    _webCallback(img);
   
}
-(void)closeview{
     [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}
@end
