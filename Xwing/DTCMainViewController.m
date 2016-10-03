//
//  DTCMainViewController.m
//  Xwing
//
//  Created by David de Tena on 06/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCMainViewController.h"

@interface DTCMainViewController ()

@end

@implementation DTCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Create Tap recognizer
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    // Create Swipe recognizer
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    
    // Add them to the current view
    [self.view addGestureRecognizer:tap];
    [self.view addGestureRecognizer:swipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Recognizers
-(void) didTap:(UITapGestureRecognizer *)tap{
    
    // Set the options desired for the animation
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut;
    
    // Set the animation desired: in this case, we want a traslation (move from A to B)
    [UIView animateWithDuration:1
                          delay:0
                        options:options
                     animations:^{
                         //Estado final. Centro del xwing en el space view
                         self.xwingView.center = [tap locationInView:self.spaceView];
                     } completion:
     ^(BOOL finished) {
         // Finished tells if the animation has finished successfully,
         // since it might be interrupted by the user and hence start another animation.
         // We do nothing in this case
     }];

    // Rotate the X-wing PI/2 for a 0.5s animation and then
    [UIView animateWithDuration:0.5
                          delay:0
                        options:0
                     animations:^{
                         self.xwingView.transform = CGAffineTransformMakeRotation(M_2_PI);
                     } completion:^(BOOL finished) {
                         // Turn back to its initial point in an 0.5s animation
                         [UIView animateWithDuration:0.5
                                               delay:0
                                             options:0
                                          animations:^{
                                              self.xwingView.transform = CGAffineTransformIdentity;
                                          } completion:^(BOOL finished) {
                                              //
                                          }];
                     }];
}

- (void) didSwipe:(UISwipeGestureRecognizer *) swipe{

    // Grab view bounds
    CGSize viewSize = self.view.bounds.size;
    
    // Generate random numbers from (0, view_width-10) and (0, view_height-10)
    int randomX = (arc4random() % ((int)viewSize.width)-10);
    int randomY = (arc4random() % ((int)viewSize.height)-10);
    
    // Create CGFloat with previuos values and create the new point
    CGFloat ranX = (float)randomX;
    CGFloat ranY = (float)randomY;
    CGPoint newPoint = CGPointMake(ranX,ranY);
    
    if (swipe.state == UIGestureRecognizerStateRecognized) {
        // Perform animation for changing the opacity to make X-Wing disappear
        UIViewAnimationOptions optionsXwing = 0;
        [UIView animateWithDuration:1
                              delay:0
                            options:optionsXwing
                         animations:^{
                             // alpha=0 => X-Wing disappear
                             self.xwingView.alpha = 0;
                         } completion:^(BOOL finished) {
                             // Move X-Wing to new point when animation finished
                             self.xwingView.center = newPoint;
                             
                             // We want the X-Wing to re-appear after 1s => alpha=1
                             [UIView animateWithDuration:1
                                                   delay:1
                                                 options:0
                                              animations:^{
                                                  self.xwingView.alpha = 1;
                                              } completion:^(BOOL finished) {
                                                  //
                                              }];
                         }];
    }
}

@end
