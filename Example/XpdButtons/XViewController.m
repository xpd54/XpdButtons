//
//  XViewController.m
//  XpdButtons
//
//  Created by Ravi Prakash on 08/19/2016.
//  Copyright (c) 2016 Ravi Prakash. All rights reserved.
//

#import "XViewController.h"

@interface XViewController ()

@end

@implementation XViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *buttonproperties = @[@{@"title" : @"When does it open?",
                                    @"buttonInfo" : @{@"key" : @"value"}
                                    },
                                  @{@"title" : @"Show photos.",
                                    @"buttonInfo" : @{@"key" : @"value 2"}
                                    },
                                  @{@"title" : @"Accepts credit cards?",
                                    @"buttonInfo" : @{@"key" : @"value 3"}
                                    },
                                  @{@"title" : @"Have valet",
                                    @"buttonInfo" : @{@"key" : @"value 4"}
                                    },
                                  @{@"title" : @"button6",
                                    @"buttonInfo" : @{@"key" : @"value 6"}
                                    },
                                  @{@"title" : @"button7",
                                    @"buttonInfo" : @{@"key" : @"value 6"}
                                    }
                                  ];

    XpdButtonContainer *buttonPageController = [[XpdButtonContainer alloc] init];
    buttonPageController.delegate = self;
    buttonPageController.buttonProperties = buttonproperties;
    buttonPageController.numberOfMaxRow = 2;
    UIView *buttonView = [buttonPageController getXpdButtonsViewForParentViewController:self];
    buttonView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:buttonView];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor redColor];
    textView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.view addSubview:textView];
    NSDictionary *views = @{@"view" : buttonView,
                            @"textView" : textView};
    NSArray *textViewHC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[textView]-50-|"
                                                                  options:NSLayoutFormatAlignAllTop
                                                                  metrics:nil
                                                                    views:views];
    NSArray *textViewVC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[textView(50)]"
                                                                  options:NSLayoutFormatAlignAllCenterX
                                                                  metrics:nil
                                                                    views:views];
    [self.view addConstraints:textViewHC];
    [self.view addConstraints:textViewVC];

    NSArray *HC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                          options:NSLayoutFormatAlignAllTop
                                                          metrics:nil
                                                            views:views];
    NSArray *VC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(200)]-0-|"
                                                          options:NSLayoutFormatAlignAllLeft
                                                          metrics:nil
                                                            views:views];
    [self.view addConstraints:HC];
    [self.view addConstraints:VC];
}

- (void) buttonGetClicked:(XpdButton *)button {
    if ([[button.buttonInfo objectForKey:@"key"] isEqualToString:@"value"]) {
        NSLog(@"%@", [button.buttonInfo objectForKey:@"key"]);
    }
    
    if ([button.title isEqualToString:@"Button 1"]) {
        // Do something
    }
}
@end
