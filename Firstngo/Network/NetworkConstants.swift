//
//  NetworkConstants.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

// MARK: - Urls
let SERVER_URL = "http://170.130.40.16:8080/api"
//http://170.130.40.16:8080/ap
//http://170.130.40.16:8080/

// MARK: - Api methods
let API_LOGIN           = "/auth"
let API_REGISTER        = "/reg"
let API_SEND_CODE       = "/auth/sendCode"
let API_CHECK_CODE      = "/auth/checkCode"
let API_NEW_PASS        = "/auth/newPass"

let API_USER            = "/user/profile/get"
let API_COUNTRY         = "/country/get"
let API_CITY            = "/city/get"

let API_SAVE_USER       = "/user/profile/update"

let API_USER_SERVICES   = "/order/getUserOrders"
let API_ALL_SERVICES    = "/product/getAll"
let API_GET_ONE         = "/product/getOne"
let API_ORDER_ONE       = "/order/getone"
let API_ORDER_CREATE    = "/order/create"

let API_ORDER_PAYMENT   = "/payment/ios"

let API_GET_CHAT        = "/chat/getone"
let API_SEND_CHAT       = "/chat/sendmessage"

let API_UPLOAD_FILE     = "/docs/upload"



