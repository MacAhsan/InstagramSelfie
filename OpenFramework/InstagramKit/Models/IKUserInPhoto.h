//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class InstagramUser;

@interface IKUserInPhoto : NSObject

@property (nonatomic, readonly) CGPoint positionPercentage;
@property (nonatomic, readonly) InstagramUser *user;


@end
