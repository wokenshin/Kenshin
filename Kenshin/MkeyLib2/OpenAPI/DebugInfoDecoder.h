//
//  DebugInfoDecoder.h
//  OpenAPI
//
//  Created by 王江 on 23/12/2016.
//  Copyright © 2016 M2Mkey. All rights reserved.
//

#import "ProtocolDecoder.h"

@interface DebugInfoDecoder : ProtocolDecoder

@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) BOOL isEnd;

@end
