//
//  ViewController.m
//  HelloLisaClassWork
//
//  Created by JST Pro on 11/14/12.
//  Copyright (c) 2012 JST Pro. All rights reserved.
//

#import "ViewController.h"
#import "ViewControlleriPad.h"
#import "ViewControlleriPhone4.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize SliderOne;
@synthesize SliderTwo;
@synthesize SliderThree;
@synthesize SliderAlpha;
@synthesize txtFieldLeft;
@synthesize txtFieldRight;
@synthesize switchAuto;
@synthesize txtHex;
@synthesize lblB;
@synthesize lblG;
@synthesize lblR;

BOOL boolOn;
int incrementValue= 5;

NSString * hex;
NSString* redVal;
NSString* greenVal;
NSString* blueVal;

UIImageView *ipadBG ;

@synthesize viewColor;

- (void)viewDidLoad
{
 /////////////////////////iPad or iPhone?/////////////////////////////////////   
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        //iPad Non Retina
        NSLog(@"Call your iPad xib file");
       
        //load the correct xib, ViewControlleriPad.xib
        [[NSBundle mainBundle] loadNibNamed: @"ViewControlleriPad" owner: self options: nil];
       
        //Deal with rotation for iPad, programatically set it up
        ipadBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [ipadBG setImage:[UIImage imageNamed:@"WideiPad.jpg"]];
        [self.view addSubview:ipadBG];
        [self.view sendSubviewToBack: ipadBG];
        
    }
    else 
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        
        if(result.height == 480)
        {
            //iPhone 4
            NSLog(@"Call your iPhone 4 xib file");
            [[NSBundle mainBundle] loadNibNamed: @"ViewControlleriPhone4" owner: self options: nil];
        }
        
        if(result.height == 568)
        {
            // iPhone 5
             NSLog(@"Call your iPhone 5 xib file");
            [[NSBundle mainBundle] loadNibNamed: @"ViewController" owner: self options: nil];
        
       
        }
    }
/////////////////////////////////////////////////////////////////////////////////
   
    
    [super viewDidLoad];
   
    //set up timer
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];
    

    boolOn=YES;

    SliderOne.continuous = YES;
    [SliderOne setMinimumValue:0.0];
    [SliderOne setMaximumValue:255];
    
    SliderTwo.continuous = YES;
    [SliderTwo setMinimumValue:0.0];
    [SliderTwo setMaximumValue:255];
    
    SliderThree.continuous = YES;
    [SliderThree setMinimumValue:0.0];
    [SliderThree setMaximumValue:255];
    
    
    SliderAlpha.continuous = YES;
    [SliderAlpha setMinimumValue:20.0];
    [SliderAlpha setMaximumValue:100];
    [SliderAlpha setValue:100];
    
    // This makes the sliders call the -valueChanged: method when the user interacts with it.
    
    [SliderOne addTarget:self
               action:@selector(valueChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    [SliderTwo addTarget:self
                  action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    
    [SliderThree addTarget:self
                  action:@selector(valueChanged:)
        forControlEvents:UIControlEventValueChanged];
    
    
    [SliderAlpha addTarget:self
                    action:@selector(valueChanged:)
          forControlEvents:UIControlEventValueChanged];

         
    lblR.textColor= [UIColor redColor];
    lblG.textColor= [UIColor greenColor];
    lblB.textColor = [UIColor blueColor];

}
-(void)targetMethod:(NSTimer*)sender
{
   
//    if (boolOn==YES){
//    txtFieldLeft.text=@"Hello";
//    txtFieldRight.text=@"";
//        boolOn=NO;
//    }
//    else
//    {
//        txtFieldLeft.text=@"";
//        txtFieldRight.text=@"Lisa";
//        boolOn=YES;
//
//    }
    
   
    
    
///////////////////////////// Auto slider incrementation/////
    
    if (switchAuto.isOn)
    {
        NSLog(@"Audo Still on...\n");
        SliderOne.value=SliderOne.value+incrementValue;
        SliderTwo.value=SliderTwo.value+incrementValue;
        SliderThree.value=SliderThree.value+incrementValue;
        
        
        if (SliderOne.value==255)
        {
            SliderOne.value=0;
            SliderTwo.value=0;
            SliderThree.value=0;
        
        }
  
        [self valueChanged:nil];
       
    }
//////////////////////////////////////////////////////////   
}


- (void)valueChanged:(UISlider*)sender
{
    NSLog(@"\nSlider ONE: %f\nSlider TWO: %f\nSlider Three: %f", SliderOne.value , SliderTwo.value, SliderThree.value);
    
    //Set color of View
    [viewColor setBackgroundColor:[UIColor colorWithRed:SliderOne.value/255 green:SliderTwo.value/255 blue:SliderThree.value/255 alpha:SliderAlpha.value/100]];
    
    //Hex Conversion
    hex= [NSString stringWithFormat:@"#%02X%02X%02X", (int) SliderOne.value, (int) SliderTwo.value, (int) SliderThree.value];
    NSLog(@" HEX VALUE: %@", hex);
    txtHex.text=hex;
   
    //Set Hex Text same color
    txtHex.textColor =[UIColor colorWithRed:SliderOne.value/255 green:SliderTwo.value/255 blue:SliderThree.value/255 alpha:SliderAlpha.value/100];
    
    //Set RGB labels
   redVal = [NSString stringWithFormat:@"%.0f", SliderOne.value];
   greenVal = [NSString stringWithFormat:@"%.0f", SliderTwo.value];
   blueVal = [NSString stringWithFormat:@"%.0f", SliderThree.value];

    
    [lblR setText:redVal];
    [lblG setText:greenVal];
    [lblB setText:blueVal];
     
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchAction:(id)sender {
    if (switchAuto.on)
    {
        NSLog(@"AUTO MODE START...");
        SliderAlpha.value=100;
        SliderOne.value=0;
        SliderTwo.value=0;
        SliderThree.value=0;
    
    }
    
    
}
- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
         NSLog(@"Rotated:");
        ipadBG.frame=CGRectMake(0, 0, 1024, 768);
    }
    else
    {
      ipadBG.frame=CGRectMake(0, 0, 768, 1024);
    }
    
    
    
   
    
}
@end
