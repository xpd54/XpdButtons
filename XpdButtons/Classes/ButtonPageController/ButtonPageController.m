//
//  ButtonPageController.m
//  Button
//
//  Created by Ravi Prakash on 09/08/16.
//  Copyright © 2016 Ravi Prakash. All rights reserved.
//

#import "ButtonPageController.h"
@interface ButtonPageController ()
@property (nonatomic, strong) UIPageViewController *pageViewContrroller;
@property (nonatomic, strong) NSArray *buttonViewControllers;
@end

@implementation ButtonPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) loadView {
    [super loadView];
    self.buttonViewControllers = [[NSArray alloc] initWithArray:[self setupButtonViewControllers]];
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
    UIPageControl *pageControl = [UIPageControl appearanceWhenContainedInInstancesOfClasses:@[[ButtonPageController class]]];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    [self addChildViewController:self.pageViewContrroller];
    [self.view addSubview:self.pageViewContrroller.view];
    [self.pageViewContrroller didMoveToParentViewController:self];
}

- (NSArray *) setupButtonViewControllers {
    NSMutableArray *buttonViewControllers = [[NSMutableArray alloc] init];
    NSInteger propertiesCount = self.buttonProperties.count;
    NSInteger numberOfFullButtonVC = propertiesCount / 4;
    for (int i = 0; i <= numberOfFullButtonVC; i++) {
        NSArray *property = [NSArray arrayWithArray:[self.buttonProperties subarrayWithRange:NSMakeRange(4*i, MIN(4, propertiesCount))]];
        if (property.count > 0) {
            ButtonViewController *buttonVC = [[ButtonViewController alloc] init];
            buttonVC.delegate = self;
            buttonVC.buttonProperties = property;
            [buttonViewControllers addObject:buttonVC];
        }
        propertiesCount -= 4;
    }
    return buttonViewControllers;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger vcIndex = [self.buttonViewControllers indexOfObject:viewController];
    NSInteger previousVCIndex = vcIndex - 1;
    if (!(previousVCIndex >= 0)) {
        return (ButtonViewController *)self.buttonViewControllers.lastObject;
    }
    if (!(self.buttonViewControllers.count > previousVCIndex)) {
        return nil;
    }
    return (ButtonViewController *)[self.buttonViewControllers objectAtIndex:previousVCIndex];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger vcIndex = [self.buttonViewControllers indexOfObject:viewController];
    NSInteger nextVCIndex = vcIndex + 1;
    if (!(nextVCIndex < self.buttonViewControllers.count)) {
        return (ButtonViewController *)[self.buttonViewControllers objectAtIndex:0];
    }
    if (!(nextVCIndex > 0)) {
        return nil;
    }
    return (ButtonViewController *)[self.buttonViewControllers objectAtIndex:nextVCIndex];
}


-(NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.buttonViewControllers.count;
}

-(NSInteger) presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonGetClicked:(XpdButton *)button {
    [self.delegate buttonGetClicked:button];
}
@end
