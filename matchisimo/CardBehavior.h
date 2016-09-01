//
//  CardBehavior.h
//  matchisimo
//
//  Created by Tamir Tiomkin on 30/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardBehavior : UIDynamicBehavior

-(void)addItem:(id <UIDynamicItem>)item;
-(void)removeItem:(id <UIDynamicItem>)item;

@end
