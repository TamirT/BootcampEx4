//
//  SetColor.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetColor.h"
#import <UIKit/UIKit.h>

@implementation SetColor

+ (UIColor *)getUIColor:(NSString *)colorOption{

  if([colorOption isEqualToString:@"red"]) return [UIColor redColor];
  if([colorOption isEqualToString:@"blue"]) return [UIColor blueColor];
  if([colorOption isEqualToString:@"green"]) return [UIColor greenColor];

  return [UIColor redColor];
  
}

@end
