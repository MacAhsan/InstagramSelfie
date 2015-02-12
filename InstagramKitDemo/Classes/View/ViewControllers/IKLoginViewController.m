//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import "IKLoginViewController.h"
#import "IKCollectionViewController.h"

@implementation IKLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mWebView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mWebView.scrollView.bounces = YES;
    mWebView.contentMode = UIViewContentModeScaleAspectFit;
    mWebView.delegate = self;
    
    self.scope = IKLoginScopeRelationships | IKLoginScopeComments | IKLoginScopeLikes;
    
    NSDictionary *configuration = [InstagramEngine sharedEngineConfiguration];
    NSString *scopeString = [InstagramEngine stringForScope:self.scope];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@", configuration[kInstagramKitAuthorizationUrlConfigurationKey], configuration[kInstagramKitAppClientIdConfigurationKey], configuration[kInstagramKitAppRedirectUrlConfigurationKey], scopeString]];

    [mWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *URLString = [request.URL absoluteString];
    if ([URLString hasPrefix:[[InstagramEngine sharedEngine] appRedirectURL]]) {
        NSString *delimiter = @"access_token=";
        NSArray *components = [URLString componentsSeparatedByString:delimiter];
        if (components.count > 1) {
            NSString *accessToken = [components lastObject];
            NSLog(@"ACCESS TOKEN = %@",accessToken);
            [[InstagramEngine sharedEngine] setAccessToken:accessToken];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.collectionViewController reloadMedia];
            }];
        }
        return NO;
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}



@end
