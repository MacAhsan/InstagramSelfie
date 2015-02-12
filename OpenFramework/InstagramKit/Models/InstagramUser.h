//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import <Foundation/Foundation.h>

#import "InstagramModel.h"

@interface InstagramUser : InstagramModel

@property (readonly) NSString* username;
@property (readonly) NSString* fullName;
@property (readonly) NSURL* profilePictureURL;
@property (readonly) NSString* bio;
@property (readonly) NSURL* website;
// Transient
@property (readonly) NSInteger mediaCount;
@property (readonly) NSInteger followsCount;
@property (readonly) NSInteger followedByCount;

@property (readonly) NSArray *recentMedia;

- (void)loadCounts;
- (void)loadCountsWithSuccess:(void(^)(void))success failure:(void(^)(void))failure;

- (void)loadRecentMedia:(NSInteger)count;
- (void)loadRecentMedia:(NSInteger)count withSuccess:(void(^)(void))success failure:(void(^)(void))failure;

@end
