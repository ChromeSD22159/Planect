//
//  PlaneError.swift
//  Planect
//
//  Created by Frederik Kohler on 27.11.24.
// 

enum PlaneError: Error {
    case modelError
    case convertError
    case noForecast
    case noEvaluation
    case requestError(Error)

    var localizedDescription: String {
        switch self {
        case .modelError:
            return "Das Modell konnte nicht geladen werden."
        case .convertError:
            return "Fehler beim Konvertieren des Bildes."
        case .noForecast:
            return "Keine Vorhersage möglich."
        case .noEvaluation:
            return "Fehler bei der Analyse des Bildes."
        case .requestError(let error):
            return "Request-Fehler: \(error.localizedDescription)"
        }
    }
}
