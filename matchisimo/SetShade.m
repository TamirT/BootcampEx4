//
//  SetShade.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetShade.h"
#import <UIKit/UIKit.h>

@implementation SetShade

- (UIColor *)getShade:(NSString *)shadeOption{

  if([shadeOption isEqualToString:@"shade_one"]){
    return [UIColor redColor];
  } else if ([shadeOption isEqualToString:@"shade_two"]) {
    return [UIColor blueColor];
  } else {
    return [UIColor greenColor];
  }

}

@end
