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
    NSArray *buttonproperties = @[@{@"title" : @"button1",
                                    @"buttonInfo" : @{@"key" : @"value 1"}
                                    },
                                  @{@"title" : @"button2",
                                    @"buttonInfo" : @{@"key" : @"value 2"}
                                    },
                                  @{@"title" : @"button3",
                                    @"buttonInfo" : @{@"key" : @"value 3"}
                                    },
                                  @{@"title" : @"button4",
                                    @"buttonInfo" : @{@"key" : @"value 4"}
                                    },
                                  @{@"title" : @"button5",
                                    @"buttonInfo" : @{@"key" : @"value 5"}
                                    },
                                  @{@"title" : @"button6",
                                    @"buttonInfo" : @{@"key" : @"value 6"}
                                    },
                                  @{@"title" : @"button7",
                                    @"buttonInfo" : @{@"key" : @"value 7"}
                                    },
                                  @{@"title" : @"button8",
                                    @"buttonInfo" : @{@"key" : @"value 8"}
                                    },
                                  @{@"title" : @"button9",
                                    @"buttonInfo" : @{@"key" : @"value 9"}
                                    }
                                  ];
    XpdButtonContainer *buttonPageController = [[XpdButtonContainer alloc] init];
    buttonPageController.delegate = self;
    buttonPageController.buttonProperties = buttonproperties;
    UIView *baseview = [[UIView alloc] init];
    baseview.translatesAutoresizingMaskIntoConstraints = false;
    baseview.backgroundColor = [UIColor whiteColor];
    UIView *buttonView = [buttonPageController getXpdButtonsViewForParentViewController:self];
    buttonView.translatesAutoresizingMaskIntoConstraints = false;
    [baseview addSubview:buttonView];
    [self.view addSubview:baseview];
    
    NSDictionary *views = @{@"view" : buttonView,
                            @"baseView" : baseview};
    NSArray *HC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                          options:NSLayoutFormatAlignAllTop
                                                          metrics:nil
                                                            views:views];
    NSArray *VC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                          options:NSLayoutFormatAlignAllLeft
                                                          metrics:nil
                                                            views:views];
    NSArray *baseHC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[baseView]-0-|"
                                                              options:NSLayoutFormatAlignAllTop
                                                              metrics:nil
                                                                views:views];
    NSArray *baseVC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[baseView(140)]-0-|"
                                                              options:NSLayoutFormatAlignAllLeft
                                                              metrics:nil
                                                                views:views];
    [baseview addConstraints:HC];
    [baseview addConstraints:VC];
    [self.view addConstraints:baseHC];
    [self.view addConstraints:baseVC];
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
