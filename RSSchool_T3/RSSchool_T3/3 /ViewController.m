#import "ViewController.h"

int const LABEL_POSITION_X = 20;
int const LABEL_WIDTH = 120;
int const LABEL_HEIGHT = 50;

int const TEXTFIELD_WIDTH = 200;
int const TEXTFIELD_HEIGHT = 30;
int const TEXTFIELD_POSITION_X = 120;
int const TEXTFIELD_CORNER_RADIUS = 8.0f;
int const TEXTFIELD_BORDER_WIDTH = 1.0f;

NSString *TEXTFIELD_PLACEHOLDER = @"0..255";

@implementation ViewController

#pragma mark - method is called by ios when view is loaded

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupColorView];
    [self setupLabels];
    [self setupTextFields];
    [self setupButton];
    [self accessibilityIdentifier];
}

#pragma mark - method for setting up uiview as an color palette

- (void)setupColorView{
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(140, 55, 180, 40)];
    self.viewResultColor.opaque = false;
    self.viewResultColor.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.viewResultColor];
}

#pragma mark - method for setting up uilabels as interface elements

- (void)setupLabels{
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_POSITION_X, 50, LABEL_WIDTH, LABEL_HEIGHT)];
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_POSITION_X, 100, LABEL_WIDTH, LABEL_HEIGHT)];
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_POSITION_X, 150, LABEL_WIDTH, LABEL_HEIGHT)];
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_POSITION_X, 200, LABEL_WIDTH, LABEL_HEIGHT)];

    NSArray<UILabel*> *labels = @[self.labelRed, self.labelGreen, self.labelBlue, self.labelResultColor];
    NSArray<NSString*> *titles = @[@"RED", @"GREEN", @"BLUE", @"Color"];
    for (int i = 0; i < [labels count]; i++) {
        labels[i].text = titles[i];
        labels[i].textColor = UIColor.blackColor;
        [self.view addSubview:labels[i]];
    }
}

#pragma mark - method for setting up uitextfields which are will be used as an input for color's conversion

- (void)setupTextFields{
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(TEXTFIELD_POSITION_X, 110, TEXTFIELD_WIDTH, TEXTFIELD_HEIGHT)];
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(TEXTFIELD_POSITION_X, 160, TEXTFIELD_WIDTH, TEXTFIELD_HEIGHT)];
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(TEXTFIELD_POSITION_X, 210, TEXTFIELD_WIDTH, TEXTFIELD_HEIGHT)];
    
    NSArray<UITextField*> *textFields = @[self.textFieldRed, self.textFieldGreen, self.textFieldBlue];
    
    for (UITextField *textField in textFields) {
        textField.layer.cornerRadius = TEXTFIELD_CORNER_RADIUS;
        textField.layer.masksToBounds = YES;
        textField.layer.borderColor = [[UIColor grayColor] CGColor];
        textField.layer.borderWidth = TEXTFIELD_BORDER_WIDTH;
        textField.placeholder = TEXTFIELD_PLACEHOLDER;
        [textField addTarget:self action:@selector(fieldTappedAfterError) forControlEvents:UIControlEventEditingDidBegin];
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        [self.view addSubview:textField];
    }
}

#pragma mark - method for setting up uibutton which will be used for processing color's conversion

- (void)setupButton{
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 260, 100, 40)];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [self.buttonProcess addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonProcess];
}

#pragma mark - method for setting up test identifiers

- (void)accessibilityIdentifier{
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

#pragma mark - method is called by button for validation uitextfields and setting color

- (void)buttonClick{
    NSCharacterSet* nonNumberCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

    float red = [self.textFieldRed.text floatValue];
    float green = [self.textFieldGreen.text floatValue];
    float blue = [self.textFieldBlue.text floatValue];

    if (
        !self.textFieldRed.text.length ||
        !self.textFieldGreen.text.length ||
        !self.textFieldBlue.text.length ||
        red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255 ||
        [self.textFieldRed.text rangeOfCharacterFromSet:nonNumberCharacters].location != NSNotFound ||
        [self.textFieldGreen.text rangeOfCharacterFromSet:nonNumberCharacters].location != NSNotFound ||
        [self.textFieldBlue.text rangeOfCharacterFromSet:nonNumberCharacters].location != NSNotFound
    ) {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
    } else {
        self.viewResultColor.backgroundColor = [UIColor colorWithRed:red / 255
                                                               green:green / 255
                                                                blue:blue / 255
                                                               alpha:1];
        self.labelResultColor.text = [self colorToHex:self.viewResultColor.backgroundColor];
    }

    [self.textFieldRed resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
}

#pragma mark - method is called when user click's at any uitextfield

- (void)fieldTappedAfterError{
    if (![self.labelResultColor.text isEqualToString:@"Color"]) {
        self.viewResultColor.backgroundColor = UIColor.clearColor;
        self.labelResultColor.text = @"Color";
        self.textFieldRed.text = @"";
        self.textFieldGreen.text = @"";
        self.textFieldBlue.text = @"";
    }
}

#pragma mark - method is used for converting uicolor into hex

- (NSString *)colorToHex:(UIColor *)color{
    if (!color) { return nil; }
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX",
                     lroundf(components[0] * 255),
                     lroundf(components[1] * 255),
                     lroundf(components[2] * 255)
    ];
}

@end
