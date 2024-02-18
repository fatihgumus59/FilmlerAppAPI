//
//  ViewController.swift
//  FilmlerApp
//
//  Created by Fatih Gümüş on 4.01.2024.
//

import UIKit
import Kingfisher

class Anasayfa: UIViewController {

    @IBOutlet weak var filmlerCollectionView: UICollectionView!
    
    var filmlerListesi = [Filmler]()
    
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmlerCollectionView.dataSource = self
        filmlerCollectionView.delegate = self
        
        
        _ = viewModel.filmlerListesi.subscribe(onNext: { liste in
            self.filmlerListesi = liste
            DispatchQueue.main.async{
                self.filmlerCollectionView.reloadData()//tabloyu yeniler
            }
            
        })
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        // 10 x 10 x 10 = 30  -> boşluk hesaplaması
        let ekranGenislik = UIScreen.main.bounds.width // ekran genişliğini aldık.
        let ItemGenislik = (ekranGenislik - 30) / 2 // -> ekran genişliğinden boşlukları çıkardık - 2ye bölme sebebi yan yana 2 tane olması
        
        tasarim.itemSize = CGSize(width: ItemGenislik, height: ItemGenislik*1.8)
        
        filmlerCollectionView.collectionViewLayout = tasarim
        
    }


}
extension Anasayfa : UICollectionViewDataSource,UICollectionViewDelegate,HucreProtokol{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmlerListesi[indexPath.row]
        
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "filmlerHucre", for: indexPath) as! FilmlerHucre
        
        hucre.filmFiyat.text = "\(film.fiyat!) ₺"
        
       
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler_yeni/resimler/\(film.resim!)"){
            DispatchQueue.main.async{
                hucre.filmImage.kf.setImage(with: url)
            }
        }
       
        
        
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10
        
        hucre.hucreProtokol = self
        hucre.indexPath = indexPath

        
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        
        performSegue(withIdentifier: "toDetay", sender: film)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "toDetay"{
            if let film = sender as? Filmler{
                
                let gidilecekVc = segue.destination as! DetaySayfa
                gidilecekVc.film = film
            }
            
        }
    }
    
    func sepeteEkleTiklandi(indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        print("\(film.ad!) Sepete Eklendi.")
    }
}
