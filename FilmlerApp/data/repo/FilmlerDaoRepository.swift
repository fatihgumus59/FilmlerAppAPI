//
//  FilmlerDaoRepository.swift
//  FilmlerApp
//
//  Created by Fatih Gümüş on 31.01.2024.
//

import Foundation
import RxSwift

class FilmlerDaoRepository{
    
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]())
    
    func filmlerYukle(){
        var filmler = [Filmler]()
        
        let f1 = Filmler(Id: 1, resim: "django", ad: "Django", fiyat: 24)
        let f2 = Filmler(Id: 2, resim: "interstellar", ad: "İnterstellar", fiyat: 32)
        let f3 = Filmler(Id: 3, resim: "inception", ad: "Inception", fiyat: 16)
        let f4 = Filmler(Id: 4, resim: "thehatefuleight", ad: "The Hateful Eight", fiyat: 28)
        let f5 = Filmler(Id: 5, resim: "thepianist", ad: "The Pianist", fiyat: 18)
        let f6 = Filmler(Id: 6, resim: "anadoluda", ad: "Anadoluda", fiyat: 10)
        
        filmler.append(f1)
        filmler.append(f2)
        filmler.append(f3)
        filmler.append(f4)
        filmler.append(f5)
        filmler.append(f6)
        
        filmlerListesi.onNext(filmler)
    }
}
