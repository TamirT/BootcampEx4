//
//  SetRect.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetRect.h"

@implementation SetRect


-(UIBezierPath *)drawPath:(CGRect)frame{

  frame.size.height = frame.size.height / 2;
  frame.size.width = frame.size.width / 2;
  frame.origin.x = frame.size.width / 2;
  frame.origin.y = frame.size.height / 2;;
  return [UIBezierPath bezierPathWithRect:frame];

}

@end
