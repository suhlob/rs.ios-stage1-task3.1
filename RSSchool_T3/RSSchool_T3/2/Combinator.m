#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    int m = [[array objectAtIndex:0] intValue];
    int n = [[array objectAtIndex:1] intValue];
    int r = 1;
    for (int i = 0; i <= n; i++) {
        if (r == m) return [NSNumber numberWithInt:i];
        r = r * (n - i) / (i + 1);
    }
    return nil;
}
@end
