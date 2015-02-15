//
//  ViewController.m
//  JogoDaVelha
//
//  Created by Felipe Florencio Garcia on 2/13/15.
//  Copyright (c) 2015 Felipe Florencio Garcia. All rights reserved.
//

#import "ViewController.h"

#define RAND_FROM_TO (1 + arc4random_uniform(9 - 1 + 1))
#define TYPE_PLAY @"X" : @"0"
#define PLAYER @"X"
#define MACHINE @"0"


@interface ViewController () {
    int countFirst;
    int countSecond;
    int countThird;
}

@property (strong, nonatomic) IBOutlet UIImageView *touchField1;
@property (strong, nonatomic) IBOutlet UILabel *lblField1;
@property (strong, nonatomic) IBOutlet UIImageView *touchField2;
@property (strong, nonatomic) IBOutlet UILabel *lblField2;
@property (strong, nonatomic) IBOutlet UIImageView *touchField3;
@property (strong, nonatomic) IBOutlet UILabel *lblField3;

@property (strong, nonatomic) IBOutlet UIImageView *touchField4;
@property (strong, nonatomic) IBOutlet UILabel *lblField4;
@property (strong, nonatomic) IBOutlet UIImageView *touchField5;
@property (strong, nonatomic) IBOutlet UILabel *lblField5;
@property (strong, nonatomic) IBOutlet UIImageView *touchField6;
@property (strong, nonatomic) IBOutlet UILabel *lblField6;

@property (strong, nonatomic) IBOutlet UIImageView *touchField7;
@property (strong, nonatomic) IBOutlet UILabel *lblField7;
@property (strong, nonatomic) IBOutlet UIImageView *touchField8;
@property (strong, nonatomic) IBOutlet UILabel *lblField8;
@property (strong, nonatomic) IBOutlet UIImageView *touchField9;
@property (strong, nonatomic) IBOutlet UILabel *lblField9;

@property (strong, nonatomic) NSMutableArray *placesTapped;
@property (assign, nonatomic) BOOL alreadyAdded;
@property (assign, nonatomic) int COUNT;

@property (strong, nonatomic) NSMutableArray *arrayFirstLine;
@property (strong, nonatomic) NSMutableArray *arraySecondLine;
@property (strong, nonatomic) NSMutableArray *arrayThirdLine;
@property (strong, nonatomic) NSArray *fieldMatrix;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tapGestureConfig];
    
    _placesTapped = [[NSMutableArray alloc] initWithCapacity:8];
    
    _fieldMatrix = @[[@[@"",@"",@""] mutableCopy],[@[@"",@"",@""] mutableCopy],[@[@"",@"",@""] mutableCopy]];
    
    _arrayFirstLine = [[NSMutableArray alloc] init];
    _arraySecondLine = [[NSMutableArray alloc] init];
    _arrayThirdLine = [[NSMutableArray alloc] init];
    
    _COUNT = 0;
    
    countFirst = 0;
    countSecond = 0;
    countThird = 0;

}

- (void)tapGestureConfig{
    
    UITapGestureRecognizer* gestureRecognizer1 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer1.delegate = self;
    [_touchField1 addGestureRecognizer:gestureRecognizer1];
    
    UITapGestureRecognizer* gestureRecognizer2 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer2.delegate = self;
    [_touchField2 addGestureRecognizer:gestureRecognizer2];
    
    UITapGestureRecognizer* gestureRecognizer3 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer3.delegate = self;
    [_touchField3 addGestureRecognizer:gestureRecognizer3];
    
    UITapGestureRecognizer* gestureRecognizer4 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer4.delegate = self;
    [_touchField4 addGestureRecognizer:gestureRecognizer4];
    
    UITapGestureRecognizer* gestureRecognizer5 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer5.delegate = self;
    [_touchField5 addGestureRecognizer:gestureRecognizer5];
    
    UITapGestureRecognizer* gestureRecognizer6 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer6.delegate = self;
    [_touchField6 addGestureRecognizer:gestureRecognizer6];
    
    UITapGestureRecognizer* gestureRecognizer7 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer7.delegate = self;
    [_touchField7 addGestureRecognizer:gestureRecognizer7];

    UITapGestureRecognizer* gestureRecognizer8 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer8.delegate = self;
    [_touchField8 addGestureRecognizer:gestureRecognizer8];
    
    UITapGestureRecognizer* gestureRecognizer9 = [[UITapGestureRecognizer alloc] init];
    gestureRecognizer9.delegate = self;
    [_touchField9 addGestureRecognizer:gestureRecognizer9];
    
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    [self addTouchToArray:[NSNumber numberWithInteger:gestureRecognizer.view.tag]];
    
    return YES;
}


- (void)addTouchToArray:(NSNumber*)typed{
    
    _alreadyAdded = NO;
    
    if (_placesTapped.count == 0) {
        [_placesTapped addObject:typed];
        _COUNT += 1;
        [self markPlaceTapped:typed isUser:YES];

        [self addMachinePlay:typed];
    } else {
    
        for (NSNumber *number in [_placesTapped mutableCopy]) {
            if (typed != number && !_alreadyAdded) {
                _COUNT += 1;
                [_placesTapped addObject:typed];

                [self markPlaceTapped:typed isUser:YES];
                
                if (_COUNT < 5)
                    [self addMachinePlay:typed];
                else
                    _alreadyAdded = YES;
            }
        }
    }
    
}


