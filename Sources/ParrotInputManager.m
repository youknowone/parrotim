//
//  CIMInputManager.m
//  CharmIM
//
//  Created by youknowone on 11. 9. 1..
//  Copyright 2011 youknowone.org. All rights reserved.
//

#import "ParrotInputManager.h"

#import "CIMConfiguration.h"
#import "CIMInputHandler.h"
#import "ParrotComposer.h"

#define DEBUG_INPUTMANAGER TRUE

@implementation ParrotInputManager
@synthesize server, configuration, handler, currentComposer;

- (id)init
{
    self = [super init];
    ICLog(DEBUG_INPUTMANAGER, @"** CIMInputManager Init: %@", self);
    if (self) {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *connectionName = [[mainBundle infoDictionary] objectForKey:@"InputMethodConnectionName"];
        self->server = [[IMKServer alloc] initWithName:connectionName bundleIdentifier:[mainBundle bundleIdentifier]];
        self->handler = [[CIMInputHandler alloc] initWithManager:self];
        ICLog(DEBUG_INPUTMANAGER, @"\tserver: %@ / handler: %@", self->server, self->handler);

        // Only composer for this project
        self->currentComposer = [[ParrotComposer alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [self->currentComposer release];
    [self->handler release];
    [self->server release];
    [super dealloc];
}

#pragma - IMKServerInputTextData

- (BOOL)inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender {
    return [self->handler inputText:string key:keyCode modifiers:flags client:sender];
}

@end
