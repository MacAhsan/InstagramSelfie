//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//


#import "InstagramTag.h"
#import "InstagramModel.h"

@implementation InstagramTag

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self && IKNotNull(info)) {
        _name = [[NSString alloc] initWithString:info[kTagName]];
        _mediaCount = [info[kTagMediaCount] integerValue];
    }
    return self;
}

@end
