//
//  XpdButtonPageController.m
//  Button
//
//  Created by Ravi Prakash on 09/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import "XpdButtonPageController.h"
#define SPACING 6
#define BOTTOM_MARGIN 34
#define DEFAULT_COLOR [UIColor blackColor]
@interface XpdButtonPageController ()
@property (nonatomic, strong) UIPageViewController *pageViewContrroller;
@property (nonatomic, strong) NSArray *buttonViewControllers;
@end

@implementation XpdButtonPageController
{
    CGFloat buttonHeight;
    CGFloat frameHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) loadView {
    [super loadView];
    // Intializing frameHeight
    frameHeight = 0;
    NSInteger maxRow;
    maxRow = self.numberOfMaxRow ? self.numberOfMaxRow : 2;
    self.buttonViewControllers = [[NSArray alloc] initWithArray:[self getViewControllersHoldingButtons:self.buttonProperties numberOfRowViewController:maxRow]];
    
    self.pageViewContrroller = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                               navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                             options:nil];
    self.pageViewContrroller.dataSource = self;
    self.pageViewContrroller.delegate = self;
    NSArray *viewControllers = @[[self.buttonViewControllers objectAtIndex:0]];
    [self.pageViewContrroller setViewControllers:viewControllers
                                       direction:UIPageViewControllerNavigationDirectionForward
                                        animated:false
                                      completion:nil];
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[XpdButtonPageController class]]];
    UIColor *pgITColor = self.pageIndicatorTintColor ? self.pageIndicatorTintColor : [UIColor lightGrayColor];
    pageControl.pageIndicatorTintColor = pgITColor;
    UIColor *cpITColor = self.currentPageIndicatorTintColor ? self.currentPageIndicatorTintColor : DEFAULT_COLOR;
    pageControl.currentPageIndicatorTintColor = cpITColor;
    [self addChildViewController:self.pageViewContrroller];
    [self.view addSubview:self.pageViewContrroller.view];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, frameHeight);
    [self.pageViewContrroller didMoveToParentViewController:self];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger vcIndex = [self.buttonViewControllers indexOfObject:viewController];
    NSInteger previousVCIndex = vcIndex - 1;
    if (self.buttonViewControllers.count == 1) {
        return nil;
    }
    if (!(previousVCIndex >= 0)) {
        return (UIViewController *)self.buttonViewControllers.lastObject;
    }
    if (!(self.buttonViewControllers.count > previousVCIndex)) {
        return nil;
    }
    return (UIViewController *)[self.buttonViewControllers objectAtIndex:previousVCIndex];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger vcIndex = [self.buttonViewControllers indexOfObject:viewController];
    NSInteger nextVCIndex = vcIndex + 1;
    if (self.buttonViewControllers.count == 1) {
        return nil;
    }
    if (!(nextVCIndex < self.buttonViewControllers.count)) {
        return (UIViewController *)self.buttonViewControllers.firstObject;
    }
    if (!(nextVCIndex > 0)) {
        return nil;
    }
    return (UIViewController *)[self.buttonViewControllers objectAtIndex:nextVCIndex];
}


-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.buttonViewControllers.count;
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void) buttonGetClicked:(XpdButton *)button {
    [self.delegate buttonGetClicked:button];
}

#pragma Buttons setup methods (Every thing which finally return array of viewcontroller)

- (NSArray *) getViewControllersHoldingButtons:(NSArray *) buttonProperties numberOfRowViewController: (NSInteger)numberOfRow {
    NSArray *views = [self getArrayOfViewForButtonProperties:buttonProperties];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < views.count;) {
        NSArray *subArray = [views subarrayWithRange:NSMakeRange(i, MIN(numberOfRow, views.count - i))];
        UIViewController *viewController = [self getViewControllerWithViewArray:subArray];
        [viewControllers addObject:viewController];
        i += numberOfRow;
    }
    return viewControllers;
}

- (UIViewController *) getViewControllerWithViewArray:(NSArray *)views {
    UIViewController *viewcontroller = [[UIViewController alloc] init];
    CGFloat calculatedHeight = 0;
    for (int i = 0; i < views.count; i++) {
        UIView *view = [views objectAtIndex:i];
        UIView *spacerLeft = [[UIView alloc] init];
        UIView *spacerRight = [[UIView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = false;
        spacerLeft.translatesAutoresizingMaskIntoConstraints = false;
        spacerRight.translatesAutoresizingMaskIntoConstraints = false;
        [viewcontroller.view addSubview:view];
        [viewcontroller.view addSubview:spacerRight];
        [viewcontroller.view addSubview:spacerLeft];
        NSString *viewKey = [NSString stringWithFormat:@"view%d", i];
        int verticalPading = i == 0 ? SPACING : ((i + 1) * SPACING) + i * buttonHeight;
        NSDictionary *metrics = @{
                                  @"vPading" : [NSNumber numberWithInt:verticalPading]
                                  };
        NSDictionary *views = @{viewKey : view,
                                @"spacerLeft" : spacerLeft,
                                @"spacerRight" : spacerRight};
        NSString *hcString = [NSString stringWithFormat:@"H:|-0-[spacerLeft(spacerRight)]-[%@]-[spacerRight]-0-|", viewKey];
        NSString *vcString = [NSString stringWithFormat:@"V:|-vPading-[%@]", viewKey];
        NSArray *horizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:hcString
                                                                                options:0
                                                                                metrics:metrics
                                                                                  views:views];
        NSArray *verticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:vcString
                                                                              options:0
                                                                              metrics:metrics
                                                                                views:views];
        [viewcontroller.view addConstraints: horizontalConstraint];
        [viewcontroller.view addConstraints:verticalConstraint];
        calculatedHeight = verticalPading + buttonHeight + SPACING + BOTTOM_MARGIN;
    }
    //we will consider only the maximum frameHeight
    if (calculatedHeight > frameHeight) {
        frameHeight = calculatedHeight;
    }
    return viewcontroller;
}

