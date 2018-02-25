//
//  NetworkEnums.h
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//


typedef NS_ENUM(NSInteger, BaseNetworkCallType) {
    BaseNetworkCallTypePOST,
    BaseNetworkCallTypeGET,
    BaseNetworkCallTypeHEAD,
    BaseNetworkCallTypeDELETE,
    BaseNetworkCallTypePUT
};

typedef NS_ENUM(NSInteger, BaseNetworkInstance) {
    //BaseNetworkInstanceNews,
    BaseNetworkInstanceMain
};

typedef NS_ENUM(NSInteger, BaseNetworkError) {
    BaseNetworkErrorNoInternet = -1000,
    BaseNetworkErrorConnectionTimeout = -1001,
    BaseNetworkErrorFacebookError = -1002,
    BaseNetworkErrorFacebookCancelled = -1003,
    BaseNetworkErrorGoogleError = -1004,
    BaseNetworkErrorEmailRegisterError = -1005,
    BaseNetworkErrorEmailLoginError = -1006,
    BaseNetworkErrorParsingData = -1007,
    BaseNetworkErrorAuthRequired = -1008
};
