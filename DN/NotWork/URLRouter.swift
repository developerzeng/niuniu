//
//  URLRouter.swift
//  ShenSu
//
//  Created by shensu on 17/5/10.
//  Copyright © 2017年 zp. All rights reserved.
//

import UIKit
import Alamofire

#if DEBUG
	let baseURL = "http://app.lh888888.com/"
#else
	let baseURL = "http://app.lh888888.com/"
#endif
public enum URLRouter: URLRequestConvertible {
    case Login(accoutn: String , password: String)
    case regist(account:String , password: String)

	public func asURLRequest() throws -> URLRequest {

		let url = try baseURL.asURL()
		var urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
		urlRequest.timeoutInterval = 25
		urlRequest.httpMethod = self.method.rawValue
		return try URLEncoding.default.encode(urlRequest, with: result.parameters)
	}
	var method: Alamofire.HTTPMethod {
		switch self {

		default:
			return .post
		}
	}
	var result: (path: String, parameters: Parameters) {
		switch self {
		case .Login(let account , let password):
			return ("Award/Api/login", ["name": account, "password": password])
        case .regist(let account, let password):
            return ("Award/Api/register",["name":account , "password":password,"repassword":password])
		}
	}

}

