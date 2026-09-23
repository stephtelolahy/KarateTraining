//
//  Technique+imageURL.swift
//  KarateTraining
//
//  Created by Hugues Stéphano TELOLAHY on 24/09/2026.
//

extension TechniqueID {

    /// URL de l'image publiée sur le site de l'École de Karaté Shotokan Chagny.
    ///
    /// `nil` signifie que la page source ne fournit pas d'illustration
    /// propre à cette technique.
    var imageURL: String? {
        let base = "https://ecoledekarateshotokanchagny.e-monsite.com/medias/images/"

        switch self {

        // MARK: - Tsuki

        case .ageZuki:
            return base + "agetsuki.jpg"

        case .chokuZuki:
            return base + "choku-tsuki.jpg"

        case .gyakuZuki:
            return base + "gyaku-tsuki.jpg"

        case .kagiZuki:
            return base + "kagi-tsuki-1.jpg?fx=r_200_200"

        case .kizamiZuki:
            return base + "kizami.jpg"

        case .maeteZuki:
            return base + "maete.jpg"

        case .mawashiZuki, .furiZuki:
            return base + "mawashi-tsuki.jpg"

        case .heikoZuki:
            return base + "heiko-tsuki.jpg?fx=r_200_200"

        case .hasamiZuki:
            return base + "hasami-tsuki-2.jpg?fx=r_200_200"

        case .moroteUraZuki:
            return base + "morote-ura-tsuki.jpg?fx=r_200_200"

        case .awaseZuki:
            return base + "awase-tsuki.jpg?fx=r_200_200"

        case .yamaZuki:
            return base + "yama-tsuki.jpg?fx=r_200_200"

        case .nagashiZuki:
            return base + "nagashi.jpg"

        case .nukite:
            return base + "nukite-4.jpg"

        case .gohonNukite,
             .ipponNukite,
             .nihonNukite,
             .yohonNukite:
            return base + "nukite-4.jpg"

        case .oiZuki, .junZuki:
            return base + "oi-tsuki-1.png"

        case .tateZuki:
            return base + "tate-tsuki.jpg"

        case .uraZuki:
            return base + "ura-tsuki.jpg"

        // Les techniques suivantes n'ont pas d'image propre
        // explicitement associée sur la page source.
        case .otoshiZuki,
             .teishoZuki,
             .moroteZuki:
            return nil


        // MARK: - Uchi

        case .empiUchi, .maeEmpiUchi:
            return base + "empi-uchi1.jpg?fx=r_200_200"

        case .otoshiEmpiUchi:
            return base + "otoshi-empi-uchi.jpg?fx=r_200_200"

        case .tateEmpiUchi:
            return base + "empi-uchi2.jpg?fx=r_200_200"

        case .ushiroEmpiUchi:
            return base + "empi-uchi4.jpg?fx=r_200_200"

        case .yokoEmpiUchi,
             .yokoMawashiEmpiUchi:
            return base + "empi-uchi3.jpg?fx=r_200_200"

        case .haishuUchi:
            return base + "haishu-uchi.jpg?fx=r_200_200"

        case .haitoUchi:
            return base + "haito-uchi.jpg?fx=r_200_200"

        case .kokenUchi, .kakutoUchi:
            return base + "kakuto-uchi.jpg?fx=r_200_200"

        case .shutoUchi,
             .mawashiShutoUchi,
             .sotoShutoUchi,
             .hasamiShutoUchi:
            return base + "shuto-uchi.jpg?fx=r_200_200"

        case .teishoUchi:
            return base + "teisho-uchi2.jpg?fx=r_200_200"

        case .hasamiTeishoUchi:
            return base + "teisho-uchi1.jpg?fx=r_200_200"

        case .tettsuiUchi,
             .moroteTettsuiUchi,
             .hasamiTettsuiUchi:
            return base + "tetsui-uchi.jpg?fx=r_200_200"

        case .urakenUchi:
            return base + "tate-uraken-uchi.jpg"

        case .tateUrakenUchi:
            return base + "tate-uraken-uchi.jpg"

        case .urakenShomenUchi:
            return base + "shomen-uraken-uchi.jpg"

        case .yokoUrakenUchi:
            return base + "yoko-uraken-uchi.jpg"

        case .seikenMawashiUchi:
            return base + "yoko-uraken-uchi.jpg"


        // MARK: - Geri / Barai

        case .ashiBarai, .maeAshiBarai:
            return base + "ashi-barai-mae.jpg"

        case .ushiroAshiBarai:
            return base + "ashi-barai-ushiro.jpg"

        case .tobiAshiBarai:
            return nil

        case .ushiroMawashiBarai:
            return base + "mawashigeri-ura.gif?fx=r_200_200"

        case .fumikiri:
            return nil

        case .fumikomiGeri,
             .gedanGeri,
             .sokutoFumikomi,
             .kansetsuGeri,
             .ushiroFumikomi:
            return base + "fumikomi-empi-uke-1.gif?fx=r_200_200"

        case .hizaGeri, .hitsuiGeri:
            return base + "hizagueri-mae.png?fx=r_200_200"

        case .kakatoGeri:
            return base + "kakatogueri.png?fx=r_200_200"

        case .maeKakatoGeri:
            return base + "maekakatogerichudan.gif?fx=r_200_200"

        case .maeGeri:
            return base + "maegueri.png?fx=r_200_200"

        case .maeAshiMaeGeri,
             .kizamiMaeGeri,
             .ushiroAshiMaeGeri,
             .maeGeriKeage,
             .maeSokutoGeri,
             .nidanGeri,
             .surikondeMaeGeri,
             .tobikondeMaeGeri:
            return base + "maegueri.png?fx=r_200_200"

        case .tobiMaeGeri:
            return base + "maetobigueri.png"

        case .mawashiGeri,
             .maeAshiMawashiGeri,
             .kizamiMawashiGeri,
             .ushiroAshiMawashiGeri,
             .kaseiMawashiGeri,
             .surikondeMawashiGeri,
             .tobikondeMawashiGeri:
            return base + "mawashi-gueri.png?fx=r_200_200"

        case .tobiMawashiGeri:
            return base + "maetobigueri.png"

        case .mikazukiGeri:
            return base + "mikazukigueri.png?fx=r_200_200"

        case .gyakuMikazukiGeri,
             .surikondeMikazukiGeri,
             .tobikondeMikazukiGeri,
             .namiAshi:
            return base + "mikazukigueri.png?fx=r_200_200"

        case .tobiGeri:
            return base + "maetobigueri.png"

        case .tobiUshiroMawashiGeri:
            return base + "ushirotobigueri.png"

        case .tobiYokoGeri:
            return base + "yoko-tobi-gueri.png"

        case .uraMawashiGeri:
            return base + "mawashigeri-ura.gif?fx=r_200_200"

        case .ushiroGeri,
             .maeAshiUshiroGeri,
             .ushiroAshiUshiroGeri,
             .ushiroGeriKekomi:
            return base + "ushiro-gueri.png"


        // MARK: - Uke

        case .empiUke:
            return base + "empi-uke-1.png"

        case .gedanBarai:
            return base + "gaiwan1.jpg?fx=c_100_100"

        case .gedanUchiBarai:
            return base + "gedan-barai2-1.png?fx=r_200_200"

        case .haishuUke:
            return base + "haishu-uke-1.jpg?fx=r_200_200"

        case .heikoUke:
            return base + "haiwan.jpg?fx=c_100_100"

        case .jodanAgeUke:
            return base + "jodan-aje-uke.png?fx=r_200_200"

        case .jujiUke:
            return base + "jodan-juji-uke-1.png?fx=r_200_200"

        case .jodanJujiUke:
            return base + "jodan-juji-uke-1.png?fx=r_200_200"

        case .gedanJujiUke:
            return base + "godan-juji-uke-1.jpg?fx=r_200_200"

        case .kakiwakeUke:
            return base + "kakiwake-2.jpg?fx=r_200_200"

        case .kokenUke, .kakutoUke:
            return base + "kakutouke-1.jpg?fx=r_200_200"

        case .manjiUke:
            return base + "manji-uke-1.jpg?fx=r_200_200"

        case .moroteUchiUke:
            return base + "morote-1.jpg?fx=r_200_200"

        case .nagashiUke:
            return base + "haiwan-nagachi-uke-1.jpg?fx=r_200_200"

        case .teNagashiUke:
            return base + "te-nagashi-uke-1.jpg?fx=r_200_200"

        case .haiwanNagashiUke:
            return base + "haiwan-nagachi-uke-1.jpg?fx=r_200_200"

        case .osaeUke:
            return base + "osae-uke-1.png?fx=r_200_200"

        case .otoshiUke:
            return base + "otoshiuke-2.jpg?fx=r_200_200"

        case .shutoUke:
            return base + "kokutsu-shuto-1.png?fx=r_200_200"

        case .sotoUdeUke:
            return base + "soto-uke-1.png?fx=r_200_200"

        case .sukuiUke,
             .uchiSukuiUke,
             .sotoSukuiUke:
            return base + "sukui-uke-handflaeche-2.gif?fx=r_200_200"

        case .tateShutoUke:
            return base + "tate-shuto-uke-1.png?fx=r_200_200"

        case .teishoUke:
            return base + "teisho-5.jpg?fx=c_100_100"

        case .uchiUdeUke:
            return base + "uchi-uke1-1.png?fx=r_200_200"


        // MARK: - Kamae / Dachi / Unsoku

        // Les pages Dachi, Kamae et Unsoku ne fournissent pas
        // actuellement d'image propre à chaque technique.
        default:
            return nil
        }
    }
}
