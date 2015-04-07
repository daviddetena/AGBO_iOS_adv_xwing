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
    
    // Creamos detector de Tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    // Lo añadimos
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

-(void) didTap:(UITapGestureRecognizer *)tap{
    
    // El BeginFromCurrentState lo hace por defecto. Lo ponemos explícitamente
    UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut;
    
    // Animación de traslación (cambio de posición)
    [UIView animateWithDuration:1
                          delay:0
                        options:options
                     animations:^{
                         //Estado final. Centro del xwing en el space view
                         self.xwingView.center = [tap locationInView:self.spaceView];
                     } completion:
     ^(BOOL finished) {
         // Finished indica si ha llegado al final de la animación con éxito, ya que
         // puede ser interrumpida por el usuario y en ese caso iniciar otra animación
         // Esto de aquí no se anima. En este caso no hacemos nada
     }];

    // Rotación
    [UIView animateWithDuration:0.5
                          delay:0
                        options:0
                     animations:^{
                         self.xwingView.transform = CGAffineTransformMakeRotation(M_2_PI);
                     } completion:^(BOOL finished) {
                         // Al terminar hago otra de 0.5seg que acabe en el ángulo inicial
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

@end
