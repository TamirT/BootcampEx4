//
//  SetTriangle.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetTriangle.h"

@implementation SetTriangle

-(UIBezierPath *)drawPath:(CGRect)frame{

  UIBezierPath* trianglePath = [UIBezierPath bezierPath];
  [trianglePath moveToPoint:CGPointMake(0, 0)];
  [trianglePath addLineToPoint:CGPointMake(frame.size.width, frame.size.height / 2)];
  [trianglePath addLineToPoint:CGPointMake(0, frame.size.height)];
  [trianglePath closePath];

  return trianglePath;

}

@end
