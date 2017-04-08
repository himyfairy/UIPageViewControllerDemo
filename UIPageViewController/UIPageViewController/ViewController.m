//
//  ViewController.m
//  UIPageViewController
//
//  Created by 戚璐 on 2017/4/8.
//  Copyright © 2017年 戚璐. All rights reserved.
//

#import "ViewController.h"
#import "QLWelcomeViewController.h"

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, strong) NSMutableArray *welcomeVCArray;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ViewController
#pragma mark - lazy
- (NSMutableArray *)welcomeVCArray {
    if (!_welcomeVCArray) {
        _welcomeVCArray = [NSMutableArray array];
        for (NSInteger i = 1; i < 6; i++) {
            QLWelcomeViewController *welVC = [[QLWelcomeViewController alloc] init];
            welVC.text = [NSString stringWithFormat:@"This is page %zd", i];
            welVC.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
            [_welcomeVCArray addObject:welVC];
        }
    }
    return _welcomeVCArray;
}

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //pageVC
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self.pageVC setViewControllers:@[self.welcomeVCArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    //pageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 30)];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<QLWelcomeViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    QLWelcomeViewController *welVC = self.pageVC.viewControllers.firstObject;
    self.pageControl.currentPage = [self.welcomeVCArray indexOfObject:welVC];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.welcomeVCArray indexOfObject:viewController];
    if (index == 0) {
        return self.welcomeVCArray.lastObject;
    }
    return self.welcomeVCArray[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.welcomeVCArray indexOfObject:viewController];
    if (index == self.welcomeVCArray.count - 1) {
        return self.welcomeVCArray.firstObject;
    }
    return self.welcomeVCArray[index + 1];
}
@end
