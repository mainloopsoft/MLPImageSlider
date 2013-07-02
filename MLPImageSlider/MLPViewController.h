//
//  MLPViewController.h
//  MLPImageSlider
//
//  Created by Javier Figueroa on 4/25/13.
//  Copyright (c) 2013 Mainloop LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLPImageViewSlider.h"

@interface MLPViewController : UIViewController<MLPImageViewSliderDelegate>

@property (weak, nonatomic) IBOutlet MLPImageViewSlider *slider;
@property (weak, nonatomic) IBOutlet MLPImageViewSlider *slider2;
@property (weak, nonatomic) IBOutlet MLPImageViewSlider *slider3;
@property (weak, nonatomic) IBOutlet MLPImageViewSlider *slider4;

@end
