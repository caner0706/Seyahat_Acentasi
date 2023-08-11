import 'dart:io';

// Seyahat Paketi sınıfı, seyahat paketlerini ve müşteri yorumlarını temsil eder
class SeyahatPaketi {
  String nereden; // Seyahat paketinin başlangıç noktası
  String nereye; // Seyahat paketinin varış noktası
  double fiyat; // Seyahat paketinin fiyatı
  bool
      rezerveEdildi; // Seyahat paketinin rezerve edilip edilmediğini belirten bayrak
  List<MusteriYorumu>
      yorumlar; // Seyahat paketine ait müşteri yorumlarını içeren liste

  // Seyahat Paketi sınıfının kurucu metodu
  SeyahatPaketi(this.nereden, this.nereye, this.fiyat)
      : rezerveEdildi =
            false, // Başlangıçta paket rezerve edilmemiş olarak işaretlenir
        yorumlar = []; // Başlangıçta yorumlar boş bir liste ile başlar

  // Seyahat paketi rezervasyon yapma fonksiyonu
  void rezervasyonYap() {
    if (!rezerveEdildi) {
      rezerveEdildi = true;
      print('Paket $nereden - $nereye için rezerve edildi.');
    } else {
      print('Bu paket zaten rezerve edilmiş.');
    }
  }

  // Seyahat paketi bilgilerini gösteren fonksiyon
  void bilgiGoster() {
    print('Paket: $nereden - $nereye');
    print('Fiyat: $fiyat');
    print('Durum: ${rezerveEdildi ? "Rezerve Edildi" : "Müsait"}');
    if (yorumlar.isNotEmpty) {
      print('Müşteri Yorumları:');
      for (var yorum in yorumlar) {
        yorum
            .goster(); // Müşteri yorumlarını göstermek için yorum sınıfındaki goster fonksiyonu çağrılır
      }
    }
    print('------------------------');
  }

  // Seyahat paketine yeni bir müşteri yorumu ekleyen fonksiyon
  void yorumEkle(MusteriYorumu yorum) {
    yorumlar.add(yorum); // Yeni yorumu yorumlar listesine ekler
    print('Yorum eklendi.');
  }
}

// Müşteri Yorumu sınıfı, müşteri yorumlarını temsil eder
class MusteriYorumu {
  int derecelendirme; // Müşteri yorumunun derecelendirme puanı
  String yorum; // Müşteri yorumunun metni

  // Müşteri Yorumu sınıfının kurucu metodu
  MusteriYorumu(this.derecelendirme, this.yorum);

  // Müşteri yorumunu gösteren fonksiyon
  void goster() {
    print('Derecelendirme: $derecelendirme');
    print('Yorum: $yorum');
  }
}

void main() {
  List<SeyahatPaketi> paketler = [
    SeyahatPaketi('İstanbul', 'Paris', 1500),
    SeyahatPaketi('Ankara', 'Londra', 1800),
    SeyahatPaketi('İzmir', 'Roma', 1300),
  ];

  Map<int, SeyahatPaketi> paketDepolama =
      {}; // Seyahat paketlerini depolamak için bir harita (Map)

  int id = 1;
  for (var paket in paketler) {
    paketDepolama[id] = paket; // Seyahat paketlerini depolama haritasına ekler
    id++;
  }

  while (true) {
    print('Seyahat Acentesi');
    print('1. Paketleri Listele');
    print('2. Paket Rezervasyonu Yap');
    print('3. Müşteri Yorumları');
    print('4. Çıkış');
    print('Seçiminizi yapın: ');

    var secim = stdin.readLineSync();
    if (secim == null) {
      continue;
    }

    try {
      var secimInt = int.parse(secim);

      if (secimInt == 1) {
        print('Paketler:');
        for (var entry in paketDepolama.entries) {
          print('ID: ${entry.key}');
          entry.value.bilgiGoster();
        }
      } else if (secimInt == 2) {
        print('Rezerve etmek istediğiniz paket ID\'sini girin: ');
        var paketId = int.parse(stdin.readLineSync()!);

        var secilenPaket = paketDepolama[paketId];
        if (secilenPaket != null) {
          secilenPaket.rezervasyonYap();
        } else {
          print('Geçersiz paket ID\'si.');
        }
      } else if (secimInt == 3) {
        print('Müşteri Yorumları:');
        for (var entry in paketDepolama.entries) {
          print('ID: ${entry.key}');
          entry.value.bilgiGoster();
        }
        print('Yorum eklemek istediğiniz paket ID\'sini girin: ');
        var paketId = int.parse(stdin.readLineSync()!);

        var secilenPaket = paketDepolama[paketId];
        if (secilenPaket != null) {
          print('Derecelendirme (1-5 arası): ');
          var derecelendirme = int.parse(stdin.readLineSync()!);

          print('Yorum (Çıkmak için "-"): ');
          var yorum = stdin.readLineSync()!;

          if (yorum == '-') {
            continue;
          }

          var yeniYorum = MusteriYorumu(derecelendirme, yorum);
          secilenPaket.yorumEkle(yeniYorum);
        } else {
          print('Geçersiz paket ID\'si.');
        }
      } else if (secimInt == 4) {
        print('Çıkış yapılıyor...');
        break;
      } else {
        print('Geçersiz seçenek, lütfen tekrar deneyin.');
      }
    } catch (e) {
      print('Hatalı giriş, lütfen geçerli bir seçenek girin.');
    }
    print('----------------------------'); // Seçenekler arasını ayırmak için
  }
}
