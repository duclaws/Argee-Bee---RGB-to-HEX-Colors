//
//  ViewController.m
//  HelloLisaClassWork
//
//  Created by Joshua Sharfi on 11/14/12.
//  Copyright (c) 2012 JST Technology LLC. All rights reserved.
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
@synthesize txtR;
@synthesize txtG;
@synthesize txtB;
@synthesize txtAlpha;
@synthesize viewColor;
@synthesize txtAuto;

BOOL boolOn;
int incrementValue= 5;
float timeInterval = 1.0;

NSString * hex;
NSString * redVal;
NSString * greenVal;
NSString * blueVal;

UIImageView *ipadBG ;
CGSize device;

CGRect s1;
CGRect s2;
CGRect s3;
CGRect s4;

CGRect s1lbl;
CGRect s2lbl;
CGRect s3lbl;

CGRect s1txt;
CGRect s2txt;
CGRect s3txt;
CGRect s4txt;

CGRect sw;
CGRect swtxt;

CGRect viewBox;

NSMutableArray *saveColors;


- (void)viewDidLoad
{
    saveColors = [[NSUserDefaults standardUserDefaults] objectForKey:@"hexColors"];
    
    if (!saveColors)
        saveColors = [[NSMutableArray alloc] init];
    
    NSLog(@" THESE ARE THE SAVED COLORS: %@\n", saveColors);
    
     /////////////////////////iPad or iPhone?/////////////////////////////////////
    device = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        //iPad Non Retina
        NSLog(@"Call your iPad xib file");
       
        //load the correct xib, ViewControlleriPad.xib
        [[NSBundle mainBundle] loadNibNamed: @"ViewControlleriPad" owner: self options: nil];
        
        //load backround image programatically
        ipadBG = [[UIImageView alloc] init];
        
        //Deal with rotation for iPad, set the inital backround to the right orientation
        if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) ||
            ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight))
        
        {
            //set up your landscape view here
            ipadBG.frame=CGRectMake(0, 0, 1024, 768);
        }
        
        else
        
        {
            //set up your portrait view here
            ipadBG.frame=CGRectMake(0, 0, 768, 1024);
        }
        
        
        //now that we allocated memory and the frame for the image, instruct it to use this image
        [ipadBG setImage:[UIImage imageNamed:@"WideiPad.jpg"]];
        
        
        [self.view addSubview:ipadBG];
        
        //put image in the back since its a backround
        [self.view sendSubviewToBack: ipadBG];
        
        
    }
   
    else
    //must be an iphone/ipod touch
    
    {
        
        
        if(device.height == 480)
        
        {
            //iPhone 4
            NSLog(@"Call your iPhone 4 xib file");
            [[NSBundle mainBundle] loadNibNamed: @"ViewControlleriPhone4" owner: self options: nil];
            
            s1 = SliderOne.frame;
            s2 = SliderTwo.frame;
            s3 = SliderThree.frame;
            s4 = SliderAlpha.frame;
            
            s1lbl = lblR.frame;
            s2lbl = lblG.frame;
            s3lbl = lblB.frame;
            
            s1txt = txtR.frame;
            s2txt = txtG.frame;
            s3txt = txtB.frame;
            s4txt = txtAlpha.frame;
            
            sw = switchAuto.frame;
            swtxt = txtAuto.frame;
            viewBox = viewColor.frame;
        }
        
        if(device.height == 568)
      
        {
            // iPhone 5
             NSLog(@"Call your iPhone 5 xib file");
            [[NSBundle mainBundle] loadNibNamed: @"ViewController" owner: self options: nil];
        }
    }
////////////////////////////////////////////////////////////////////////////////////


    [super viewDidLoad];
   
    //set up timer for the auto-increment feature
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];

    boolOn=YES;
    
    //set up 4 sliders...
    SliderOne.continuous = YES;
    [SliderOne setMinimumValue:0.0];
    [SliderOne setMaximumValue:255];
   // [SliderOne setThumbTintColor:[UIColor redColor]];
    
    SliderTwo.continuous = YES;
    [SliderTwo setMinimumValue:0.0];
    [SliderTwo setMaximumValue:255];
   // [SliderTwo setThumbTintColor:[UIColor greenColor]];
    
    SliderThree.continuous = YES;
    [SliderThree setMinimumValue:0.0];
    [SliderThree setMaximumValue:255];
    //[SliderThree setThumbTintColor:[UIColor blueColor]];
    
    SliderAlpha.continuous = YES;
    [SliderAlpha setMinimumValue:20.0];
    [SliderAlpha setMaximumValue:100];
    [SliderAlpha setValue:100];
    
    ////This makes the sliders call the valueChanged method anytime the value has changed/////
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


    //little 0-255 labels onright of sliders
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
    
   
    
    
/////////////////////////////Auto slider incrementation//////////////
    
    if (switchAuto.isOn)
    {
        NSLog(@"Audo Still on...\n");
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        //increment value is defined above
        SliderOne.value=SliderOne.value+incrementValue;
        SliderTwo.value=SliderTwo.value+incrementValue;
        SliderThree.value=SliderThree.value+incrementValue;
        
        [UIView commitAnimations];
        
        //looping
        if (SliderOne.value==255)
        {
            SliderOne.value=0;
            SliderTwo.value=0;
            SliderThree.value=0;
        
        }
        //manually call the valueChanged method (below)
        [self valueChanged:nil];
       
    }