-(NSArray *) getArrayOfViewForButtonProperties:(NSArray *)buttonProperties {
    NSArray *buttonArrayFitToWidth = [self getButtonArrayFitToWidth:buttonProperties];
    NSMutableArray *viewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < buttonArrayFitToWidth.count; i++) {
        NSArray *buttons = [buttonArrayFitToWidth objectAtIndex:i];
        NSMutableDictionary *views = [[NSMutableDictionary alloc] init];
        UIView *baseView = [[UIView alloc] init];
        NSString *horizontalConstraintString = @"H:|-0-";
        NSString *verticalConstraintString = [NSString stringWithFormat:@"V:|-0-[button%d0]-0-|",i];
        for (int j = 0; j < buttons.count; j++) {
            XpdButton *button = [buttons objectAtIndex:j];
            button.translatesAutoresizingMaskIntoConstraints = false;
            [baseView addSubview:button];
            NSString *buttonString = [NSString stringWithFormat:@"button%d%d", i,j];
            [views setObject:button forKey:buttonString];
            if (j == buttons.count - 1) {
                horizontalConstraintString = [horizontalConstraintString stringByAppendingString:[NSString stringWithFormat:@"[%@]-0-|", buttonString]];
            } else {
                horizontalConstraintString = [horizontalConstraintString stringByAppendingString:[NSString stringWithFormat:@"[%@]-%d-", buttonString, SPACING]];
            }
        }
        NSArray *horizontalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:horizontalConstraintString
                                                                                options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                                metrics:nil
                                                                                  views:views];
        NSArray *verticalConstraint = [NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintString
                                                                              options:0
                                                                              metrics:nil
                                                                                views:views];
        [baseView addConstraints:horizontalConstraint];
        [baseView addConstraints:verticalConstraint];
        [viewArray addObject:baseView];
    }
    return viewArray;
}

- (NSArray *) getButtonArrayFitToWidth:(NSArray *) buttonProperties {
    NSMutableArray *buttonArray = [self getAllButtonForTitles:buttonProperties];
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; buttonArray.count > 0; i++) {
        NSMutableArray *row = [[NSMutableArray alloc] init];
        CGFloat width = 0;
        for(int j = 0; buttonArray.count > 0; j++) {
            XpdButton *firstButton = (XpdButton *)[buttonArray firstObject];
            width = width + firstButton.frame.size.width + j * SPACING;
            buttonHeight = firstButton.frame.size.height;
            if (width <= self.view.frame.size.width) {
                XpdButton *button = [buttonArray firstObject];
                [row addObject:button];
                [buttonArray removeObjectAtIndex:0];
            } else {
                break;
            }
        }
        row.count > 0 ? [resultArray addObject:row] : nil;
    }
    return resultArray;
}

- (NSMutableArray *) getAllButtonForTitles:(NSArray *) buttonProperties {
    NSMutableArray *buttonArray = [[NSMutableArray alloc] init];
    [buttonProperties enumerateObjectsUsingBlock:^(NSDictionary  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XpdButton *button = [[XpdButton alloc] init];
        [button setTitle:[self formatedTitle:[obj objectForKey:KEYBOARD_BUTTON_TITLE]] forState:UIControlStateNormal];
        button.buttonInfo = [obj objectForKey:KEYBOARD_BUTTON_INFO];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];

        UIColor *normalTitleColor;
        normalTitleColor = self.buttonTitleColor ? self.buttonTitleColor : DEFAULT_COLOR;
        [button setTitleColor:normalTitleColor forState:UIControlStateNormal];

        UIColor *highlightedTitleColor;
        highlightedTitleColor = self.buttonHighlightedTitleColor ? self.buttonHighlightedTitleColor : [UIColor redColor];
        [button setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];

        [button sizeToFit];
        [button.layer setBorderColor:(self.buttonBorderColor ? self.buttonBorderColor.CGColor : DEFAULT_COLOR.CGColor)];
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 3.0;
        [buttonArray addObject:button];
    }];
    return buttonArray;
}

- (NSString *) formatedTitle:(NSString *) titleString {
    return [NSString stringWithFormat:@" %@ ", titleString];
}

- (IBAction) buttonClicked:(XpdButton *)sender {
    [self.delegate buttonGetClicked:sender];
}

@end
