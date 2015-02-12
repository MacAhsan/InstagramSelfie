//  Created by Muhammad Ahsan on 01/20/15.
// Code Test
//

#import "InstagramModel.h"

@implementation InstagramModel

- (id)initWithInfo:(NSDictionary *)info
{
    self = [super init];
    if (self && IKNotNull(info)) {
        _Id = [[NSString alloc] initWithString:info[kID]];
    }
    return self;
}

@end
