//
//  XpdButtonContainer.h
//  Button
//
//  Created by Ravi Prakash on 17/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XpdButtonPageController.h"

/*!
 @brief XpdButtonAction is adopted by viewController where XpdButtonsView is gonna be used.
 @see <tt>-(UIView *) getXpdButtonsViewForParentViewController:(UIViewController *)parent;</tt>
 */
@protocol XpdButtonAction

/*!
 *@brief Track when Buttons got clicked. Use buttonInfo and title property to track which button get clicked.
 <pre> 
    -(void) buttonGetClicked:(XpdButton *)button {
            if ([[button.buttonInfo objectForKey:@"key"] isEqualToString:@"value"]) {
                // Do something
            }
            if ([button.title isEqualToString:@"Button 1"]) {
                // Do something
            }
        }
 </pre>
 */
- (void) buttonGetClicked:(XpdButton *)button;
@end
@interface XpdButtonContainer : UIViewController<XpdButtons>

/*!
 *@brief Button properties is an Array of dictionary.
 Element Dictionary contains keys -> (title, buttonInfo). ButtonInfo a is dictionary(anyKey: anyValue).
 Ex :-
 <pre>  NSArray *properties = @[
                            @{
                                @"title" : @"button 1",
                                @"buttonInfo" : @{@"key" : @"value"}
                            },
                            @{
                                @"title" : @"button 2",
                                @"buttonInfo" : @{@"key" : @"value"}
                            }];
 </pre>
 */
@property (nonatomic, strong) NSArray *buttonProperties;

/*!
 @brief Number of maximum row of buttons in one pageView. It will dynamically set other buttons to diffrent pageView. Default is 2.
 */
@property (nonatomic, assign) NSInteger numberOfMaxRow;

/*!
 @brief Set button border color. Default is black.
 */
@property (nonatomic, strong) UIColor *buttonBorderColor;

/*!
 @brief Set Button title color. Default is black.
 */
@property (nonatomic, strong) UIColor *buttonTitleColor;

/*!
 @brief Set Button title color in Highlighted condition. Default is red.
 */
@property (nonatomic, strong) UIColor *buttonHighlightedTitleColor;

/*!
 @brief Set Page Indicator Tint color. Default is lightGray.
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/*!
 @brief Set Current Page indicator tint color. Default is black.
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/*!
 @brief Delegate to use XpdButtonAction protocol.
 @see XpdButtonAction
 @see -(void) buttonGetClicked:(UIButton *)button;
 */
@property (nonatomic, weak) id<XpdButtonAction> delegate;
 
/*!
 @brief Get view which contains buttons.
 @param parent viewController where you gonna use the buttons view.
 @return view which contains all buttons with multiple page.
 <pre>
    XpdButtonContainer *buttonPageController = [[XpdButtonContainer alloc] init];
    buttonPageController.delegate = self;
    buttonPageController.buttonProperties = buttonproperties;
    buttonPageController.numberOfMaxRow = 4;
    UIView *buttonView = [buttonPageController getXpdButtonsViewForParentViewController:self];
 </pre>
 @see buttonProperties
 */
-(UIView *) getXpdButtonsViewForParentViewController:(UIViewController *)parent;
@end