/////////////////////////////////////////////////////////////////////  
}


- (void)valueChanged:(UISlider*)sender
{

    NSLog(@"\nRed: %.0f\nGreen: %.0f\nBlue: %.0f\n", SliderOne.value , SliderTwo.value, SliderThree.value);
    
    //Set color of View
    [viewColor setBackgroundColor:[UIColor colorWithRed:SliderOne.value/255 green:SliderTwo.value/255 blue:SliderThree.value/255 alpha:SliderAlpha.value/100]];
    
    //Hex Conversion
    hex= [NSString stringWithFormat:@"#%02X%02X%02X", (int) SliderOne.value, (int) SliderTwo.value, (int) SliderThree.value];
    NSLog(@"\nHEX VALUE: %@", hex);
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
    
}


- (IBAction)switchAction:(id)sender {
    
    //initialize auto-increment feature
    if (switchAuto.on)
    
    {
        NSLog(@"AUTO MODE START...");
        SliderAlpha.value=100;
        SliderOne.value=0;
        SliderTwo.value=0;
        SliderThree.value=0;
    
    }
    
}

//////Deal with iPad Rotation of backround image////lame, i know./////////
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
   
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    
    {
         NSLog(@"Rotate Wide");
        ipadBG.frame=CGRectMake(0, 0, 1024, 768);
        
        //move the iphone 4 sliders when rotating.
        //starting to think multiple .m files should have been used here.
       
        if(device.height == 480)
        {
            viewColor.frame = CGRectMake(10, 10, 280, 150);
            
            txtR.frame = CGRectMake(10, 178, 20, 20);
            lblR.frame = CGRectMake(240, 178, 30, 20);
            SliderOne.frame = CGRectMake(30, 180, 200, 20);
            
            txtG.frame = CGRectMake(10, 218, 20, 20);
            lblG.frame = CGRectMake(240, 218, 30, 20);
            SliderTwo.frame = CGRectMake(30, 220, 200, 20);
            
            txtB.frame = CGRectMake(10, 258, 20, 20);
            lblB.frame = CGRectMake(240, 258, 30, 20);
            SliderThree.frame = CGRectMake(30, 260, 200, 20);
            
            txtAlpha.frame = CGRectMake(280, 178, 70, 20);
            SliderAlpha.frame = CGRectMake(320, 180, 100, 20);
            
            switchAuto.frame = CGRectMake(330, 220, 70, 70);
            txtAuto.frame = CGRectMake(290, 218, 70, 30);
            
            
            
            
        }
        
        
    }
    
    else
    
    {
        NSLog(@"Rotate Portrait");
        ipadBG.frame=CGRectMake(0, 0, 768, 1024);
        
        if (device.height == 480)
        {
        
            
            txtR.frame = s1txt;
            lblR.frame = s1lbl;
            SliderOne.frame = s1;
           
            txtG.frame = s2txt;
            lblG.frame = s2lbl;
            SliderTwo.frame = s2;
            
            txtB.frame = s3txt;
            lblB.frame = s3lbl;
            SliderThree.frame = s3;
            
            txtAlpha.frame = s4txt;
            SliderAlpha.frame = s4;
            
            switchAuto.frame = sw;
            txtAuto.frame = swtxt;
            
            viewColor.frame = viewBox;
        
        }
    }
    
}
- (IBAction)btnSave:(id)sender {
    [saveColors addObject:@{
        @"r" : [NSNumber numberWithFloat:SliderOne.value / 255],
        @"g" : [NSNumber numberWithFloat:SliderTwo.value / 255],
        @"b" : [NSNumber numberWithFloat:SliderThree.value / 255],
        @"a" : [NSNumber numberWithFloat:SliderAlpha.value / 100]}];
    
    [[NSUserDefaults standardUserDefaults] setObject:saveColors forKey:@"hexColors"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(NSString*) saveFilePath

{

    NSString* path = [NSString stringWithFormat:@"%@%@",
                      [[NSBundle mainBundle] resourcePath],
                      @"savedColors.plist"];
    return path;

}


@end
