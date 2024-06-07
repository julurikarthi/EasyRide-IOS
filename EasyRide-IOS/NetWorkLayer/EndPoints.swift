//
//  EndPoints.swift
//  EasyRide-IOS
//
//  Created by karthik on 4/26/24.
//

import UIKit

enum EndPoints: String {
    case countries = "http://3.22.224.37/countries.json"
    case baseUrl = "http://3.22.224.37/NewEndPoint.php"
    case getCarsModels = "http://3.22.224.37/NewEndPoint.php?action=getCarsModels"
}

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case ContentType = "application/json"
}

enum ServerMethods: String {
    case singintapido = "singintapido"
}
