//
//  MallAPI.swift
//  Shopping
//
//  Created by apple on 2019/11/20.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import Moya
import HandyJSON


let mallProvider = MoyaProvider<Mall>()

public enum Mall {
    case login(String, String)
    case assort
    case shopCart
    case userProfile
    case home
    case homeBanner
}


extension Mall: TargetType {
    
    public var baseURL: URL { return URL(string: "http://gb.coinpaybbs.com/api.php")! }
    public var path: String {
        switch self {
        case .login(_, _):
            return "Login/loginUser"
        case .assort:
            return "index/catList"
        case .shopCart:
            return "goods/cart"
        case .userProfile:
            return ""
        case .home:
            return "Goods/goodsTypeList"
        case .homeBanner:
            return "index/banner"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .login(_, _):
            return .post
        case .home:
            return .post
        default:
            return .get
        }
        
    }
    public var task: Task {
        switch self {
        case .login(let name, let pwd):
            var params: [String: Any] = [:]
            params["username"] = name
            params["password"] = pwd
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    public var sampleData: Data {
        switch self {
        case .login(let name, let pwd):
            return "{\"username\": \"\(name)\", \"password\": \"\(pwd)\"}".data(using: String.Encoding.utf8)!
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }
    public var headers: [String: String]? {
        return nil
    }
}

extension Moya.Response {
    func mapNSArray() throws -> NSArray {
        let any = try self.mapJSON()
        guard let array = any as? NSArray else {
            throw MoyaError.jsonMapping(self)
        }
        return array
    }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion:  ((_ returnData: T?) -> Void)?) -> Cancellable? {
                
            return request(target, completion: { (result) in
                guard let completion = completion else { return }
                guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                    completion(nil)
                    return
                }
                completion(returnData.data)
            })
        }
}