- (void)addMachinePlay:(NSNumber*)typed{
    NSNumber *randomValue;

    
    if (!_alreadyAdded){
        do {
            randomValue = [NSNumber numberWithUnsignedInteger:RAND_FROM_TO];
        } while (randomValue == typed || [self returnRandomNumber:randomValue]);

        [_placesTapped addObject:randomValue];
        [self markPlaceTapped:randomValue isUser:NO];

        _alreadyAdded = YES;
    }

}

-(BOOL)returnRandomNumber:(NSNumber*)randomValue{
    
    for (NSNumber *numb in _placesTapped) {
        if (randomValue == numb)
            return YES;
    }
    return NO;
}


- (void)markPlaceTapped:(NSNumber*)number isUser:(BOOL)player{
    
    switch (number.integerValue) {
        case 1:{
            if (_lblField1.text.length <= 0)
                _lblField1.text = player ? TYPE_PLAY;
                [_fieldMatrix[0] replaceObjectAtIndex:0  withObject:_lblField1.text];
            break;
        }
        case 2:{
            if (_lblField2.text.length <= 0)
                _lblField2.text = player ? TYPE_PLAY;
                [_fieldMatrix[0] replaceObjectAtIndex:1  withObject:_lblField2.text];
            break;
        }
        case 3:{
            if (_lblField3.text.length <= 0)
                _lblField3.text = player ? TYPE_PLAY;
                [_fieldMatrix[0] replaceObjectAtIndex:2  withObject:_lblField3.text];
            break;
        }
        case 4:{
            if (_lblField4.text.length <= 0)
                _lblField4.text = player ? TYPE_PLAY;
                [_fieldMatrix[1] replaceObjectAtIndex:0  withObject:_lblField4.text];
            break;
        }
        case 5:{
            if (_lblField5.text.length <= 0)
                _lblField5.text = player ? TYPE_PLAY;
                [_fieldMatrix[1] replaceObjectAtIndex:1  withObject:_lblField5.text];
            break;
        }
        case 6:{
            if (_lblField6.text.length <= 0)
                _lblField6.text = player ? TYPE_PLAY;
                [_fieldMatrix[1] replaceObjectAtIndex:2  withObject:_lblField6.text];
            break;
        }
        case 7:{
            if (_lblField7.text.length <= 0)
                _lblField7.text = player ? TYPE_PLAY;
                [_fieldMatrix[2] replaceObjectAtIndex:0  withObject:_lblField7.text];
            break;
        }
        case 8:{
            if (_lblField8.text.length <= 0)
                _lblField8.text = player ? TYPE_PLAY;
                [_fieldMatrix[2] replaceObjectAtIndex:1  withObject:_lblField8.text];
            break;
        }
        case 9:{
            if (_lblField9.text.length <= 0)
                _lblField9.text = player ? TYPE_PLAY;
                [_fieldMatrix[2] replaceObjectAtIndex:2  withObject:_lblField9.text];
            break;
        }
        default:
            break;
    }
    for (NSArray *num in _fieldMatrix) {
        NSLog(@"os valores são %@", num);
    }

    [self validateIfWin];
}


- (void)validateIfWin{
    
    int i = 0;
    for (NSArray *array in _fieldMatrix) {
        if ([[array objectAtIndex:0] isEqualToString:PLAYER] &&
            [[array objectAtIndex:1] isEqualToString:PLAYER] &&
            [[array objectAtIndex:2] isEqualToString:PLAYER]){
            [self alertMessage:PLAYER];
        } else if ([[array objectAtIndex:0] isEqualToString:MACHINE] &&
                   [[array objectAtIndex:1] isEqualToString:MACHINE] &&
                   [[array objectAtIndex:2] isEqualToString:MACHINE]){
            [self alertMessage:MACHINE];
        }
        
        if ([[_fieldMatrix[0] objectAtIndex:i] isEqualToString:PLAYER] &&
            [[_fieldMatrix[1] objectAtIndex:i] isEqualToString:PLAYER] &&
            [[_fieldMatrix[2] objectAtIndex:i] isEqualToString:PLAYER]){
            [self alertMessage:PLAYER];
        } else if ([[_fieldMatrix[0] objectAtIndex:i] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[1] objectAtIndex:i] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[2] objectAtIndex:i] isEqualToString:MACHINE]){
            [self alertMessage:MACHINE];
        }
        i += 1;
        
        if ([[_fieldMatrix[0] objectAtIndex:0] isEqualToString:PLAYER] &&
            [[_fieldMatrix[1] objectAtIndex:1] isEqualToString:PLAYER] &&
            [[_fieldMatrix[2] objectAtIndex:2] isEqualToString:PLAYER]){
            [self alertMessage:PLAYER];
        } else if ([[_fieldMatrix[0] objectAtIndex:0] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[1] objectAtIndex:1] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[2] objectAtIndex:2] isEqualToString:MACHINE]){
            [self alertMessage:MACHINE];
        }
        
        if ([[_fieldMatrix[0] objectAtIndex:2] isEqualToString:PLAYER] &&
            [[_fieldMatrix[1] objectAtIndex:1] isEqualToString:PLAYER] &&
            [[_fieldMatrix[2] objectAtIndex:0] isEqualToString:PLAYER]){
            [self alertMessage:PLAYER];
        } else if ([[_fieldMatrix[0] objectAtIndex:2] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[1] objectAtIndex:1] isEqualToString:MACHINE] &&
                   [[_fieldMatrix[2] objectAtIndex:0] isEqualToString:MACHINE]){
            [self alertMessage:MACHINE];
        }
    }
    
}


- (void)alertMessage:(NSString*)type{
    
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.message = [type isEqualToString:PLAYER] ? @"Você ganhou" : @"Você perdeu";
    
    [alert show];
}


@end
