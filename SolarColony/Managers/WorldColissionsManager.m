//
//  WorldColissionsManager.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "WorldColissionsManager.h"


@implementation WorldColissionsManager
@synthesize soldiers;
@synthesize towers;

- (id)init
{
    self = [super init];
    if (self) {
        towers= [[NSMutableArray alloc] init];
        soldiers= [[NSMutableArray alloc] init];
        
        
    }
    return self;
}

-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;
    for (TowerBasic* tower in towers) {
        towerpoint=[tower getLocation];
        //need add is attacking
        for (NSValue* soldier in soldiers) {
           
            //[yourCGPointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(100, 10
          
            soldierpoint = soldier.CGPointValue;
            
            if ( (towerpoint.x>=soldierpoint.x-10||towerpoint.x<=soldierpoint.x+10)&&(towerpoint.y>=soldierpoint.y-10||towerpoint.y<=soldierpoint.y+10)) {
                //reduce energy in soldier
                
                //animate attack from soldier
                
                //animate attack from tower
                [tower attackTest:soldierpoint];
            //animates deaths is possible
            }
            
        }
        // do stuff
    }
}
-(void) makeTowerSoldierFight:(TowerBasic*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerBasic*) tower :(CGPoint) soldier{
    
}

-(void)addSoldier:(Soldier*)soldier{
    
}
-(void)addTower:(TowerBasic*)tower{
    
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerBasic*)tower{
    
}


@end
