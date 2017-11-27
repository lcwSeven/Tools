//
// Created by 才文刘 on 2017/11/6.
// Copyright (c) 2017 seven. All rights reserved.
//

import Foundation
import Alamofire

/*success callBack*/
typealias successCallBack = (_ responsed:AnyObject)->()
/*fail callBack*/
typealias failCallBack = (_ error:Error)->()
/*进度回调*/
typealias progressCallBack = (_ progress:Progress)->()

class NetworkTool {
    
   fileprivate class func getSessionManager()->SessionManager{
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20.0
        let sessionManager = SessionManager.init(configuration: config,
                                                 delegate: SessionDelegate(), serverTrustPolicyManager: nil);
        return sessionManager
    }

    /// get请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - param: 请求参数
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public class func getWithUrl(url:String,param:[String:AnyObject],
                                 success:@escaping successCallBack,fail:@escaping failCallBack){
        NetworkTool.getSessionManager().request(url, method: .get,
                                                parameters: param, encoding: JSONEncoding.default,
                                                headers: nil).responseJSON { response in
                                                    if response.result.isSuccess{
                                                        success(response as AnyObject)
                                                    }else{
                                                        fail(response.error!)
                                                    }
        }
        
    }
    
    /// post请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - param: 请求参数
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public class func postWithUrl(url:String,param:[String:AnyObject],
                                  success:@escaping successCallBack,fail:@escaping failCallBack){
        
        NetworkTool.getSessionManager().request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
           .responseJSON { (response) in
                if response.result.isSuccess{
                    success(response as AnyObject)
                }else{
                    fail(response.error!)
                }
                
        }
    }
    
}
