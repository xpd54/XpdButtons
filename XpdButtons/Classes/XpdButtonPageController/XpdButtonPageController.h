//
//  XpdButtonPageController.h
//  Button
//
//  Created by Ravi Prakash on 09/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XpdButton.h"
#define KEYBOARD_BUTTON_TITLE @"title"
#define KEYBOARD_BUTTON_INFO  @"buttonInfo"
@protocol XpdButtons
-(void) buttonGetClicked:(XpdButton *)button;
@end
@interface XpdButtonPageController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, XpdButtons>
@property (nonatomic, weak) id<XpdButtons> delegate;
@property (nonatomic, strong) NSArray *buttonProperties;
@property NSInteger numberOfMaxRow;
@property (nonatomic, strong) UIColor *buttonBorderColor;
@property (nonatomic, strong) UIColor *buttonTitleColor;
@property (nonatomic, strong) UIColor *buttonHighlightedTitleColor;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@end
