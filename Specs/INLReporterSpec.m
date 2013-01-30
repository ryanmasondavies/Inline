//
//  INLReporterSpec.m
//  Inline
//
//  Created by Ryan Davies on 30/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(INLReporter)

it(@"should override the default OCUnit class in NSUserDefaults in +load", ^{});

it(@"should output when a suite starts", ^{});

it(@"should report group labels once per group", ^{});

it(@"should indent tests within groups", ^{});

it(@"should further indent tests within nested groups", ^{});

it(@"should mark failing tests with the prefix [F]", ^{});

it(@"should mark pending tests with the prefix [P]", ^{});

SpecEnd
