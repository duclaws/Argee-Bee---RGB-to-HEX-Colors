//
//  ViewController.h
//  HelloLisaClassWork
//
//  Created by JST Pro on 11/14/12.
//  Copyright (c) 2012 JST Pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *txtFieldLeft;
@property (strong, nonatomic) IBOutlet UILabel *txtFieldRight;
@property (strong, nonatomic) IBOutlet UISlider *SliderOne;
@property (strong, nonatomic) IBOutlet UISlider *SliderTwo;
@property (strong, nonatomic) IBOutlet UISlider *SliderThree;
@property (strong, nonatomic) IBOutlet UIView *viewColor;
@property (strong, nonatomic) IBOutlet UISlider *SliderAlpha;
@property (strong, nonatomic) IBOutlet UISwitch *switchAuto;
- (IBAction)switchAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *txtHex;
@property (strong, nonatomic) IBOutlet UILabel *lblR;
@property (strong, nonatomic) IBOutlet UILabel *lblG;
@property (strong, nonatomic) IBOutlet UILabel *lblB;

@end
