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
                                    @"buttonInfo" : @{@"key" : @"value"}
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
                                    }
                                  ];

    XpdButtonContainer *buttonPageController = [[XpdButtonContainer alloc] init];
    buttonPageController.delegate = self;
    buttonPageController.buttonProperties = buttonproperties;
    UIView *buttonView = [buttonPageController getXpdButtonsViewForParentViewController:self];
    buttonView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:buttonView];
    
    NSDictionary *views = @{@"view" : buttonView};
    NSArray *HC = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                          options:NSLayoutFormatAlignAllTop
                                                          metrics:nil
                                                            views:views];
    NSArray *VC = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(140)]-0-|"
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
