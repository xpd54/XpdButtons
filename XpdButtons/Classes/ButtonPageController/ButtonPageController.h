//
//  ButtonPageController.h
//  Button
//
//  Created by Ravi Prakash on 09/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonViewController.h"
@protocol ButtonAction
- (void) buttonGetClicked:(XpdButton *)button;
@end
@interface ButtonPageController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, XpdButtons>
@property (nonatomic, strong) NSArray *buttonProperties;
@property (nonatomic, weak) id<ButtonAction> delegate;
@end
