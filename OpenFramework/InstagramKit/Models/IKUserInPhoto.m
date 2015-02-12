//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import "IKUserInPhoto.h"
#define IKNotNull(obj) (obj && ![obj isEqual:[NSNull null]])

@implementation IKUserInPhoto

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self && IKNotNull(info)) {
        
    }
    return self;
}


@end
