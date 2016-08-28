//
//  XpdButtonContainer.m
//  Button
//
//  Created by Ravi Prakash on 17/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import "XpdButtonContainer.h"
#import "XpdButton.h"
@interface XpdButtonContainer ()

@end

@implementation XpdButtonContainer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(UIView *) getXpdButtonsViewForParentViewController:(UIViewController *)parent {
    XpdButtonPageController *xpdButtonPageController = [[XpdButtonPageController alloc] init];
    xpdButtonPageController.delegate = (id)parent;
    xpdButtonPageController.buttonProperties = self.buttonProperties;
    xpdButtonPageController.numberOfMaxRow = self.numberOfMaxRow;
    xpdButtonPageController.buttonBorderColor = self.buttonBorderColor;
    xpdButtonPageController.buttonTitleColor = self.buttonTitleColor;
    xpdButtonPageController.buttonHighlightedTitleColor =  self.buttonHighlightedTitleColor;
    xpdButtonPageController.pageIndicatorTintColor = self.pageIndicatorTintColor;
    xpdButtonPageController.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;

    [parent addChildViewController:xpdButtonPageController];
    [xpdButtonPageController didMoveToParentViewController:parent];
    return xpdButtonPageController.view;
}

- (void) buttonGetClicked:(XpdButton *)button {
    [self.delegate buttonGetClicked:button];
}

@end
