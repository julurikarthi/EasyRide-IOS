//
//  EndPoints.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/26/24.
//

import UIKit

enum EndPoints: String {
    case countries = "http://127.0.0.1/mac/countries.json"
    case baseUrl = "http://18.117.81.223/NewEndPoint.php"
    case getCarsModels = "http://18.117.81.223/NewEndPoint.php?action=getCarsModels"
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case ContentType = "application/json"
}

enum ServerMethods: String {
    case singintapido = "singintapido"
}
