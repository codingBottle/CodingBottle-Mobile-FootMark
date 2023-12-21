//
//  AFLogger.swift
//  Footmark
//
//  Created by 박신영 on 11/9/23.
//

import Foundation
import Alamofire

class AlamofireLogger: EventMonitor {

    let queue = DispatchQueue(label: "myNetworkLogger")

    func requestDidFinish(_ request: Request) {
        print("----------------------------------------------------")
        print("✅✅ Request Logger ✅✅")
        print(request.description)
        
        print(
            "✅ URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
            + "✅ Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "✅ Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        print("✅ Authorization: " + (request.request?.headers["Authorization"] ?? ""))
        print("✅ Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("----------------------------------------------------")
        print("💡💡 Response Logger 💡💡")
        print(
          "💡 URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "💡 Result: " + "\(response.result)" + "\n"
            + "💡 StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "💡 Data: \(response.data?.toPrettyPrintedString ?? "")"
        )
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}

