//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//
//

#import <Foundation/Foundation.h>

@interface InstagramPaginationInfo : NSObject

@property (readonly) NSURL* nextURL;
@property (readonly) NSString *nextMaxId;
@property (readonly) Class type;
- (id)initWithInfo:(NSDictionary *)info andObjectType:(Class)type;

@end
