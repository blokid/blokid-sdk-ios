//
//  NetworkManager.swift
//  BlokID
//
//  Created by Netset on 26/12/24.
//

import Foundation

class NetworkManager {

    static let endpoint = URL(string: "https://stg-pixel.blokid.com/track")!

    static func sendDataApiMethod(dataParam: [String: Any]) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        do {
            debugPrint("Api Url - ",endpoint)
            debugPrint("Header - ",(request.allHTTPHeaderFields as? NSDictionary ?? [:]))
            debugPrint("Param - ",(dataParam as NSDictionary))
            request.httpBody = try JSONSerialization.data(withJSONObject: dataParam)

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    debugPrint("Failed to send data: ",error.localizedDescription)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    debugPrint("Status code", httpResponse.statusCode)
                    if let data = data,let jsonString = String(data: data, encoding: .utf8) {
                        debugPrint("Response data Str: ", jsonString)
                        do {
                            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                                debugPrint("Response data: ", jsonDict)
                            }
                        } catch {
                            debugPrint("Error:- ",error.localizedDescription)
                        }
                    }
                } else {
                    debugPrint("Server error or invalid response")
                }
            }
            task.resume()
        } catch {
            debugPrint("Do Error:- ",error.localizedDescription)
        }
    }
    
    static let endpointGet = URL(string: "https://stg-pixel.blokid.com/saved-raw-events")!

    static func fetchSavedRawEvents(siteIdentifier: String) {
        guard var urlComponents = URLComponents(url: endpointGet, resolvingAgainstBaseURL: false) else {
            debugPrint("Invalid endpoint URL")
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "site_identifier", value: siteIdentifier)
        ]
        guard let url = urlComponents.url else {
            debugPrint("Failed to construct URL with query parameters")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        debugPrint("API URL - ", url.absoluteString)
        debugPrint("Header - ",(request.allHTTPHeaderFields as? NSDictionary ?? [:]))
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                debugPrint("Failed to fetch data: ", error.localizedDescription)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                debugPrint("Status code", httpResponse.statusCode)
                if let data = data,let jsonString = String(data: data, encoding: .utf8) {
                    debugPrint("Response data Str: ", jsonString)
                    do {
                        if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            debugPrint("Response data: ", jsonDict)
                        }
                    } catch {
                        debugPrint("Error:- ",error.localizedDescription)
                    }
                }
            } else {
                debugPrint("Server error or invalid response")
            }
        }
        task.resume()
    }

}
