//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import <UIKit/UIKit.h>
#import "InstagramKit.h"

@class IKCollectionViewController;
@interface IKLoginViewController : UIViewController <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *mWebView;
}

@property (nonatomic, assign) IKLoginScope scope;
@property (nonatomic, weak) IKCollectionViewController *collectionViewController;
- (IBAction)back:(id)sender;
@end
