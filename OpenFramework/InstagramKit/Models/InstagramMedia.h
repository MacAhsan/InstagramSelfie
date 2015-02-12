//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "InstagramModel.h"

@class InstagramUser;
@class InstagramComment;

@interface InstagramMedia : InstagramModel

@property (nonatomic, readonly) InstagramUser* user;
@property (nonatomic, readonly) NSDate *createdDate;
@property (nonatomic, readonly) NSString* link;
@property (nonatomic, readonly) InstagramComment* caption;
@property (nonatomic, readonly) NSInteger likesCount;
@property (nonatomic, readonly) NSArray *likes;
@property (nonatomic, readonly) NSInteger commentCount;
@property (nonatomic, readonly) NSArray *comments;
@property (nonatomic, readonly) NSArray *tags;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, readonly) NSString* filter;
@property (nonatomic, readonly) NSDictionary* images;

@property (nonatomic, readonly) NSURL *thumbnailURL;
@property (nonatomic, readonly) CGSize thumbnailFrameSize;
@property (nonatomic, readonly) NSURL *lowResolutionImageURL;
@property (nonatomic, readonly) CGSize lowResolutionImageFrameSize;
@property (nonatomic, readonly) NSURL *standardResolutionImageURL;
@property (nonatomic, readonly) CGSize standardResolutionImageFrameSize;

@property (nonatomic, readonly) BOOL isVideo;
@property (nonatomic, readonly) NSURL *lowResolutionVideoURL;
@property (nonatomic, readonly) CGSize lowResolutionVideoFrameSize;
@property (nonatomic, readonly) NSURL *standardResolutionVideoURL;
@property (nonatomic, readonly) CGSize standardResolutionVideoFrameSize;

@end
