//
//  WordExampleViewModel.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 12.12.2024.
//

import Foundation

protocol WordExampleViewModelDelegate {}

final class WordExampleViewModel {
    
    private var example: String? // private olmalı
    
    init(example: String? = nil) {
        self.example = example
    }
    
    func getExample() -> String {
        return example ?? "there is no example"
    }
    
    func setExample(example: String) {
        self.example = example
    }
    
   
}

