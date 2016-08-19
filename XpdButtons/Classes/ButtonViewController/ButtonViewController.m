//
//  ButtonViewController.m
//  Button
//
//  Created by Ravi Prakash on 10/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import "ButtonViewController.h"
@interface ButtonViewController ()

@end

@implementation ButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) loadView {
    [super loadView];
    [self setupButtons];
}

- (void) setupButtons {
    XpdButton *leftUpperCornerButton = [[XpdButton alloc] init];
    XpdButton *rightUpperCornerButton = [[XpdButton alloc] init];
    XpdButton *leftLowerCornerButton = [[XpdButton alloc] init];
    XpdButton *rightLowerCornerButton = [[XpdButton alloc] init];
    NSArray *buttons = @[leftUpperCornerButton, rightUpperCornerButton, leftLowerCornerButton, rightLowerCornerButton];
    buttons = [self setPropertiesOfButtons:buttons AndInfo:self.buttonProperties];
    // LUCButton -> LeftUpperCornerButton
    NSDictionary *views = @{@"LUCButton" : leftUpperCornerButton,
                            @"RUCButton" : rightUpperCornerButton,
                            @"LLCButton" : leftLowerCornerButton,
                            @"RLCButton" : rightLowerCornerButton};
    NSMutableDictionary *metrics = [[NSMutableDictionary alloc] init];
    NSInteger leftUBLength = leftUpperCornerButton.title.length;
    NSInteger rightUBLength = rightUpperCornerButton.title.length;
    NSInteger leftLBLength = leftLowerCornerButton.title.length;
    NSInteger rightLBLength = rightLowerCornerButton.title.length;

    NSString *verticalButtonGap = @"VBGap";
    if ((leftUBLength > 0 && leftLBLength > 0) ||
        (leftUBLength > 0 && rightLBLength > 0) ||
        (rightUBLength > 0 && leftLBLength > 0) ||
        (rightUBLength > 0 && rightLBLength > 0)) {
        [metrics setObject:@6 forKey:verticalButtonGap];
    } else {
        [metrics setObject:@0 forKey:verticalButtonGap];
    }
    
    NSString *verticalButtonMargin = @"VBM";
    [metrics setObject:@20 forKey:verticalButtonMargin];
    
    NSString *leftUpperButtonWidth;
    NSString *rightUpperButtonWidth;
    NSString *leftLowerButtonWidth;
    NSString *rightLowerButtonWidth;
    
    NSString *leftUpperButtonHeight;
    NSString *rightUpperButtonHeight;
    NSString *leftLowerButtonHeight;
    NSString *rightLowerButtonHeight;

    NSString *lowerButtonHorizontalGap = @"LBHGap";
    NSString *upperButtonHorizontalGap = @"UBHGap";

    NSString *lUMargin;
    NSString *rUMargin;
    NSString *lLMargin;
    NSString *rLMargin;
    if (leftUBLength > 0 &&
        rightUBLength > 0 &&
        leftLBLength > 0 &&
        rightLBLength > 0) {
        leftUpperButtonWidth = @"(RUCButton)";
        rightUpperButtonWidth = @"";
        leftLowerButtonWidth = @"(RLCButton)";
        rightLowerButtonWidth = @"";
        
        leftUpperButtonHeight = @"(LLCButton)";
        rightUpperButtonHeight = @"(34)";
        leftLowerButtonHeight = @"(RLCButton)";
        rightLowerButtonHeight = @"(34)";

        [metrics setObject:@6 forKey:upperButtonHorizontalGap];
        [metrics setObject:@6 forKey:lowerButtonHorizontalGap];
        lUMargin = @"54-";
        rUMargin = @"-54-|";
        lLMargin = @"34-";
        rLMargin = @"-34-|";
    } else if (leftUBLength > 0 &&
               rightUBLength > 0 &&
               leftLBLength > 0 &&
               rightLBLength == 0) {
        leftUpperButtonWidth = @"(RUCButton)";
        rightUpperButtonWidth = @"";
        leftLowerButtonWidth = @"";
        rightLowerButtonWidth = @"(0)";
        
        leftUpperButtonHeight = @"(34)";
        rightUpperButtonHeight = @"(34)";
        leftLowerButtonHeight = @"(34)";
        rightLowerButtonHeight = @"(0)";

        [metrics setObject:@6 forKey:upperButtonHorizontalGap];
        [metrics setObject:@0 forKey:lowerButtonHorizontalGap];

        lUMargin = @"54-";
        rUMargin = @"-54-|";
        lLMargin = @"34-";
        rLMargin = @"-34-|";
    } else if (leftUBLength > 0 &&
               rightUBLength > 0 &&
               leftLBLength == 0 &&
               rightLBLength == 0) {
        leftUpperButtonWidth = @"(RUCButton)";
        rightUpperButtonWidth = @"";
        leftLowerButtonWidth = @"(0)";
        rightLowerButtonWidth = @"(0)";

        leftUpperButtonHeight = @"(RUCButton)";
        rightUpperButtonHeight = @"(34)";
        leftLowerButtonHeight = @"(0)";
        rightLowerButtonHeight = @"(0)";

        [metrics setObject:@6 forKey:upperButtonHorizontalGap];
        [metrics setObject:@0 forKey:lowerButtonHorizontalGap];

        lUMargin = @"54-";
        rUMargin = @"-54-|";
        lLMargin = @"";
        rLMargin = @"";
    } else if (leftUBLength > 0 &&
               rightUBLength == 0 &&
               leftLBLength == 0 &&
               rightLBLength == 0) {
        leftUpperButtonWidth = @"";
        rightUpperButtonWidth = @"(0)";
        leftLowerButtonWidth = @"(0)";
        rightLowerButtonWidth = @"(0)";
        
        leftUpperButtonHeight = @"(34)";
        rightUpperButtonHeight = @"(0)";
        leftLowerButtonHeight = @"(0)";
        rightLowerButtonHeight = @"(0)";

        [metrics setObject:@0 forKey:upperButtonHorizontalGap];
        [metrics setObject:@0 forKey:lowerButtonHorizontalGap];

        lUMargin = @"54-";
        rUMargin = @"-54-|";
        lLMargin = @"";
        rLMargin = @"";
    }
    
    NSString *leftUpperButtonHCS = [NSString stringWithFormat:@"H:|-%@[LUCButton%@]-UBHGap-[RUCButton%@]%@", lUMargin, leftUpperButtonWidth, rightUpperButtonWidth, rUMargin];
    NSString *leftUpperButtonVCS = [NSString stringWithFormat:@"V:|-VBM-[LUCButton%@]-VBGap-[LLCButton%@]",leftUpperButtonHeight,rightUpperButtonHeight];
    NSString *rightLowerButtonHCS= [NSString stringWithFormat:@"H:|-%@[LLCButton%@]-LBHGap-[RLCButton%@]%@", lLMargin, leftLowerButtonWidth, rightLowerButtonWidth, rLMargin];
    NSString *rightLowerButtonVCS = [NSString stringWithFormat:@"V:|-VBM-[RUCButton%@]-VBGap-[RLCButton%@]",rightUpperButtonHeight, rightLowerButtonHeight];
    
    NSArray *leftUpperButtonHC = [NSLayoutConstraint constraintsWithVisualFormat:leftUpperButtonHCS
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views];
    NSArray *leftUpperButtonVC = [NSLayoutConstraint constraintsWithVisualFormat:leftUpperButtonVCS
                                                                         options:0
                                                                         metrics:metrics
                                                                           views:views];
    NSArray *rightLowerButtonHC = [NSLayoutConstraint constraintsWithVisualFormat:rightLowerButtonHCS
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:views];
    NSArray *rightLowerButtonVC = [NSLayoutConstraint constraintsWithVisualFormat:rightLowerButtonVCS
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:views];
    [self.view addConstraints:leftUpperButtonHC];
    [self.view addConstraints:leftUpperButtonVC];
    [self.view addConstraints:rightLowerButtonHC];
    [self.view addConstraints:rightLowerButtonVC];
}

- (NSArray *) setPropertiesOfButtons:(NSArray *)buttons AndInfo:(NSArray *)info {
    [buttons enumerateObjectsUsingBlock:^(XpdButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *buttonInfo = info.count > idx ? [info objectAtIndex:idx]: nil;
        button.layer.cornerRadius = 3.0;
        button.layer.borderWidth = 2.0;
        button.buttonInfo = [buttonInfo objectForKey:KEYBOARD_BUTTON_INFO];
        button.title = [buttonInfo objectForKey:KEYBOARD_BUTTON_TITLE];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:[NSString stringWithFormat:@"%@", [buttonInfo objectForKey:KEYBOARD_BUTTON_TITLE]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.translatesAutoresizingMaskIntoConstraints = false;
        [self.view addSubview:button];
    }];
    return buttons;
}

- (IBAction) buttonClicked:(XpdButton *)sender {
    [self.delegate buttonGetClicked:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
