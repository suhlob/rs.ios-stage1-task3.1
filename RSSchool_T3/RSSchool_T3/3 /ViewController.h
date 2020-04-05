#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UILabel *labelRed;
@property (nonatomic, strong) UILabel *labelGreen;
@property (nonatomic, strong) UILabel *labelBlue;
@property (nonatomic, strong) UILabel *labelResultColor;

@property(nonatomic, strong) UITextField *textFieldRed;
@property(nonatomic, strong) UITextField *textFieldGreen;
@property(nonatomic, strong) UITextField *textFieldBlue;

@property (nonatomic,strong) UIButton *buttonProcess;

@property (nonatomic, strong) UIView *viewResultColor;

- (void)setupColorView;
- (void)setupLabels;
- (void)setupTextFields;
- (void)setupButton;
- (void)accessibilityIdentifier;
- (void)buttonClick;
- (void)fieldTappedAfterError;
- (NSString *)colorToHex:(UIColor *)color;

@end

