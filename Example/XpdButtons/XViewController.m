//
//  XViewController.m
//  XpdButtons
//
//  Created by Ravi Prakash on 08/19/2016.
//  Copyright (c) 2016 Ravi Prakash. All rights reserved.
//

#import "XViewController.h"

@interface XViewController ()
@property (nonatomic, strong) UITextView *inputTextView;
@end

@implementation XViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Button Properties.
    NSArray *buttonproperties = @[@{@"title" : @"I am the 📅 button",
                                    @"buttonInfo" : @{@"key" : @"value"}
                                    },
                                  @{@"title" : @"I should get one ⏳",
                                    @"buttonInfo" : @{@"key" : @"value 2"}
                                    },
                                  @{@"title" : @"Laugh 👴",
                                    @"buttonInfo" : @{@"key" : @"value 3"}
                                    },
                                  @{@"title" : @"No Praking",
                                    @"buttonInfo" : @{@"key" : @"value 4"}
                                    },
                                  @{@"title" : @"Sleep Mode",
                                    @"buttonInfo" : @{@"key" : @"value 5"}
                                    },
                                  @{@"title" : @"No Don't Allow",
                                    @"buttonInfo" : @{@"key" : @"value 6"}
                                    },
                                  @{@"title" : @"Share Picture",
                                    @"buttonInfo" : @{@"key" : @"value 7"}
                                    },
                                  @{@"title" : @"Download Music 🎶",
                                    @"buttonInfo" : @{@"key" : @"value 8"}
                                    }
                                  ];

    XpdButtonContainer *buttonPageController = [[XpdButtonContainer alloc] init];
    buttonPageController.delegate = self;
    buttonPageController.buttonProperties = buttonproperties;
    // Number of maximum row in one page
    buttonPageController.numberOfMaxRow = 3;

    // ButtonView which have buttons aranged in page view.
    UIView *buttonView = [buttonPageController getXpdButtonsViewForParentViewController:self];

    self.inputTextView = [[UITextView alloc] init];
    self.inputTextView.translatesAutoresizingMaskIntoConstraints = false;

    // Set the view as inputView
    [self.inputTextView setInputView:buttonView];

    [self.view addSubview:self.inputTextView];
    NSDictionary *views = @{@"textView" : self.inputTextView};
    NSArray *textViewHC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[textView]-20-|"
                                                                  options:NSLayoutFormatAlignAllTop
                                                                  metrics:nil
                                                                    views:views];
    NSArray *textViewVC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[textView(30)]"
                                                                  options:NSLayoutFormatAlignAllCenterX
                                                                  metrics:nil
                                                                    views:views];
    [self.view addConstraints:textViewHC];
    [self.view addConstraints:textViewVC];
}

#pragma mark XpdButtonAction protocol

- (void) buttonGetClicked:(XpdButton *)button {
    NSString *titleText = button.titleLabel.text;
    // Handle button click

    [self.inputTextView setText:titleText];
    NSLog(@"%@", button.buttonInfo);
}
@end
