//
//  ViewController.m
//  ex2
//
//  Created by Tamir Tiomkin on 23/08/2016.
//  Copyright © 2016 Lightricks. All rights reserved.
//

#import "ViewController.h"
#import "Model/Deck.h"

@interface ViewController ()
@end



@implementation ViewController


- (Deck *) createDeck{
    return nil;
}

- (Deck *) deck{
    if(!_deck){
     _deck = [self createDeck];   
    }
    return _deck;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
