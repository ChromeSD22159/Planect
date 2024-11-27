//
//  PlaneAnalyzerError.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
//
 
enum PlaneAnalyzerError: Error {
    case modelLoadFailed
    case imageConversionFailed
    case analysisFailed(String)
}
