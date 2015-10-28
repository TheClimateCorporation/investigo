//
//  Copyright 2012 Lolay, Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "LolayMultipleTracker.h"

@interface LolayMultipleTracker ()

@property (nonatomic, strong, readwrite) NSArray* trackers;

@end

@implementation LolayMultipleTracker

@synthesize trackers = trackers_;

- (id) initWithTrackers:(id<LolayTracker>) firstTracker, ... {
    self = [super init];
    
    if (self) {
        NSMutableArray* tmpTrackers = [[NSMutableArray alloc] init];
        
        if (firstTracker) {
            va_list trackerArguments;
            id<LolayTracker> tracker = nil;
            
            va_start(trackerArguments, firstTracker);
            
            for (tracker = firstTracker; tracker != nil; tracker = va_arg(trackerArguments, id<LolayTracker>)) {
                [tmpTrackers addObject:tracker];
            }
            va_end(trackerArguments);
        }
        
        self.trackers = tmpTrackers;
    }
    
    return self;
}

- (void) setIdentifier:(NSString*) identifier {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setIdentifier:identifier];
    }
}

- (void) setVersion:(NSString*) version {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setVersion:version];
    }    
}

- (void) logRegistration:(NSDictionary*) userData {
	for (id<LolayTracker> tracker in self.trackers) {
        [tracker logRegistration:userData];
    }
}

- (void) logPurchase:(NSDictionary*) purchaseData {
	for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPurchase:purchaseData];
    }
}

- (void) logIdentity {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logIdentity];
    }
}

- (void) setAge:(NSUInteger) age {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setAge:age];
    }    
}

- (void) setFirstName:(NSString *)firstName {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setFirstName:firstName];
    }
}

- (void) setLastName:(NSString *)lastName {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setLastName:lastName];
    }
}

- (void) setEmail:(NSString *)email {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setEmail:email];
    }
}

- (void) setCity:(NSString *)city {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setCity:city];
    }
}

- (void) setState:(NSString *)state {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setState:state];
    }
}

- (void) setZip:(NSString *)zip {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setZip:zip];
    }
}

- (void) setPhone:(NSString *)phone {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setPhone:phone];
    }
}

- (void) setGender:(LolayTrackerGender) gender {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGender:gender];
    }
}

- (void) setGlobalParameters:(NSDictionary*) globalParameters {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameters:globalParameters];
    }
}

- (void) setGlobalParameter:(NSString*) object forKey:(NSString*) key {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker setGlobalParameter:object forKey:key];
    }
}

- (void) removeGlobalParameterForKey:(NSString*) key {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker removeGlobalParameterForKey:key];
    }
}

- (void) logEvent:(NSString*) name {
    NSDictionary * mergedParameters = [self parametersWithSystemParameters: @{}];

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name withDictionary: mergedParameters];
    }
}

- (void) logEvent:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSDictionary * mergedParameters = [self parametersWithSystemParameters: parameters];

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logEvent:name withDictionary: mergedParameters];
    }
}

- (void) logPage:(NSString*) name {
    NSDictionary * mergedParameters = [self parametersWithSystemParameters: @{}];

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name withDictionary: mergedParameters];
    }
}

- (void) logPage:(NSString*) name withDictionary:(NSDictionary*) parameters {
    NSDictionary * mergedParameters = [self parametersWithSystemParameters: parameters];

    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logPage:name withDictionary: mergedParameters];
    }
}

- (void) logException:(NSException*) exception {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logException:exception];
    }
}

- (void) logError:(NSError*) error {
    for (id<LolayTracker> tracker in self.trackers) {
        [tracker logError:error];
    }
}

- (void) logTiming:(NSDictionary*)timingData{
	for (id<LolayTracker> tracker in self.trackers) {
		[tracker logTiming:timingData];
	}
}

- (NSString*) trackerIdForType:(Class) clazz {
    for (id<LolayTracker> tracker in self.trackers) {
		NSString* trackerId = [tracker trackerIdForType:clazz];
		if (trackerId) {
			return trackerId;
		}
    }
	return nil;
}

- (NSDictionary *) parametersWithSystemParameters: (NSDictionary * ) parameters {
    NSMutableDictionary * mergedParameters = [[NSMutableDictionary alloc] initWithDictionary: parameters];

    mergedParameters[@"client_event_id"] = [[NSUUID UUID] UUIDString];

    return mergedParameters;
}

@end
