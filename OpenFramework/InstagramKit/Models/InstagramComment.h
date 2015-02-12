//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//v

#import <Foundation/Foundation.h>
#import "InstagramModel.h"

@class InstagramUser;

@interface InstagramComment : InstagramModel

@property (nonatomic, strong) NSDate *createdDate;
@property (nonatomic, strong) InstagramUser *user;
@property (nonatomic, strong) NSString *text;

@end