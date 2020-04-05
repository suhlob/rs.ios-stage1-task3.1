#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    if ([numbers count] == 0) return nil;
    
    BOOL flag = false;
    NSInteger arrayLength = [numbers count];
    NSMutableString *result = [[NSMutableString alloc] init];

    for (int i = 0; i < [numbers count]; i++) {
        int element = [numbers[i] intValue];
        int absoluteValueOfElement = abs(element);

        arrayLength = arrayLength - 1;
        if (flag) {
            flag = false;
        } else {
            if (arrayLength >= 2) {
                (abs(element) != 1) ?
                    [result appendString:[NSString stringWithFormat:@"%d%@%d", absoluteValueOfElement, @"x^", (int) (arrayLength)]] :
                    [result appendString:[NSString stringWithFormat:@"%@%d", @"x^", (int) (arrayLength)]];
            } else if (arrayLength == 1) {
                (absoluteValueOfElement != 1) ?
                    [result appendString:[NSString stringWithFormat:@"%d%@", absoluteValueOfElement, @"x"]] :
                    [result appendString:[NSString stringWithFormat:@"%@", @"x"]];
            } else if (arrayLength == 0) {
                [result appendString:[NSString stringWithFormat:@"%d", absoluteValueOfElement]];
            }
        }
        if (arrayLength > 0) {
            if ([numbers[i + 1] intValue] > 0) {
                [result appendString:[NSString stringWithFormat:@" + "]];
            } else if ([numbers[i + 1] intValue] < 0) {
                [result appendString:[NSString stringWithFormat:@" - "]];
            } else {
                flag = true;
            }
        }
    }
    return result;
}
@end
