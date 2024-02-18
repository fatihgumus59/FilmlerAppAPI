//
//  AnasayfaViewModel.swift
//  FilmlerApp
//
//  Created by Fatih Gümüş on 31.01.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
 
    var fRepo = FilmlerDaoRepository()
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]())
    
    init(){
        filmlerListesi = fRepo.filmlerListesi
        filmlerYukle()
    }
    
    func filmlerYukle(){
        fRepo.filmlerYukle()
    }
}
