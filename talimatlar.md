Merhaba. Oncelikle tum cevaplarini Turkce vermelisin. Ben sana talimatlari hep Turkce verecegim.

Android icin bir harcama takip uygulamasi yapacagiz. Proje ismi “Tasarruf” olacak.

## Genel Talimatlar:

- Projeyi geliştirirken anlamadigin veya karar vermede zorlandığın durumlarda, kodu yazmadan önce mutlaka benim fikrimi al, bana sorular sor ve cevaplarına göre ilerle.  
- Temel bir Flutter projesini zaten ben oluşturdum, senin bastan oluşturmana gerek yok. Flutter’in yaninda baska teknolojiler kullanman gerekiyorsa, bunlarin seçimini sana birakiyorum.  
- Projeye başlamadan önce mutlaka @cursorrules dosyasini oku.   
- Projeye başlamadan önce tum codebase indeksle ve analiz et. Proje yapisini anla.  
- Projeye baslamadan once @functional-requirements.md ve @progress.md dosyalarini guncelle. (Bunlari da ben oluşturdum, icleri bos, sen sadece icerigini doldur.)  
- Projeye baslamadan once @README.md dosyasini da guncelle.  
- Temiz bir tasarim kullan. Dark Mode destegi olmalidir.  
- Uygulamayi Flutter ile geliştir. Bunun disinda kullanmak istediğin diğer teknolojilerin seçimini sana birakiyorum.   
- Uygulamayi sadece Android için geliştir. Diğer platformlar için olan dosyalari ve kodlari mutlaka sil.  
- API ile ilgili dokümantasyonu cok iyi oku ve anla. Eger anlamadığın bir konu olursa bana mutlaka sor, ornek response falan istersen sana iletirim.  
- Bilgisayarımda Javanın 17 versiyonu yüklü, gelistirmeyi yaparken buna dikkat et.  
- Flutter ile ilgili son güncellemeleri kullan. Her zaman en son versiyon paketleri ve yöntemleri kullan. Eger son güncellemelerin ne olduğunu bilmiyorsan, bana bildir ve ben sana ilgili dokumantasyonun linkini paylasacagim. Böylece ogrenebilirsin.


  
## Uygulama Ozellikleri:

1. Harcama Giris Ekrani:

    * Burada yaptığımız isleme dair doldurmamiz gereken alanlar olmalidir.  
    * Miktar, islem turu (harcama veya para girisi), tarih, harcama ismi bu ekranda girilir.

2. Islemler Ekrani:

    * Burada yapılan onceki islemler liste olarak gorunmelidir.  
    * Tarih aralığı seçimi ve islem turune (harcama veya para girisi) gore filtreleme olmalidir.  
    * Seçilen filtreye göre gerekli hesaplama yapilmali ve toplam harcama ve toplam para girisi ayri ayri gorunmelidir. Ayrica toplam bakiye de gorunmelidir. (toplam harcamadan toplam para girisi cikarilacak)  
    * Filtre temizlenebilmelidir. Filtre temizlendiğinde varsayilan olarak ay basindan itibaren yapılan işlemler goruntulenmedir.  
    * Tüm veri import veya export edilebilmelidir.

3. Ayarlar Ekrani:  
s

	

