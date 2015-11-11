//
//  LogoAnimView.m
//  IntroAnimGetStocks
//
//  Created by Matan Cohen on 7/1/15.
//  Copyright (c) 2015 Matan Cohen. All rights reserved.
//

#import "LogoAnimView.h"
#import "RoundImageView.h"


@interface LogoAnimView () {
    float _duration;
}

@property (nonatomic, strong) NSMutableArray *roundings;
@end
@implementation LogoAnimView

-(void) draw {
    
    self.roundings = [NSMutableArray array];
    
    int numberOfVerticalLines = 10;
    int spacesSapceAmountComperedToRounders = 3.71;
    int numberOfRoundsHorizontal = 13;
    int numberOfSpacingHorizontal = 12;
    float roundWidth = self.frame.size.width / (numberOfRoundsHorizontal + spacesSapceAmountComperedToRounders);
    float spcingWidth = (self.frame.size.width - (roundWidth * 13)) / numberOfSpacingHorizontal;
    
    //Vertibal
    float yPoint = 0;
      for (int y = 0 ; y < numberOfVerticalLines ; y++ ) {
        
          //Draw horizontal:
          float lastX = 0;
          for (int x = 0 ; x < numberOfRoundsHorizontal ; x++ ) {
              RoundImageView *imageRound = [[RoundImageView alloc] initWithImage:[UIImage imageNamed:@"Rounding"]];
              [self addSubview:imageRound];
              [imageRound setFrame:CGRectMake(spcingWidth + lastX + roundWidth , yPoint, roundWidth, roundWidth)];
              if (x == 0) {
                  [imageRound setFrame:CGRectMake(0, yPoint, roundWidth, roundWidth)];
              }
              lastX = imageRound.frame.origin.x;
              
              
              imageRound.originalXPoint = imageRound.frame.origin.x;
              imageRound.originalYPoint = imageRound.frame.origin.y;
              imageRound.originalWidth = imageRound.frame.size.width;
              
              if ([self isArrowMark:y yPoint:x] == YES) {
                  [imageRound removeFromSuperview];
              } else {
                  [self.roundings addObject:imageRound];
              }
          }
          
          
          yPoint += spcingWidth + roundWidth;
      }
}

-(BOOL) isArrowMark: (int) xPoint
             yPoint: (int) yPoint {
    if (yPoint == 6 && xPoint == 4) {
        return YES;
    }
    if (yPoint == 7 && xPoint == 3) {
        return YES;
    }

    if (yPoint == 8 && xPoint == 2) {
        return YES;
    }

    if (yPoint == 9 && xPoint == 3) {
        return YES;
    }

    if (yPoint == 10 && xPoint == 4) {
        return YES;
    }
    return NO;
}


-(void) animateWithDuration:(float) duration {
    _duration = duration;

    for (RoundImageView *imageRound in self.roundings) {
        
            [UIView animateWithDuration:duration * 0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
            float farYPoint = imageRound.originalYPoint + [self randomNumber];
            float farXPoint = imageRound.originalXPoint + [self randomNumber];
            
            
            [imageRound setFrame:CGRectMake(farXPoint, farYPoint, imageRound.originalWidth, imageRound.originalWidth)];
        } completion:nil];
    }

    
    for (RoundImageView *imageRound in self.roundings) {
        
        [UIView animateWithDuration:duration * 0.6 delay:duration * 0.4 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [imageRound setFrame:CGRectMake(imageRound.originalXPoint, imageRound.originalYPoint, imageRound.originalWidth, imageRound.originalWidth)];
        } completion:^(BOOL finished) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.2 animations:^{
                                self.alpha = 0;
                }];
            });
        }];
        
        
    }

}

-(float) randomNumber {
    int rndValue = -300 + arc4random() % (300 - -300);
    
    if (rndValue > 0) {
        
        int lowerBound = -80;
        int upperBound = -10;
        rndValue = lowerBound + arc4random() % (upperBound - lowerBound);

    } else {

        int lowerBound = 10;
        int upperBound = 80;

        rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
        
    }
    
    return rndValue;
}

@end
