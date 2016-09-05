//
//  SetCircle.m
//  matchisimo
//
//  Created by Tamir Tiomkin on 05/09/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "SetCircle.h"

@implementation SetCircle

-(UIBezierPath *)drawPath:(CGRect)frame{

  CGFloat radius = frame.size.width / 3;
  CGFloat startAngle = 0;
  CGFloat endAngle = 6.30;

  return [UIBezierPath
          bezierPathWithArcCenter:CGPointMake(frame.size.width / 2, frame.size.height / 2)
                                        radius:radius
                                    startAngle:startAngle
                                      endAngle:endAngle
                                     clockwise:NO];

}

@end
