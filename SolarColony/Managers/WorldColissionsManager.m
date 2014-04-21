//
//  WorldColissionsManager.m
//  SolarColony
//
//  Created by Student on 2/12/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "PlayerInfo.h"
#import "WorldColissionsManager.h"
#import "ArmyQueue.h"

@implementation WorldColissionsManager
{
    GridMap *grid;
}
@synthesize soldiers;
@synthesize towers;

- (id)init:(GridMap *) gridMap
{
    self = [super init];
    if (self) {
        gameStatusEssentialsSingleton=[GameStatusEssentialsSingleton sharedInstance];
        grid=gridMap;
        
    }
    return self;
}

+Controller:(GridMap *) gridMap{
    return ([[WorldColissionsManager alloc]init:gridMap]);
}


-(void) surveliance{
    CGPoint towerpoint;
    CGPoint soldierpoint;

    //remove towers
    NSMutableArray *delTarray = [NSMutableArray array];
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
        if([[ArmyQueue layer] getInWave])
            break;
        if ([tower isDeath]) {
            [[WaveController controller] gainReward:tower.towerReward];
            [grid removeTower:tower];
            [delTarray addObject:tower];
        }
    }
    for(TowerGeneric* tower in delTarray)
        [gameStatusEssentialsSingleton.towers removeObject:tower];
    
    for (TowerGeneric* tower in gameStatusEssentialsSingleton.towers) {
        if (![tower visible]) {
            continue;
        }
        
        towerpoint=[tower getLocation];
        //need add is attacking

        for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
            if (![soldier visible]) {
                   continue;
            }
            soldierpoint = [soldier getPOSITION];
            soldierpoint=[grid convertMapIndexToGL:soldierpoint];
            
            if (tower.towerTowerId==1) {
                
                if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {
                    [tower attackTest:soldierpoint Target:soldier];
                    break;
                }
            } else if(tower.towerTowerId==2) {
                if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {

                    if (!tower.isCharging) {
                        [tower attackTest:soldierpoint Target:soldier];
                        break;
                    } else {
     
                    }
                    
               }
            } else if (tower.towerTowerId==4)  {
                 if ( (towerpoint.x>=soldierpoint.x-80&&towerpoint.x<=soldierpoint.x+80)&&(towerpoint.y>=soldierpoint.y-80&& towerpoint.y<=soldierpoint.y+80)&&[tower isAttacking]==false) {
                     
                     if (!tower.isCharging) {
                         [soldier moveOriginal];
                         [tower attackTest:soldierpoint Target:soldier];
                         break;
                     } else {
                         
                     }
                 }
            }
        }
        
        //soldier attacking
        for (Soldier* soldier in gameStatusEssentialsSingleton.soldiers) {
            if (![soldier visible] || [soldier getAttackCD] < [soldier getAttackTime] || ![soldier getATTACK_FLAG]) {
                continue;
            }
            
            soldierpoint = [soldier getPOSITION];
            soldierpoint=[grid convertMapIndexToGL:soldierpoint];
            
            if ( (towerpoint.x>=soldierpoint.x-50&&towerpoint.x<=soldierpoint.x+50)&&(towerpoint.y>=soldierpoint.y-50&& towerpoint.y<=soldierpoint.y+50)) {
                //CCLOG(@"soldier attack!!!!!");
                [soldier attack:towerpoint Target:tower];
                //[tower beignattacked];
            }
        }
        
        
        
    }

}
-(void) makeTowerSoldierFight:(TowerGeneric*) tower :(Soldier*) soldier{
    
}
-(void) makeTowerSoldierFightTest:(TowerGeneric*) tower :(CGPoint) soldier{
    
}


-(void)addTower:(CCNode*)towerr{
   // [towers addObject:towerr];
    [gameStatusEssentialsSingleton.towers addObject:towerr];
}

-(void)removeSoldier:(Soldier*)soldier{
    
}

-(void)removeTower:(TowerGeneric*)tower{
    
}


@end
