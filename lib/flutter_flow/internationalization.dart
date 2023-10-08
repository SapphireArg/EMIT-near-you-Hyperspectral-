import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es', 'fr', 'de', 'it', 'ja'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
    String? frText = '',
    String? deText = '',
    String? itText = '',
    String? jaText = '',
  }) =>
      [enText, esText, frText, deText, itText, jaText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    '0to9oi8i': {
      'en': 'About EMIT',
      'de': 'Über EMIT',
      'es': 'Acerca de EMIT',
      'fr': 'À propos d’EMIT',
      'it': 'A proposito di EMIT',
      'ja': 'EMITについて',
    },
    'jvgqv19e': {
      'en': 'Accomplishments and future benefits',
      'de': 'Erfolge und zukünftige Vorteile',
      'es': 'Logros y beneficios futuros',
      'fr': 'Réalisations et avantages futurs',
      'it': 'Risultati e benefici futuri',
      'ja': 'これまでの成果と今後のメリット',
    },
    'u85aarep': {
      'en': 'EMIT for you',
      'de': 'EMIT für Sie',
      'es': 'EMITIR para ti',
      'fr': 'ÉMETTRE pour vous',
      'it': 'EMETTI per te',
      'ja': 'あなたのためにEMIT',
    },
    '722msf5c': {
      'en': 'EMIT near you',
      'de': 'EMIT in Ihrer Nähe',
      'es': 'EMIT cerca de ti',
      'fr': 'EMIT près de chez vous',
      'it': 'EMIT vicino a te',
      'ja': 'あなたの近くで発信してください',
    },
    'kt6avv47': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // AboutEmit
  {
    '6xui06hs': {
      'en':
          'The Earth Surface Mineral Dust Source Investigation (EMIT)  is an imaging spectrometer that was developed at NASA’s Jet Propulsion Laboratory, launched on July 14, 2022. Robert O. Green is principal investigator of this instrument.\nThe instrument observes Earth from outside the International Space Station.\n\nThis is the EMIT instrument configuration for operation on the ISS. The optical elements of the telescope and spectrometer are contained within the Optical Bench Assembly (OBA).\nThe electronics receive, amplify, and digitize the weak analog signals from the detector array. These high rate data are compressed and stored on a digital recorder for replay to the ISS for transmission to the ground.\n',
      'de':
          'Das Earth Surface Mineral Dust Source Investigation (EMIT) ist ein bildgebendes Spektrometer, das am Jet Propulsion Laboratory der NASA entwickelt und am 14. Juli 2022 in Betrieb genommen wurde. Robert O. Green ist der Hauptforscher dieses Instruments.\nDas Instrument beobachtet die Erde von außerhalb der Internationalen Raumstation.\n\nDies ist die EMIT-Instrumentenkonfiguration für den Betrieb auf der ISS. Die optischen Elemente des Teleskops und des Spektrometers sind in der Optical Bench Assembly (OBA) enthalten.\nDie Elektronik empfängt, verstärkt und digitalisiert die schwachen analogen Signale vom Detektorarray. Diese Hochgeschwindigkeitsdaten werden komprimiert und auf einem digitalen Rekorder gespeichert, um sie auf der ISS wiederzugeben und zur Erde zu übertragen.',
      'es':
          'La Investigación de la Fuente de Polvo Mineral de la Superficie de la Tierra (EMIT) es un espectrómetro de imágenes desarrollado en el Laboratorio de Propulsión a Chorro de la NASA y lanzado el 14 de julio de 2022. Robert O. Green es el investigador principal de este instrumento.\nEl instrumento observa la Tierra desde fuera de la Estación Espacial Internacional.\n\nEsta es la configuración del instrumento EMIT para su funcionamiento en la ISS. Los elementos ópticos del telescopio y del espectrómetro están contenidos dentro del Conjunto de Banco Óptico (OBA).\nLa electrónica recibe, amplifica y digitaliza las débiles señales analógicas del conjunto de detectores. Estos datos de alta velocidad se comprimen y almacenan en una grabadora digital para reproducirlos en la ISS y transmitirlos a tierra.',
      'fr':
          'L’EMIT (Earth Surface Mineral Dust Source Investigation) est un spectromètre imageur développé au Jet Propulsion Laboratory de la NASA, lancé le 14 juillet 2022. Robert O. Green est le chercheur principal de cet instrument.\nL\'instrument observe la Terre depuis l\'extérieur de la Station spatiale internationale.\n\nIl s\'agit de la configuration de l\'instrument EMIT pour un fonctionnement sur l\'ISS. Les éléments optiques du télescope et du spectromètre sont contenus dans l\'ensemble banc optique (OBA).\nL\'électronique reçoit, amplifie et numérise les signaux analogiques faibles du réseau de détecteurs. Ces données à haut débit sont compressées et stockées sur un enregistreur numérique pour être relues vers l\'ISS et transmises au sol.',
      'it':
          'L’Earth Surface Mineral Dust Source Investigation (EMIT) è uno spettrometro per immagini sviluppato presso il Jet Propulsion Laboratory della NASA, lanciato il 14 luglio 2022. Robert O. Green è il ricercatore principale di questo strumento.\nLo strumento osserva la Terra dall\'esterno della Stazione Spaziale Internazionale.\n\nQuesta è la configurazione dello strumento EMIT per il funzionamento sulla ISS. Gli elementi ottici del telescopio e dello spettrometro sono contenuti all\'interno del gruppo banco ottico (OBA).\nL\'elettronica riceve, amplifica e digitalizza i deboli segnali analogici dalla schiera di rilevatori. Questi dati ad alta velocità vengono compressi e archiviati su un registratore digitale per essere riprodotti sulla ISS per la trasmissione a terra.',
      'ja':
          '地球表面鉱物粉塵源調査 (EMIT) は、NASA のジェット推進研究所で開発された画像分光計で、2022 年 7 月 14 日に打ち上げられました。ロバート O. グリーンはこの装置の主任研究者です。\nこの機器は国際宇宙ステーションの外から地球を観測します。\n\nこれは、ISS 上で動作するための EMIT 機器構成です。望遠鏡と分光計の光学要素は、光学ベンチ アセンブリ (OBA) 内に含まれています。\n電子機器は、検出器アレイからの微弱なアナログ信号を受信し、増幅し、デジタル化します。これらの高速データは圧縮されてデジタル レコーダーに保存され、ISS で再生されて地上に送信されます。',
    },
    'wiqyvlyb': {
      'en': 'Importance of the dust',
      'de': 'Bedeutung des Staubes',
      'es': 'Importancia del polvo',
      'fr': 'Importance de la poussière',
      'it': 'Importanza della polvere',
      'ja': '塵の大切さ',
    },
    '9xs6rszl': {
      'en': 'How does EMIT work?',
      'de': 'Wie funktioniert EMIT?',
      'es': '¿Cómo funciona EMIT?',
      'fr': 'Comment fonctionne EMIT ?',
      'it': 'Come funziona EMIT?',
      'ja': 'EMITはどのように機能しますか?',
    },
    't869viwe': {
      'en': 'About the mission',
      'de': 'Über die Mission',
      'es': 'Sobre la misión',
      'fr': 'À propos de la mission',
      'it': 'A proposito della missione',
      'ja': 'ミッションについて',
    },
    'wsn28ell': {
      'en': ' Imaging Spectrometer',
      'de': 'Bildgebendes Spektrometer',
      'es': 'Espectrómetro de imágenes',
      'fr': 'Spectromètre imageur',
      'it': 'Spettrometro per immagini',
      'ja': 'イメージング分光計',
    },
    'd04fsips': {
      'en': 'What kind of data does EMIT collects?',
      'de': 'Welche Art von Daten sammelt EMIT?',
      'es': '¿Qué tipo de datos recopila EMIT?',
      'fr': 'Quel type de données EMIT collecte-t-il ?',
      'it': 'Che tipo di dati raccoglie EMIT?',
      'ja': 'EMIT はどのような種類のデータを収集しますか?',
    },
    'q90x5lhu': {
      'en':
          'This video includes soundbites from EMIT mission team members, animations of how EMIT will operate on the International Space Station and collect data, as well as testing that was done at NASA’s Jet Propulsion Laboratory on the instrument prior to launch.\n',
      'de':
          'Dieses Video enthält Hörbeispiele von Mitgliedern des EMIT-Missionsteams, Animationen darüber, wie EMIT auf der Internationalen Raumstation operieren und Daten sammeln wird, sowie Tests, die vor dem Start im Jet Propulsion Laboratory der NASA am Instrument durchgeführt wurden.',
      'es':
          'Este video incluye fragmentos de sonido de los miembros del equipo de la misión EMIT, animaciones de cómo operará EMIT en la Estación Espacial Internacional y recopilará datos, así como pruebas realizadas en el Laboratorio de Propulsión a Chorro de la NASA en el instrumento antes del lanzamiento.',
      'fr':
          'Cette vidéo comprend des extraits sonores des membres de l\'équipe de la mission EMIT, des animations sur la façon dont EMIT fonctionnera sur la Station spatiale internationale et collectera des données, ainsi que des tests effectués au Jet Propulsion Laboratory de la NASA sur l\'instrument avant le lancement.',
      'it':
          'Questo video include dichiarazioni dei membri del team di missione EMIT, animazioni di come EMIT opererà sulla Stazione Spaziale Internazionale e raccoglierà dati, nonché test eseguiti presso il Jet Propulsion Laboratory della NASA sullo strumento prima del lancio.',
      'ja':
          'このビデオには、EMIT ミッション チームのメンバーによるサウンドバイト、EMIT が国際宇宙ステーションでどのように動作してデータを収集するかを示すアニメーション、打ち上げ前に NASA のジェット推進研究所で行われた装置のテストが含まれています。',
    },
    '3gbmxqc2': {
      'en': 'Credit: NASA/JPL-Caltech',
      'de': 'Bildnachweis: NASA/JPL-Caltech',
      'es': 'Crédito: NASA/JPL-Caltech',
      'fr': 'Crédit : NASA/JPL-Caltech',
      'it': 'Credito: NASA/JPL-Caltech',
      'ja': 'クレジット: NASA/JPL-カリフォルニア工科大学',
    },
    'qmfil3hp': {
      'en':
          'An animation depicting EMIT\'s installation onto the International Space Station (ISS)\nCredit: NASA\n',
      'de':
          'Eine Animation, die die Installation von EMIT auf der Internationalen Raumstation (ISS) zeigt.\nBildnachweis: NASA',
      'es':
          'Una animación que muestra la instalación de EMIT en la Estación Espacial Internacional (ISS)\nCrédito: NASA',
      'fr':
          'Une animation illustrant l\'installation d\'EMIT sur la Station spatiale internationale (ISS)\nCrédit : NASA',
      'it':
          'Un\'animazione che raffigura l\'installazione di EMIT sulla Stazione Spaziale Internazionale (ISS)\nCredito: NASA',
      'ja': '国際宇宙ステーション（ISS）へのEMITの設置を描いたアニメーション\nクレジット: NASA',
    },
    'c6wj4yeo': {
      'en':
          'EMIT is mounted on the ExPRESS Logistics Carrier 1 (ELC1) at the ISS',
      'de':
          'EMIT ist auf dem ExPRESS Logistics Carrier 1 (ELC1) auf der ISS montiert',
      'es':
          'EMIT está montado en el ExPRESS Logistics Carrier 1 (ELC1) en la ISS',
      'fr': 'EMIT est monté sur l\'ExPRESS Logistics Carrier 1 (ELC1) à l\'ISS',
      'it':
          'EMIT è montato sull\'ExPRESS Logistics Carrier 1 (ELC1) presso la ISS',
      'ja': 'EMITはISSのExPRESS Logistics Carrier 1（ELC1）に搭載されています',
    },
    '51qxkjv7': {
      'en': 'About EMIT',
      'de': 'Über EMIT',
      'es': 'Acerca de EMIT',
      'fr': 'À propos d’EMIT',
      'it': 'A proposito di EMIT',
      'ja': 'EMITについて',
    },
    '99oitij0': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Bienvenida
  {
    'ffgbc3oy': {
      'en': 'EMIT near you',
      'de': 'EMIT in Ihrer Nähe',
      'es': 'EMIT cerca de ti',
      'fr': 'EMIT près de chez vous',
      'it': 'EMIT vicino a te',
      'ja': 'あなたの近くで発信してください',
    },
    'o0diq8e1': {
      'en': 'Welcome!',
      'de': 'Willkommen!',
      'es': '¡Bienvenido!',
      'fr': 'Accueillir!',
      'it': 'Benvenuto!',
      'ja': 'いらっしゃいませ！',
    },
    '5xkmm387': {
      'en':
          'Thanks for joining! Tap anywhere and get started with EMIT!\nApp developed for the NASA Space Apps Challenge 2023 by Hyperspectral team.',
      'de':
          'Danke fürs Beitreten! Tippen Sie irgendwo hin und legen Sie mit EMIT los!\nVom Hyperspectral-Team für die NASA Space Apps Challenge 2023 entwickelte App.',
      'es':
          '¡Gracias por unirte! ¡Toca en cualquier lugar y comienza con EMIT!\nAplicación desarrollada para el NASA Space Apps Challenge 2023 por el equipo Hyperspectral.',
      'fr':
          'Merci d\'avoir rejoint ! Appuyez n\'importe où et lancez-vous avec EMIT !\nApplication développée pour le NASA Space Apps Challenge 2023 par l\'équipe Hyperspectral.',
      'it':
          'Grazie per la partecipazione! Tocca ovunque e inizia con EMIT!\nApp sviluppata per la NASA Space Apps Challenge 2023 dal team Hyperspectral.',
      'ja':
          'ご参加いただきありがとうございます!どこでもタップしてEMITを始めましょう!\nNASA Space Apps Challenge 2023 のために Hyperspectral チームによって開発されたアプリ。',
    },
    'wtmanibf': {
      'en':
          '\nAll images and information are retrieved from the EMIT website\nhttps://earth.jpl.nasa.gov/emit/',
      'de':
          'Alle Bilder und Informationen werden von der EMIT-Website abgerufen\nhttps://earth.jpl.nasa.gov/emit/',
      'es':
          'Todas las imágenes e información se obtienen del sitio web de EMIT.\nhttps://earth.jpl.nasa.gov/emit/',
      'fr':
          'Toutes les images et informations sont récupérées sur le site Web d\'EMIT\nhttps://earth.jpl.nasa.gov/emit/',
      'it':
          'Tutte le immagini e le informazioni vengono recuperate dal sito Web EMIT\nhttps://earth.jpl.nasa.gov/emit/',
      'ja':
          'すべての画像と情報はEMIT Webサイトから取得されています。\nhttps://earth.jpl.nasa.gov/emit/',
    },
    'jo40pvrx': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Settings
  {
    'eqttuxkz': {
      'en': 'Settings Page',
      'de': 'Einstellungsseite',
      'es': 'Página de configuración',
      'fr': 'Page Paramètres',
      'it': 'Pagina Impostazioni',
      'ja': '設定ページ',
    },
    'afjx5jhh': {
      'en': 'Please evaluate your options below.',
      'de': 'Bitte bewerten Sie unten Ihre Optionen.',
      'es': 'Evalúe sus opciones a continuación.',
      'fr': 'Veuillez évaluer vos options ci-dessous.',
      'it': 'Si prega di valutare le opzioni di seguito.',
      'ja': '以下のオプションを評価してください。',
    },
    'uz4uwmc4': {
      'en': 'About Us',
      'de': 'Über uns',
      'es': 'Sobre nosotros',
      'fr': 'À propos de nous',
      'it': 'Chi siamo',
      'ja': '私たちについて',
    },
    'mqqutns3': {
      'en': 'Help',
      'de': 'Helfen',
      'es': 'Ayuda',
      'fr': 'Aide',
      'it': 'Aiuto',
      'ja': 'ヘルプ',
    },
    'jv3uwvwz': {
      'en': 'Privacy Policy',
      'de': 'Datenschutzrichtlinie',
      'es': 'política de privacidad',
      'fr': 'politique de confidentialité',
      'it': 'politica sulla riservatezza',
      'ja': 'プライバシーポリシー',
    },
    'ts1c5g59': {
      'en': 'Terms & Conditions',
      'de': 'Terms & amp; Bedingungen',
      'es': 'Términos y condiciones',
      'fr': 'termes et conditions',
      'it': 'Termini & Condizioni',
      'ja': '利用規約',
    },
    'c8d0d6x9': {
      'en': 'Follow us on',
      'de': 'Folge uns auf',
      'es': 'Siga con nosotros',
      'fr': 'Suivez-nous sur',
      'it': 'Seguici su',
      'ja': 'フォローしてください',
    },
    'hfs0n4dg': {
      'en': 'App Versions',
      'de': 'App-Versionen',
      'es': 'Versiones de la aplicación',
      'fr': 'Versions de l\'application',
      'it': 'Versioni dell\'app',
      'ja': 'アプリのバージョン',
    },
    'j74ugs8t': {
      'en': 'v0.0.1',
      'de': 'v0.0.1',
      'es': 'v0.0.1',
      'fr': 'v0.0.1',
      'it': 'v0.0.1',
      'ja': 'v0.0.1',
    },
    'e61v04iv': {
      'en': 'Close app',
      'de': 'App schließen',
      'es': 'Cerrar app',
      'fr': 'Fermer l\'application',
      'it': 'Chiudi l\'app',
      'ja': 'アプリを閉じる',
    },
    'z95jgl9c': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Aboutus
  {
    'f9fag2ok': {
      'en': 'About Us',
      'de': 'Über uns',
      'es': 'Sobre nosotros',
      'fr': 'À propos de nous',
      'it': 'Chi siamo',
      'ja': '私たちについて',
    },
    'xhvz5xmz': {
      'en':
          'Welcome to our app! We are dedicated to providing you with the best experience possible. \nOur team is committed to delivering high-quality information about EMIT.\n If you have any questions or need assistance, please don\'t hesitate to reach out to us.',
      'de':
          'Willkommen in unserer App! Wir sind bestrebt, Ihnen das bestmögliche Erlebnis zu bieten.\nUnser Team ist bestrebt, qualitativ hochwertige Informationen über EMIT bereitzustellen.\n Wenn Sie Fragen haben oder Hilfe benötigen, zögern Sie bitte nicht, uns zu kontaktieren.',
      'es':
          '¡Bienvenido a nuestra aplicación! Estamos dedicados a brindarle la mejor experiencia posible.\nNuestro equipo está comprometido a brindar información de alta calidad sobre EMIT.\n Si tiene alguna pregunta o necesita ayuda, no dude en comunicarse con nosotros.',
      'fr':
          'Bienvenue sur notre application ! Nous nous engageons à vous offrir la meilleure expérience possible.\nNotre équipe s\'engage à fournir des informations de haute qualité sur EMIT.\n Si vous avez des questions ou avez besoin d\'aide, n\'hésitez pas à nous contacter.',
      'it':
          'Benvenuto nella nostra app! Ci impegniamo a fornirti la migliore esperienza possibile.\nIl nostro team si impegna a fornire informazioni di alta qualità su EMIT.\n Se hai domande o hai bisogno di assistenza, non esitare a contattarci.',
      'ja':
          '私たちのアプリへようこそ！私たちは可能な限り最高の体験を提供することに専念しています。\n私たちのチームは、EMIT に関する質の高い情報を提供することに尽力しています。\n ご質問がある場合やサポートが必要な場合は、お気軽にお問い合わせください。',
    },
    'yigkhhd8': {
      'en': 'Thank you for choosing us!',
      'de': 'Danke, daß Sie uns gewählt haben!',
      'es': '¡Gracias por elegirnos!',
      'fr': 'Merci de nous avoir choisi!',
      'it': 'Grazie per averci scelto!',
      'ja': '私達を選んで頂き有難うございます！',
    },
  },
  // Privacy
  {
    'aomlw9sb': {
      'en': 'Privacy Policy',
      'de': 'Datenschutzrichtlinie',
      'es': 'política de privacidad',
      'fr': 'politique de confidentialité',
      'it': 'politica sulla riservatezza',
      'ja': 'プライバシーポリシー',
    },
    'qvum45la': {
      'en':
          'Privacy Policy for EMIT near you\nEffective Date: 08/10/2023\n\n1. Introduction\nWelcome to \"EMIT near you\". This Privacy Policy is designed to help you understand how we safeguard your personal information when you use our mobile application. \n\n2. Information We Collect\n We do not collect this types of information:\n\n 2.1. Personal Information: \nName\nEmail address\nPhone number \n\n2.2. Usage Information:\n Information about your interactions with the App Log data (e.g., IP address, device type, browser type) \n\n2.3. Environmental Data: \nData related to emissions tracking or monitoring (e.g., emissions data, sensor readings) \n\n3. Security \nWe do not take your information. However, please be aware that no method of transmission over the internet or electronic storage is completely secure. \n\n4. Changes to this Privacy Policy We may update this Privacy Policy from time to time. Please review it periodically to stay informed about our information practices. \n\n5. Contact Us if you have any questions or concerns about this Privacy Policy, please contact us.',
      'de':
          'Datenschutzrichtlinie für EMIT in Ihrer Nähe\nDatum des Inkrafttretens: 08.10.2023\n\n1. Einleitung\nWillkommen bei „EMIT in Ihrer Nähe“. Diese Datenschutzrichtlinie soll Ihnen helfen zu verstehen, wie wir Ihre persönlichen Daten schützen, wenn Sie unsere mobile Anwendung nutzen.\n\n2. Informationen, die wir sammeln\n Wir sammeln diese Art von Informationen nicht:\n\n 2.1. Persönliche Angaben:\nName\nE-Mail-Adresse\nTelefonnummer\n\n2.2. Nutzungsinformationen:\n Informationen über Ihre Interaktionen mit den App-Log-Daten (z. B. IP-Adresse, Gerätetyp, Browsertyp)\n\n2.3. Umweltdaten:\nDaten im Zusammenhang mit der Emissionsverfolgung oder -überwachung (z. B. Emissionsdaten, Sensormesswerte)\n\n3. Sicherheit\nWir nehmen Ihre Daten nicht entgegen. Bitte beachten Sie jedoch, dass keine Methode der Übertragung über das Internet oder der elektronischen Speicherung völlig sicher ist.\n\n4. Änderungen dieser Datenschutzrichtlinie Wir können diese Datenschutzrichtlinie von Zeit zu Zeit aktualisieren. Bitte überprüfen Sie es regelmäßig, um über unsere Informationspraktiken auf dem Laufenden zu bleiben.\n\n5. Kontaktieren Sie uns, wenn Sie Fragen oder Bedenken zu dieser Datenschutzrichtlinie haben, kontaktieren Sie uns bitte.',
      'es':
          'Política de privacidad para EMIT cerca de usted\nFecha de vigencia: 10/08/2023\n\n1. Introducción\nBienvenido a \"EMIT cerca de usted\". Esta Política de Privacidad está diseñada para ayudarlo a comprender cómo salvaguardamos su información personal cuando utiliza nuestra aplicación móvil.\n\n2. Información que recopilamos\n No recopilamos este tipo de información:\n\n 2.1. Informacion personal:\nNombre\nDirección de correo electrónico\nNúmero de teléfono\n\n2.2. Información de uso:\n Información sobre sus interacciones con los datos de App Log (por ejemplo, dirección IP, tipo de dispositivo, tipo de navegador)\n\n2.3. Datos ambientales:\nDatos relacionados con el seguimiento o monitoreo de emisiones (por ejemplo, datos de emisiones, lecturas de sensores)\n\n3. Seguridad\nNo tomamos su información. Sin embargo, tenga en cuenta que ningún método de transmisión por Internet o almacenamiento electrónico es completamente seguro.\n\n4. Cambios a esta Política de Privacidad Podemos actualizar esta Política de Privacidad de vez en cuando. Revíselo periódicamente para mantenerse informado sobre nuestras prácticas de información.\n\n5. Contáctenos si tiene alguna pregunta o inquietud sobre esta Política de Privacidad, contáctenos.',
      'fr':
          'Politique de confidentialité pour EMIT près de chez vous\nDate d\'entrée en vigueur : 08/10/2023\n\n1. Introduction\nBienvenue chez \"EMIT près de chez vous\". Cette politique de confidentialité est conçue pour vous aider à comprendre comment nous protégeons vos informations personnelles lorsque vous utilisez notre application mobile.\n\n2. Informations que nous collectons\n Nous ne collectons pas ce type d\'informations :\n\n 2.1. Informations personnelles:\nNom\nAdresse e-mail\nNuméro de téléphone\n\n2.2. Informations d\'utilisation :\n Informations sur vos interactions avec les données App Log (par exemple, adresse IP, type d\'appareil, type de navigateur)\n\n2.3. Données environnementales:\nDonnées liées au suivi ou à la surveillance des émissions (par exemple, données sur les émissions, relevés de capteurs)\n\n3. Sécurité\nNous ne prenons pas vos informations. Cependant, sachez qu’aucune méthode de transmission sur Internet ou de stockage électronique n’est totalement sécurisée.\n\n4. Modifications de cette politique de confidentialité Nous pouvons mettre à jour cette politique de confidentialité de temps à autre. Veuillez le consulter périodiquement pour rester informé de nos pratiques en matière d\'information.\n\n5. Contactez-nous si vous avez des questions ou des préoccupations concernant cette politique de confidentialité, veuillez nous contacter.',
      'it':
          'Informativa sulla privacy per EMIT vicino a te\nData di entrata in vigore: 08/10/2023\n\n1. Introduzione\nBenvenuto a \"EMIT vicino a te\". La presente Informativa sulla privacy è progettata per aiutarti a comprendere come proteggiamo le tue informazioni personali quando utilizzi la nostra applicazione mobile.\n\n2. Informazioni che raccogliamo\n Non raccogliamo questo tipo di informazioni:\n\n 2.1. Informazione personale:\nNome\nIndirizzo e-mail\nNumero di telefono\n\n2.2. Informazioni sull\'utilizzo:\n Informazioni sulle tue interazioni con i dati del registro dell\'app (ad esempio indirizzo IP, tipo di dispositivo, tipo di browser)\n\n2.3. Dati ambientali:\nDati relativi al monitoraggio o al monitoraggio delle emissioni (ad esempio, dati sulle emissioni, letture dei sensori)\n\n3. Sicurezza\nNon prendiamo le tue informazioni. Tuttavia, tieni presente che nessun metodo di trasmissione su Internet o di archiviazione elettronica è completamente sicuro.\n\n4. Modifiche alla presente Informativa sulla privacy Potremmo aggiornare la presente Informativa sulla privacy di tanto in tanto. Si prega di rivederlo periodicamente per rimanere informati sulle nostre pratiche informative.\n\n5. Contattaci Se hai domande o dubbi sulla presente Informativa sulla privacy, ti preghiamo di contattarci.',
      'ja':
          'お近くのEMITのプライバシーポリシー\n発効日: 2023 年 8 月 10 日\n\n1. はじめに\n「あなたの近くのEMIT」へようこそ。このプライバシー ポリシーは、お客様が当社のモバイル アプリケーションを使用する際に当社がお客様の個人情報をどのように保護するかを理解していただくために設計されています。\n\n2. 当社が収集する情報\n 当社は次のような種類の情報を収集しません。\n\n 2.1.個人情報：\n名前\n電子メールアドレス\n電話番号\n\n2.2.使用情報:\n アプリログデータとのやり取りに関する情報 (IP アドレス、デバイスの種類、ブラウザの種類など)\n\n2.3.環境データ:\n排出量の追跡または監視に関連するデータ（排出量データ、センサーの測定値など）\n\n3. セキュリティ\n私たちはあなたの情報を受け取りません。ただし、インターネットや電子ストレージを介した送信方法は完全に安全ではないことに注意してください。\n\n4. このプライバシー ポリシーの変更 当社は、このプライバシー ポリシーを随時更新することがあります。当社の情報慣行について常に最新の情報を得るために、定期的に見直してください。\n\n5. お問い合わせ このプライバシー ポリシーに関してご質問やご不明な点がございましたら、お問い合わせください。',
    },
  },
  // Terms
  {
    '8c06jkfo': {
      'en': 'Terms & Conditions',
      'de': 'Terms & amp; Bedingungen',
      'es': 'Términos y condiciones',
      'fr': 'termes et conditions',
      'it': 'Termini & Condizioni',
      'ja': '利用規約',
    },
    '2n4ludw9': {
      'en':
          'Permission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.',
      'de':
          'Hiermit wird jeder Person, die eine Kopie erhält, kostenlos die Erlaubnis erteilt\ndieser Software und der zugehörigen Dokumentationsdateien (die „Software“) zu handeln\nan der Software ohne Einschränkung, einschließlich und ohne Einschränkung der Rechte\nzum Verwenden, Kopieren, Modifizieren, Zusammenführen, Veröffentlichen, Verteilen, Unterlizenzieren und/oder Verkaufen\nKopien der Software zu erwerben und Personen zu gestatten, denen die Software gehört\nunter folgenden Bedingungen zur Verfügung gestellt:\n\nDer obige Urheberrechtshinweis und dieser Genehmigungshinweis sind in allen Bestandteilen enthalten\nKopien oder wesentliche Teile der Software.\n\nDIE SOFTWARE WIRD „WIE BESEHEN“ ZUR VERFÜGUNG GESTELLT, OHNE JEGLICHE AUSDRÜCKLICHE ODER GEWÄHRLEISTUNG\nSTILLSCHWEIGEND, EINSCHLIESSLICH, ABER NICHT BESCHRÄNKT AUF DIE GARANTIEN DER MARKTGÄNGIGKEIT,\nEIGNUNG FÜR EINEN BESTIMMTEN ZWECK UND NICHTVERLETZUNG. IN KEINEM FALL DÜRFEN DIE\nDie Autoren oder Urheberrechtsinhaber haften für Ansprüche, Schäden oder sonstiges\nHAFTUNG, SEI ES AUS EINEM VERTRAG, EINER HANDLUNG AUS VERLETZLICHER HANDLUNG ODER ANDERWEITIG, ENTSTEHEND AUS:\nAUS ODER IN VERBINDUNG MIT DER SOFTWARE ODER DER NUTZUNG ODER ANDEREN HANDELN IN DER\nSOFTWARE.',
      'es':
          'Por la presente se concede permiso, sin coste alguno, a cualquier persona que obtenga una copia\nde este software y archivos de documentación asociados (el \"Software\"), para tratar\nen el Software sin restricción, incluidos, entre otros, los derechos\nutilizar, copiar, modificar, fusionar, publicar, distribuir, sublicenciar y/o vender\ncopias del Software y para permitir a las personas a quienes el Software es\nproporcionado para ello, sujeto a las siguientes condiciones:\n\nEl aviso de derechos de autor anterior y este aviso de permiso se incluirán en todos\ncopias o partes sustanciales del Software.\n\nEL SOFTWARE SE PROPORCIONA \"TAL CUAL\", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O\nIMPLÍCITAS, INCLUYENDO PERO NO LIMITADO A LAS GARANTÍAS DE COMERCIABILIDAD,\nIDONEIDAD PARA UN FIN PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO EL\nLOS AUTORES O TITULARES DE DERECHOS DE AUTOR SERÁN RESPONSABLES DE CUALQUIER RECLAMACIÓN, DAÑOS U OTROS\nRESPONSABILIDAD, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO O DE OTRA MANERA, QUE SURJA DE,\nFUERA DE O EN RELACIÓN CON EL SOFTWARE O EL USO U OTRAS NEGOCIOS EN EL\nSOFTWARE.',
      'fr':
          'L\'autorisation est accordée gratuitement à toute personne obtenant une copie\nde ce logiciel et des fichiers de documentation associés (le « Logiciel »), pour traiter\ndans le Logiciel sans restriction, y compris, sans limitation, les droits\nutiliser, copier, modifier, fusionner, publier, distribuer, sous-licencier et/ou vendre\ncopies du Logiciel, et pour permettre aux personnes à qui le Logiciel est\nfourni à cet effet, sous réserve des conditions suivantes :\n\nL\'avis de droit d\'auteur ci-dessus et cet avis d\'autorisation doivent être inclus dans tous\ndes copies ou des parties substantielles du logiciel.\n\nLE LOGICIEL EST FOURNI « TEL QUEL », SANS GARANTIE D\'AUCUNE SORTE, EXPRESSE OU\nIMPLICITES, Y COMPRIS MAIS SANS LIMITATION LES GARANTIES DE QUALITÉ MARCHANDE,\nAPTITUDE À UN USAGE PARTICULIER ET NON-VIOLATION. EN AUCUN CAS LE\nLES AUTEURS OU TITULAIRES DES DROITS D\'AUTEUR SONT RESPONSABLES DE TOUTE RÉCLAMATION, DOMMAGES OU AUTRES\nRESPONSABILITÉ, QUE CE SOIT DANS UNE ACTION CONTRACTUELLE, DÉLIT OU AUTRE, DÉCOULANT DE,\nEN RAISON OU EN RELATION AVEC LE LOGICIEL OU L\'UTILISATION OU D\'AUTRES TRANSACTIONS DANS LE\nLOGICIEL.',
      'it':
          'L\'autorizzazione è concessa, gratuitamente, a chiunque ne ottenga una copia\ndi questo software e dei file di documentazione associati (il \"Software\"), da trattare\nnel Software senza restrizioni, inclusi senza limitazione i diritti\nutilizzare, copiare, modificare, unire, pubblicare, distribuire, concedere in sublicenza e/o vendere\ncopie del Software e per consentire alle persone a cui è destinato il Software\nattrezzato per farlo, alle seguenti condizioni:\n\nL\'avviso di copyright di cui sopra e il presente avviso di autorizzazione devono essere inclusi in tutti\ncopie o parti sostanziali del Software.\n\nIL SOFTWARE VIENE FORNITO \"COSÌ COM\'È\", SENZA GARANZIA DI ALCUN TIPO, ESPRESSA O\nIMPLICITE, INCLUSE MA NON LIMITATE ALLE GARANZIE DI COMMERCIABILITÀ,\nIDONEITÀ PER UNO SCOPO PARTICOLARE E NON VIOLAZIONE. IN NESSUN CASO IL\nGLI AUTORI O I DETENTORI DEL COPYRIGHT SARANNO RESPONSABILI PER QUALSIASI RECLAMO, DANNI O ALTRO\nRESPONSABILITÀ, SIA IN AZIONE CONTRATTUALE, ILLECITA O ALTRIMENTI, DERIVANTE DA:\nDA O IN CONNESSIONE CON IL SOFTWARE O L\'UTILIZZO O ALTRI RAPPORTI IN\nSOFTWARE.',
      'ja':
          'ここに、コピーを入手する人には無償で許可が与えられます。\nこのソフトウェアおよび関連ドキュメント ファイル (以下「ソフトウェア」) を取り扱うため、\n権利を含むがこれに限定されない、ソフトウェア内の\n使用、コピー、変更、マージ、公開、配布、サブライセンス、および/または販売すること\nソフトウェアのコピー、およびソフトウェアのコピーを他人に許可すること\n以下の条件に従って、そうするために提供されます。\n\n上記の著作権表示とこの許可表示は、すべてのコンテンツに含まれるものとします。\nソフトウェアのコピーまたは実質的な部分。\n\nソフトウェアは「現状のまま」提供され、明示的または明示的を問わず、いかなる種類の保証もありません。\n商品性の保証を含みますがこれに限定されない黙示的、\n特定の目的への適合性および非侵害。いかなる場合も、\n著者または著作権所有者は、あらゆる請求、損害、その他について責任を負います。\n契約行為、不法行為、その他に起因する責任\nソフトウェアまたはソフトウェアの使用またはその他の取引に関連して、またはそれに関連して\nソフトウェア。',
    },
  },
  // Help
  {
    '6akp8rma': {
      'en': 'Help',
      'de': 'Helfen',
      'es': 'Ayuda',
      'fr': 'Aide',
      'it': 'Aiuto',
      'ja': 'ヘルプ',
    },
    '0m69w7lo': {
      'en':
          'If you are having truble with our app, we are happy to help you.\nPlease feel free to contact us at:\n\nhyperspectral.app@gmail.com\n\n',
      'de':
          'Wenn Sie Probleme mit unserer App haben, helfen wir Ihnen gerne weiter.\nKontaktieren Sie uns gerne unter:\n\nhyperspectral.app@gmail.com',
      'es':
          'Si tiene problemas con nuestra aplicación, estaremos encantados de ayudarle.\nPor favor no dude en contactarnos en:\n\nhiperespectral.app@gmail.com',
      'fr':
          'Si vous rencontrez des problèmes avec notre application, nous serons heureux de vous aider.\nN\'hésitez pas à nous contacter à :\n\nhyperspectral.app@gmail.com',
      'it':
          'Se riscontri problemi con la nostra app, saremo felici di aiutarti.\nNon esitate a contattarci a:\n\nhyperspectral.app@gmail.com',
      'ja':
          '私たちのアプリに問題がある場合は、喜んでサポートさせていただきます。\nお気軽に下記までお問い合わせください。\n\nhyperspectral.app@gmail.com',
    },
    'sg2kgpoc': {
      'en': 'Thank you for choosing us!',
      'de': 'Danke, daß Sie uns gewählt haben!',
      'es': '¡Gracias por elegirnos!',
      'fr': 'Merci de nous avoir choisi!',
      'it': 'Grazie per averci scelto!',
      'ja': '私達を選んで頂き有難うございます！',
    },
  },
  // Importanceofthedust
  {
    'je4n54em': {
      'en':
          'The effects of airborne dust go beyond congesting noses or irritating lungs, research has shown that dust can fertilize rainforests and algae blooms while also affecting the rate at which snow melts, and there is more to learn about how dust might affect climate and weather.\nThe EMIT mission aims to advance climate researchers\' understanding of those effects.\n\nDarker-color dust tends to absorb more energy from the Sun, heating the surrounding air, while lighter-color dust tends to reflect solar energy back to space, cooling the air around it.\nIron-rich dust: typically dark red and tends to absorb more energy.\nclay-rich dust: pale yellow or white and tends to be more reflective.\n\nHeating and cooling can influence the temperature of the atmosphere (radiative forcing), which, in turn, can affect where and when precipitation occurs\n',
      'de':
          'Die Auswirkungen von Staub in der Luft gehen über eine verstopfte Nase oder eine Reizung der Lunge hinaus. Untersuchungen haben gezeigt, dass Staub Regenwälder und Algenblüten düngen und gleichzeitig die Schneeschmelzgeschwindigkeit beeinflussen kann. Darüber hinaus gibt es noch mehr darüber zu erfahren, wie sich Staub auf Klima und Wetter auswirken kann.\nDie EMIT-Mission zielt darauf ab, das Verständnis der Klimaforscher über diese Auswirkungen zu verbessern.\n\nDunklerer Staub neigt dazu, mehr Energie von der Sonne zu absorbieren und erwärmt die Umgebungsluft, während hellerer Staub dazu neigt, Sonnenenergie zurück in den Weltraum zu reflektieren und so die Luft um ihn herum abzukühlen.\nEisenreicher Staub: typischerweise dunkelrot und neigt dazu, mehr Energie zu absorbieren.\nTonreicher Staub: blassgelb oder weiß und tendenziell stärker reflektierend.\n\nErwärmung und Kühlung können die Temperatur der Atmosphäre beeinflussen (Strahlungsantrieb), was wiederum Einfluss darauf haben kann, wo und wann Niederschläge auftreten',
      'es':
          'Los efectos del polvo en el aire van más allá de congestionar la nariz o irritar los pulmones; las investigaciones han demostrado que el polvo puede fertilizar las selvas tropicales y la proliferación de algas, al mismo tiempo que afecta la velocidad a la que se derrite la nieve, y hay más que aprender sobre cómo el polvo podría afectar el clima y el tiempo.\nLa misión EMIT tiene como objetivo mejorar la comprensión de esos efectos por parte de los investigadores del clima.\n\nEl polvo de color más oscuro tiende a absorber más energía del Sol, calentando el aire circundante, mientras que el polvo de color más claro tiende a reflejar la energía solar de regreso al espacio, enfriando el aire a su alrededor.\nPolvo rico en hierro: normalmente de color rojo oscuro y tiende a absorber más energía.\nPolvo rico en arcilla: amarillo pálido o blanco y tiende a ser más reflectante.\n\nEl calentamiento y el enfriamiento pueden influir en la temperatura de la atmósfera (forzamiento radiativo), lo que, a su vez, puede afectar dónde y cuándo se produce la precipitación.',
      'fr':
          'Les effets de la poussière en suspension dans l’air vont au-delà de la congestion nasale ou de l’irritation des poumons. Des recherches ont montré que la poussière peut fertiliser les forêts tropicales et favoriser la prolifération d’algues tout en affectant la vitesse de fonte des neiges. Il reste encore beaucoup à apprendre sur la façon dont la poussière pourrait affecter le climat et la météo.\nLa mission EMIT vise à faire progresser la compréhension de ces effets par les climatologues.\n\nLa poussière de couleur plus foncée a tendance à absorber plus d\'énergie du Soleil, chauffant l\'air ambiant, tandis que la poussière de couleur plus claire a tendance à réfléchir l\'énergie solaire vers l\'espace, refroidissant l\'air qui l\'entoure.\nPoussière riche en fer : généralement rouge foncé et a tendance à absorber plus d\'énergie.\npoussière riche en argile : jaune pâle ou blanche et a tendance à être plus réfléchissante.\n\nLe chauffage et le refroidissement peuvent influencer la température de l’atmosphère (forçage radiatif), ce qui, à son tour, peut affecter le lieu et le moment où les précipitations se produisent.',
      'it':
          'Gli effetti della polvere nell’aria vanno oltre la congestione del naso o l’irritazione dei polmoni, la ricerca ha dimostrato che la polvere può fertilizzare le foreste pluviali e la fioritura delle alghe, influenzando anche la velocità con cui la neve si scioglie, e c’è altro da imparare su come la polvere potrebbe influenzare il clima e il tempo.\nLa missione EMIT mira a migliorare la comprensione di tali effetti da parte dei ricercatori climatici.\n\nLa polvere di colore più scuro tende ad assorbire più energia dal Sole, riscaldando l’aria circostante, mentre la polvere di colore più chiaro tende a riflettere l’energia solare nello spazio, raffreddando l’aria circostante.\nPolvere ricca di ferro: tipicamente di colore rosso scuro e tende ad assorbire più energia.\npolvere ricca di argilla: giallo pallido o bianca e tendenzialmente più riflettente.\n\nIl riscaldamento e il raffreddamento possono influenzare la temperatura dell’atmosfera (forzatura radiativa), che, a sua volta, può influenzare dove e quando si verificano le precipitazioni',
      'ja':
          '空気中の粉塵の影響は、鼻づまりや肺の炎症だけにとどまらず、粉塵が熱帯雨林や藻類の繁殖を肥やしにする一方で、雪が溶ける速度にも影響を与えることが研究で示されており、粉塵が気候や天候にどのような影響を与えるかについては、さらに学ぶべきことが残っています。\nEMIT ミッションは、気候研究者のそれらの影響についての理解を進めることを目的としています。\n\n色の濃い塵は太陽からより多くのエネルギーを吸収して周囲の空気を加熱する傾向があり、一方、色の明るい塵は太陽エネルギーを宇宙に反射して周囲の空気を冷やす傾向があります。\n鉄分が豊富な粉塵: 通常は暗赤色で、より多くのエネルギーを吸収する傾向があります。\n粘土を多く含む粉塵: 淡黄色または白色で、より反射する傾向があります。\n\n加熱と冷却は大気の温度 (放射力) に影響を与える可能性があり、その結果、降水が発生する場所と時期に影響を与える可能性があります。',
    },
    '0d6v5e8v': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'wm8hnrre': {
      'en': 'Importance of the dust',
      'de': 'Bedeutung des Staubes',
      'es': 'Importancia del polvo',
      'fr': 'Importance de la poussière',
      'it': 'Importanza della polvere',
      'ja': '塵の大切さ',
    },
    'nte6g5rt': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // ImagingSpectrometer
  {
    'k0ue1hyn': {
      'en':
          'Swath: 72Km\n\nSpectral Range: 380 – 2500 nm, it observes about 7 times the range of the human-observable (Human eye can see between 400-700 nm)\n\nSpatial sampling : 60m with 1200 cross-track\n\nIFOV: 155 x 71 μrad (variation below 10%)\n\nF/1.8 Dyson spectrometer\n\nFocal length: 193.5 mm\n',
      'de':
          'Schwad: 72 km\n\nSpektralbereich: 380–2500 nm, beobachtet etwa das Siebenfache des vom Menschen beobachtbaren Bereichs (das menschliche Auge kann zwischen 400–700 nm sehen).\n\nRäumliche Probenahme: 60 m mit 1200 Querspuren\n\nIFOV: 155 x 71 μrad (Variation unter 10 %)\n\nF/1,8 Dyson-Spektrometer\n\nBrennweite: 193,5 mm',
      'es':
          'Franja: 72Km\n\nRango espectral: 380 – 2500 nm, observa aproximadamente 7 veces el rango de lo observable por humanos (el ojo humano puede ver entre 400 y 700 nm)\n\nMuestreo espacial: 60 m con 1200 cross-track\n\nIFOV: 155 x 71 μrad (variación inferior al 10%)\n\nEspectrómetro Dyson F/1.8\n\nLongitud focal: 193,5 mm',
      'fr':
          'Bande : 72 km\n\nPortée spectrale : 380 à 2 500 nm, il observe environ 7 fois la portée observable par l\'homme (l\'œil humain peut voir entre 400 et 700 nm)\n\nEchantillonnage spatial : 60m avec 1200 cross-track\n\nIFOV : 155 x 71 μrad (variation inférieure à 10 %)\n\nSpectromètre Dyson F/1.8\n\nDistance focale : 193,5 mm',
      'it':
          'Andata: 72Km\n\nGamma spettrale: 380 – 2500 nm, osserva circa 7 volte la gamma dell\'osservabile umano (l\'occhio umano può vedere tra 400-700 nm)\n\nCampionamento spaziale: 60 m con 1200 cross-track\n\nIFOV: 155 x 71 μrad (variazione inferiore al 10%)\n\nSpettrometro Dyson F/1.8\n\nLunghezza focale: 193,5 mm',
      'ja':
          '範囲: 72Km\n\nスペクトル範囲: 380 – 2500 nm、人間が観察できる範囲の約 7 倍を観察します (人間の目は 400 ～ 700 nm の間を見ることができます)\n\n空間サンプリング: 60m、1200 クロストラック\n\nIFOV: 155 x 71 μrad (変動は 10% 未満)\n\nF/1.8 ダイソン分光計\n\n焦点距離：193.5mm',
    },
    'v5jqq5j2': {
      'en':
          'EMIT uses an advanced two mirror telescope and high throughput F/1.8 Dyson imaging spectrometer. The telescope focuses light entering EMIT on the spectrometer slit where it passed through calcium fluoride crystal refractive element to the grating. \nThe concave grating has a structured blaze written by electron beam lithography to optimize the diffraction efficiency over the full spectral range. After being dispersed into the spectrum by the grating, light passes back through CaF2 block to the order sorting filter and detector array.',
      'de':
          'EMIT verwendet ein fortschrittliches Zweispiegelteleskop und ein F/1,8-Dyson-Bildgebungsspektrometer mit hohem Durchsatz. Das Teleskop fokussiert das in EMIT eintretende Licht auf den Spektrometerspalt, wo es durch das brechende Kalziumfluorid-Kristallelement zum Gitter gelangt.\nDas konkave Gitter verfügt über eine durch Elektronenstrahllithographie geschriebene strukturierte Markierung, um die Beugungseffizienz über den gesamten Spektralbereich zu optimieren. Nachdem das Licht durch das Gitter im Spektrum zerstreut wurde, gelangt es durch den CaF2-Block zurück zum Ordnungsfilter und zum Detektorarray.',
      'es':
          'EMIT utiliza un telescopio avanzado de dos espejos y un espectrómetro de imágenes Dyson F/1.8 de alto rendimiento. El telescopio enfoca la luz que ingresa a EMIT en la rendija del espectrómetro, donde pasa a través del elemento refractivo de cristal de fluoruro de calcio hasta la rejilla.\nLa rejilla cóncava tiene un resplandor estructurado escrito mediante litografía por haz de electrones para optimizar la eficiencia de difracción en todo el rango espectral. Después de ser dispersada en el espectro por la rejilla, la luz regresa a través del bloque CaF2 al filtro de clasificación de orden y al conjunto de detectores.',
      'fr':
          'EMIT utilise un télescope avancé à deux miroirs et un spectromètre d’imagerie Dyson F/1.8 à haut débit. Le télescope concentre la lumière entrant dans EMIT sur la fente du spectromètre où elle passe à travers l\'élément réfractif du cristal de fluorure de calcium jusqu\'au réseau.\nLe réseau concave présente une flamme structurée écrite par lithographie par faisceau d\'électrons pour optimiser l\'efficacité de diffraction sur toute la plage spectrale. Après avoir été dispersée dans le spectre par le réseau, la lumière repasse à travers le bloc CaF2 vers le filtre de tri d\'ordre et le réseau de détecteurs.',
      'it':
          'EMIT utilizza un avanzato telescopio a due specchi e uno spettrometro per immagini Dyson F/1.8 ad alta produttività. Il telescopio concentra la luce che entra nell\'EMIT sulla fenditura dello spettrometro dove passa attraverso l\'elemento rifrattivo del cristallo di fluoruro di calcio fino al reticolo.\nIl reticolo concavo ha una fiammata strutturata scritta mediante litografia a fascio di elettroni per ottimizzare l\'efficienza di diffrazione sull\'intero intervallo spettrale. Dopo essere stata dispersa nello spettro dal reticolo, la luce ritorna attraverso il blocco CaF2 al filtro di ordinamento e alla serie di rilevatori.',
      'ja':
          'EMIT は、高度な 2 ミラー望遠鏡と高スループット F/1.8 ダイソン イメージング分光計を使用します。望遠鏡は、EMIT に入射する光を分光計のスリットに集束させ、そこでフッ化カルシウム結晶の屈折素子を通過して回折格子に達します。\n凹面格子には、電子ビーム リソグラフィーによって描画された構造化されたブレーズがあり、スペクトル範囲全体にわたって回折効率が最適化されます。回折格子によってスペクトルに分散された後、光は CaF2 ブロックを通って次数分類フィルターと検出器アレイに戻ります。',
    },
    '5yumdgr6': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'ixwes5m2': {
      'en': 'Imaging Spectrometer',
      'de': 'Bildgebendes Spektrometer',
      'es': 'Espectrómetro de imágenes',
      'fr': 'Spectromètre imageur',
      'it': 'Spettrometro per immagini',
      'ja': 'イメージング分光計',
    },
    'b6rx58fh': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // HowdoesEMITwork
  {
    'pcc16yl9': {
      'en':
          'Reflected sunlight enters through the opening into the instrument’s telescope, where two highly polished, silver-coated mirrors direct the light into a state-of-the-art imaging spectrometer, which analyzes light reflected off distant objects to determine what they are made of, down to the molecule.\n\nIn the spectrometer, light passes through a calcium fluoride lens called a Dyson block. The lens focuses the light onto a specially shaped reflection grating whose microscopic grooves divide the light rays into hundreds of distinct colors and direct them to a detector array. \n\nThe detector array has 1,280 columns aligned with the flight direction of the space station. With 480 light-sensing elements, each column is effectively its own spectrometer that records visible to short wavelength infrared (VSWIR) light as the instrument orbits over arid dust-source zones.\n\nOver the course of its mission, EMIT will collect more than 1 billion usable measurements — each a snapshot of the color and composition of a roughly 200-foot-by-200-foot (60-meter-by-60-meter) patch on the surface, an area about the size of a soccer field.\n',
      'de':
          'Reflektiertes Sonnenlicht gelangt durch die Öffnung in das Teleskop des Instruments, wo zwei hochglanzpolierte, silberbeschichtete Spiegel das Licht in ein hochmodernes Bildspektrometer leiten, das das von entfernten Objekten reflektierte Licht analysiert, um festzustellen, woraus sie bestehen. bis hin zum Molekül.\n\nIm Spektrometer passiert das Licht eine Kalziumfluoridlinse, die als Dyson-Block bezeichnet wird. Die Linse fokussiert das Licht auf ein speziell geformtes Reflexionsgitter, dessen mikroskopisch kleine Rillen die Lichtstrahlen in Hunderte verschiedener Farben aufteilen und sie zu einem Detektorarray leiten.\n\nDas Detektorarray besteht aus 1.280 Spalten, die an der Flugrichtung der Raumstation ausgerichtet sind. Mit 480 lichtempfindlichen Elementen ist jede Säule praktisch ein eigenes Spektrometer, das sichtbares bis kurzwelliges Infrarotlicht (VSWIR) aufzeichnet, während das Instrument über trockene Staubquellenzonen kreist.\n\nIm Laufe seiner Mission wird EMIT mehr als eine Milliarde verwertbare Messungen sammeln – jeweils eine Momentaufnahme der Farbe und Zusammensetzung eines etwa 200 Fuß mal 200 Fuß (60 Meter mal 60 Meter) großen Flecks die Oberfläche, eine Fläche etwa von der Größe eines Fußballfeldes.',
      'es':
          'La luz solar reflejada ingresa a través de la abertura del telescopio del instrumento, donde dos espejos recubiertos de plata altamente pulidos dirigen la luz hacia un espectrómetro de imágenes de última generación, que analiza la luz reflejada por objetos distantes para determinar de qué están hechos. hasta la molécula.\n\nEn el espectrómetro, la luz pasa a través de una lente de fluoruro de calcio llamada bloque Dyson. La lente enfoca la luz en una rejilla de reflexión de forma especial cuyas ranuras microscópicas dividen los rayos de luz en cientos de colores distintos y los dirigen a un conjunto de detectores.\n\nEl conjunto de detectores tiene 1.280 columnas alineadas con la dirección de vuelo de la estación espacial. Con 480 elementos sensores de luz, cada columna es efectivamente su propio espectrómetro que registra la luz visible en el infrarrojo de longitud de onda corta (VSWIR) mientras el instrumento orbita sobre zonas áridas con fuentes de polvo.\n\nEn el transcurso de su misión, EMIT recopilará más de mil millones de mediciones utilizables, cada una de las cuales será una instantánea del color y la composición de un parche de aproximadamente 200 pies por 200 pies (60 metros por 60 metros) en la superficie, un área del tamaño de un campo de fútbol.',
      'fr':
          'La lumière solaire réfléchie pénètre par l\'ouverture du télescope de l\'instrument, où deux miroirs argentés hautement polis dirigent la lumière vers un spectromètre imageur de pointe, qui analyse la lumière réfléchie par des objets distants pour déterminer de quoi ils sont faits. jusqu\'à la molécule.\n\nDans le spectromètre, la lumière traverse une lentille en fluorure de calcium appelée bloc Dyson. La lentille concentre la lumière sur un réseau de réflexion de forme spéciale dont les rainures microscopiques divisent les rayons lumineux en centaines de couleurs distinctes et les dirigent vers un réseau de détecteurs.\n\nLe réseau de détecteurs comporte 1 280 colonnes alignées avec la direction de vol de la station spatiale. Avec 480 éléments de détection de lumière, chaque colonne est en fait son propre spectromètre qui enregistre la lumière infrarouge visible à courte longueur d\'onde (VSWIR) lorsque l\'instrument orbite au-dessus des zones arides de sources de poussière.\n\nAu cours de sa mission, EMIT collectera plus d\'un milliard de mesures utilisables, chacune étant un instantané de la couleur et de la composition d\'un patch d\'environ 200 pieds sur 200 pieds (60 mètres sur 60 mètres). la surface, une zone de la taille d’un terrain de football.',
      'it':
          'La luce solare riflessa entra attraverso l\'apertura nel telescopio dello strumento, dove due specchi lucidati e rivestiti in argento dirigono la luce in uno spettrometro per immagini all\'avanguardia, che analizza la luce riflessa dagli oggetti distanti per determinare di cosa sono fatti, fino alla molecola.\n\nNello spettrometro, la luce passa attraverso una lente al fluoruro di calcio chiamata blocco Dyson. La lente focalizza la luce su un reticolo di riflessione dalla forma speciale le cui scanalature microscopiche dividono i raggi luminosi in centinaia di colori distinti e li dirigono verso una serie di rilevatori.\n\nLa serie di rilevatori ha 1.280 colonne allineate con la direzione di volo della stazione spaziale. Con 480 elementi di rilevamento della luce, ciascuna colonna è effettivamente il proprio spettrometro che registra la luce visibile agli infrarossi a lunghezza d\'onda corta (VSWIR) mentre lo strumento orbita su zone aride sorgenti di polvere.\n\nNel corso della sua missione, EMIT raccoglierà più di 1 miliardo di misurazioni utilizzabili, ciascuna un\'istantanea del colore e della composizione di un\'area di circa 200 piedi per 200 piedi (60 metri per 60 metri) su la superficie, un\'area grande all\'incirca quanto un campo da calcio.',
      'ja':
          '反射した太陽光は開口部を通って装置の望遠鏡に入り、そこで高度に磨かれた銀コーティングされた 2 つの鏡が光を最先端の画像分光計に導き、遠方の物体から反射された光を分析してその物体が何でできているかを判断します。分子まで。\n\n分光計では、光はダイソン ブロックと呼ばれるフッ化カルシウム レンズを通過します。レンズは、特別な形状の反射格子上に光の焦点を合わせ、その微細な溝が光線を何百もの異なる色に分割し、検出器アレイに導きます。\n\n検出器アレイには、宇宙ステーションの飛行方向に沿って配置された 1,280 個の列があります。 480 個の光検出素子を備えた各カラムは、実質的に独自の分光計となり、機器が乾燥した塵源ゾーン上を周回するときに可視から短波長赤外 (VSWIR) 光を記録します。\n\nミッションの過程で、EMIT は 10 億を超える使用可能な測定値を収集します。それぞれの測定値は、およそ 200 フィート×200 フィート (60 メートル×60 メートル) のパッチの色と構成のスナップショットです。表面、サッカー場ほどの大きさのエリア。',
    },
    'cshun96q': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '4cpumaf4': {
      'en': 'How does EMIT work?',
      'de': 'Wie funktioniert EMIT?',
      'es': '¿Cómo funciona EMIT?',
      'fr': 'Comment fonctionne EMIT ?',
      'it': 'Come funziona EMIT?',
      'ja': 'EMITはどのように機能しますか?',
    },
    '5b65gjxu': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Aboutthemission
  {
    'fn07miyp': {
      'en':
          'When strong winds on one continent stir up mineral rock dust (such as calcite or chlorite), the airborne particles can travel thousands of miles to affect entirely different continents. Dust suspended in the air can heat or cool the atmosphere and Earth\'s surface. This heating or cooling effect is the focus of NASA’s Earth Surface Mineral Dust Source Investigation (EMIT) mission.\n\nMineral dust has many other effects on our planet. It can help form clouds or change atmospheric chemistry. When the dust settles in water or on land it can provide nutrients for ecosystem growth. If it falls on snow or ice, mineral dust can increase sunlight absorption and accelerate melting. Mineral dust in the air can reduce visibility or harm human health.\n',
      'de':
          'Wenn starke Winde auf einem Kontinent mineralischen Gesteinsstaub (wie Calcit oder Chlorit) aufwirbeln, können die in der Luft schwebenden Partikel Tausende von Kilometern zurücklegen und völlig andere Kontinente befallen. In der Luft schwebender Staub kann die Atmosphäre und die Erdoberfläche erwärmen oder abkühlen. Dieser Erwärmungs- oder Kühleffekt steht im Mittelpunkt der NASA-Mission Earth Surface Mineral Dust Source Investigation (EMIT).\n\nMineralstaub hat viele weitere Auswirkungen auf unseren Planeten. Es kann zur Bildung von Wolken beitragen oder die Chemie der Atmosphäre verändern. Wenn sich der Staub im Wasser oder an Land ablagert, kann er Nährstoffe für das Ökosystemwachstum liefern. Fällt er auf Schnee oder Eis, kann Mineralstaub die Absorption des Sonnenlichts erhöhen und das Schmelzen beschleunigen. Mineralstaub in der Luft kann die Sicht beeinträchtigen oder die menschliche Gesundheit schädigen.',
      'es':
          'Cuando los fuertes vientos en un continente levantan polvo de roca mineral (como calcita o clorita), las partículas en el aire pueden viajar miles de kilómetros y afectar continentes completamente diferentes. El polvo suspendido en el aire puede calentar o enfriar la atmósfera y la superficie de la Tierra. Este efecto de calentamiento o enfriamiento es el foco de la misión de Investigación de la Fuente de Polvo Mineral de la Superficie Terrestre (EMIT) de la NASA.\n\nEl polvo mineral tiene muchos otros efectos en nuestro planeta. Puede ayudar a formar nubes o cambiar la química atmosférica. Cuando el polvo se deposita en el agua o en la tierra, puede proporcionar nutrientes para el crecimiento del ecosistema. Si cae sobre nieve o hielo, el polvo mineral puede aumentar la absorción de luz solar y acelerar el derretimiento. El polvo mineral en el aire puede reducir la visibilidad o dañar la salud humana.',
      'fr':
          'Lorsque des vents forts sur un continent soulèvent de la poussière de roche minérale (telle que la calcite ou la chlorite), les particules en suspension dans l\'air peuvent parcourir des milliers de kilomètres et affecter des continents complètement différents. La poussière en suspension dans l\'air peut réchauffer ou refroidir l\'atmosphère et la surface de la Terre. Cet effet de chauffage ou de refroidissement est au centre de la mission Earth Surface Mineral Dust Source Investigation (EMIT) de la NASA.\n\nLes poussières minérales ont bien d’autres effets sur notre planète. Cela peut aider à former des nuages ​​ou à modifier la chimie atmosphérique. Lorsque la poussière se dépose dans l’eau ou sur la terre, elle peut fournir des éléments nutritifs nécessaires à la croissance des écosystèmes. Si elle tombe sur la neige ou la glace, la poussière minérale peut augmenter l\'absorption de la lumière solaire et accélérer la fonte. La poussière minérale présente dans l’air peut réduire la visibilité ou nuire à la santé humaine.',
      'it':
          'Quando forti venti in un continente sollevano la polvere di roccia minerale (come calcite o clorite), le particelle sospese nell’aria possono viaggiare per migliaia di chilometri per colpire continenti completamente diversi. La polvere sospesa nell\'aria può riscaldare o raffreddare l\'atmosfera e la superficie terrestre. Questo effetto di riscaldamento o raffreddamento è al centro della missione EMIT (Earth Surface Mineral Dust Source Investigation) della NASA.\n\nLa polvere minerale ha molti altri effetti sul nostro pianeta. Può aiutare a formare nuvole o cambiare la chimica atmosferica. Quando la polvere si deposita nell’acqua o sulla terra può fornire nutrienti per la crescita dell’ecosistema. Se cade su neve o ghiaccio, la polvere minerale può aumentare l’assorbimento della luce solare e accelerarne lo scioglimento. La polvere minerale nell\'aria può ridurre la visibilità o danneggiare la salute umana.',
      'ja':
          'ある大陸で強風が鉱物岩の粉塵（方解石や緑泥石など）を巻き上げると、浮遊粒子は数千マイルも移動して、まったく別の大陸に影響を与える可能性があります。空気中に浮遊する塵は、大気や地表を加熱または冷却する可能性があります。この加熱または冷却効果は、NASA の地球表面鉱物粉塵源調査 (EMIT) ミッションの焦点です。\n\nミネラルダストは地球に他にも多くの影響を与えます。それは雲の形成や大気の化学変化に役立ちます。粉塵が水中または陸上に沈むと、生態系の成長に栄養を与えることができます。雪や氷の上に降ると、鉱物の粉塵が太陽光の吸収を増加させ、融解を促進する可能性があります。空気中の鉱物粉塵は視界を悪くしたり、人間の健康に害を及ぼす可能性があります。',
    },
    'acx4r2ea': {
      'en':
          'Scientists know that most of the mineral dust transported in Earth’s atmosphere comes from arid, or dry, regions around the globe. But they aren’t certain what types of minerals the wind carries from those regions. Different minerals affect the environment in different ways. So scientists need to know what minerals are in dust source regions if they’re going to better understand how the dust is affecting the Earth. EMIT will provide this missing dust source information.\n\nThe data will allow scientists to create a new mineral map of Earth’s dust-producing regions. The map will improve computer models that scientists will use to assess the regional and global heating and cooling effects of mineral dust today and in the future.\n',
      'de':
          'Wissenschaftler wissen, dass der Großteil des in der Erdatmosphäre transportierten Mineralstaubs aus trockenen Regionen auf der ganzen Welt stammt. Sie sind sich jedoch nicht sicher, welche Arten von Mineralien der Wind aus diesen Regionen trägt. Verschiedene Mineralien wirken sich auf unterschiedliche Weise auf die Umwelt aus. Wissenschaftler müssen also wissen, welche Mineralien in Staubquellenregionen vorkommen, wenn sie besser verstehen wollen, wie sich der Staub auf die Erde auswirkt. EMIT wird diese fehlenden Staubquelleninformationen bereitstellen.\n\nDie Daten werden es Wissenschaftlern ermöglichen, eine neue Mineralkarte der staubproduzierenden Regionen der Erde zu erstellen. Die Karte wird Computermodelle verbessern, mit denen Wissenschaftler die regionalen und globalen Erwärmungs- und Abkühlungseffekte von Mineralstaub heute und in Zukunft bewerten werden.',
      'es':
          'Los científicos saben que la mayor parte del polvo mineral transportado en la atmósfera de la Tierra proviene de regiones áridas o secas de todo el mundo. Pero no están seguros de qué tipos de minerales transporta el viento desde esas regiones. Los diferentes minerales afectan el medio ambiente de diferentes maneras. Por lo tanto, los científicos necesitan saber qué minerales hay en las regiones de origen del polvo si quieren comprender mejor cómo el polvo está afectando a la Tierra. EMIT proporcionará esta información sobre la fuente de polvo faltante.\n\nLos datos permitirán a los científicos crear un nuevo mapa mineral de las regiones productoras de polvo de la Tierra. El mapa mejorará los modelos informáticos que los científicos utilizarán para evaluar los efectos de calentamiento y enfriamiento regionales y globales del polvo mineral hoy y en el futuro.',
      'fr':
          'Les scientifiques savent que la majeure partie de la poussière minérale transportée dans l’atmosphère terrestre provient de régions arides ou sèches du monde entier. Mais ils ne savent pas exactement quels types de minéraux le vent transporte depuis ces régions. Différents minéraux affectent l\'environnement de différentes manières. Les scientifiques doivent donc savoir quels minéraux se trouvent dans les régions sources de poussière s’ils veulent mieux comprendre comment la poussière affecte la Terre. EMIT fournira ces informations manquantes sur la source de poussière.\n\nLes données permettront aux scientifiques de créer une nouvelle carte minérale des régions productrices de poussière de la Terre. La carte améliorera les modèles informatiques que les scientifiques utiliseront pour évaluer les effets régionaux et mondiaux de réchauffement et de refroidissement des poussières minérales, aujourd\'hui et à l\'avenir.',
      'it':
          'Gli scienziati sanno che la maggior parte della polvere minerale trasportata nell’atmosfera terrestre proviene da regioni aride o secche di tutto il mondo. Ma non sono sicuri di quali tipi di minerali il vento trasporta da quelle regioni. Diversi minerali influenzano l’ambiente in modi diversi. Quindi gli scienziati devono sapere quali minerali ci sono nelle regioni di origine della polvere se vogliono capire meglio come la polvere sta influenzando la Terra. EMIT fornirà queste informazioni sulla fonte di polvere mancante.\n\nI dati consentiranno agli scienziati di creare una nuova mappa minerale delle regioni produttrici di polvere della Terra. La mappa migliorerà i modelli computerizzati che gli scienziati utilizzeranno per valutare gli effetti di riscaldamento e raffreddamento regionali e globali della polvere minerale oggi e in futuro.',
      'ja':
          '科学者たちは、地球の大気中に運ばれる鉱物粉塵のほとんどが、世界中の乾燥した地域から来ていることを知っています。しかし、風がそれらの地域からどのような種類の鉱物を運んでくるのかは定かではありません。鉱物が異なれば、環境にさまざまな影響を与えます。したがって、科学者は、塵が地球にどのような影響を与えているかをよりよく理解したい場合、塵の発生源地域にどのような鉱物があるかを知る必要があります。 EMIT は、この失われた塵源情報を提供します。\n\nこのデータにより、科学者は地球の塵発生地域の新しい鉱物マップを作成できるようになります。この地図は、科学者が現在および将来の鉱物粉塵による地域的および地球規模の冷暖房効果を評価するために使用するコンピューター モデルを改良します。',
    },
    '0fjb6bj6': {
      'en':
          'As shown, EMIT coverage mask for arid and adjacent lands as well as dark signal, calibration, and validation targets. Additional areas are acquired along each orbit to account for timing uncertainty.',
      'de':
          'Wie gezeigt, EMIT-Abdeckungsmaske für trockene und angrenzende Gebiete sowie Dunkelsignal-, Kalibrierungs- und Validierungsziele. Entlang jeder Umlaufbahn werden zusätzliche Gebiete erfasst, um zeitliche Unsicherheiten zu berücksichtigen.',
      'es':
          'Como se muestra, máscara de cobertura EMIT para tierras áridas y adyacentes, así como objetivos de señal oscura, calibración y validación. Se adquieren áreas adicionales a lo largo de cada órbita para tener en cuenta la incertidumbre temporal.',
      'fr':
          'Comme indiqué, masque de couverture EMIT pour les terres arides et adjacentes ainsi que les cibles de signal sombre, d\'étalonnage et de validation. Des zones supplémentaires sont acquises le long de chaque orbite pour tenir compte de l\'incertitude temporelle.',
      'it':
          'Come mostrato, maschera di copertura EMIT per terreni aridi e adiacenti, nonché obiettivi di segnale oscuro, calibrazione e convalida. Aree aggiuntive vengono acquisite lungo ciascuna orbita per tenere conto dell\'incertezza temporale.',
      'ja':
          '示されているように、乾燥地および隣接する土地、ならびに暗信号、キャリブレーション、および検証ターゲットの EMIT カバレッジ マスクが表示されます。タイミングの不確実性を考慮して、各軌道に沿って追加のエリアが取得されます。',
    },
    'g9shwll3': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'ez14qer6': {
      'en': 'About the Mission\n',
      'de': 'Über die Mission',
      'es': 'Acerca de la misión',
      'fr': 'À propos de la mission',
      'it': 'A proposito della missione',
      'ja': 'ミッションについて',
    },
    '3jpgzc3x': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // WhatkindofdatadoesEMITcollects
  {
    'zuzywags': {
      'en':
          'The EMIT mission will provide a suite of data products for all areas successfully measured below the International Space Station. These data and derived products will be used to achieve the EMIT science objectives, reducing the uncertainty in mineral dust radiative forcing. All measurements will be delivered to the NASA Land Processes Distributed Active Archive Center and made available to the broader community for the additional Earth science investigations it can enable.\n\nThe EMIT data products for each stage of analysis from Level 1b to Level 4 are described in a series of Algorithm Theoretical Basis Documents (ATBDs). These describe the theoretical foundations for each stage of the analysis, define the quantities in the data files, and provide guidance on interpretation. Uncertainty predictions are distributed with all products.\n\nLevel 1b (Radiance at Sensor)',
      'de':
          'Die EMIT-Mission wird eine Reihe von Datenprodukten für alle erfolgreich gemessenen Bereiche unterhalb der Internationalen Raumstation liefern. Diese Daten und abgeleiteten Produkte werden verwendet, um die wissenschaftlichen Ziele von EMIT zu erreichen und die Unsicherheit beim Strahlungsantrieb von Mineralstaub zu verringern. Alle Messungen werden an das NASA Land Processes Distributed Active Archive Center übermittelt und der breiteren Gemeinschaft für die dadurch möglichen zusätzlichen geowissenschaftlichen Untersuchungen zur Verfügung gestellt.\n\nDie EMIT-Datenprodukte für jede Analysestufe von Level 1b bis Level 4 werden in einer Reihe von Algorithm Theoretical Basis Documents (ATBDs) beschrieben. Diese beschreiben die theoretischen Grundlagen für jede Phase der Analyse, definieren die Größen in den Datendateien und geben Hinweise zur Interpretation. Unsicherheitsvorhersagen werden mit allen Produkten verteilt.\n\nStufe 1b (Strahlungsdichte am Sensor)',
      'es':
          'La misión EMIT proporcionará un conjunto de productos de datos para todas las áreas medidas con éxito debajo de la Estación Espacial Internacional. Estos datos y productos derivados se utilizarán para lograr los objetivos científicos de EMIT, reduciendo la incertidumbre en el forzamiento radiativo del polvo mineral. Todas las mediciones se entregarán al Centro de Archivo Activo Distribuido de Procesos Terrestres de la NASA y se pondrán a disposición de la comunidad en general para las investigaciones adicionales de ciencias de la Tierra que pueda permitir.\n\nLos productos de datos EMIT para cada etapa de análisis desde el Nivel 1b al Nivel 4 se describen en una serie de Documentos de Base Teórica de Algoritmos (ATBD). Estos describen los fundamentos teóricos para cada etapa del análisis, definen las cantidades en los archivos de datos y brindan orientación sobre la interpretación. Las predicciones de incertidumbre se distribuyen con todos los productos.\n\nNivel 1b (Resplandor en el sensor)',
      'fr':
          'La mission EMIT fournira une suite de produits de données pour toutes les zones mesurées avec succès sous la Station spatiale internationale. Ces données et produits dérivés seront utilisés pour atteindre les objectifs scientifiques d’EMIT, réduisant ainsi l’incertitude relative au forçage radiatif des poussières minérales. Toutes les mesures seront transmises au centre d\'archives actives distribuées des processus terrestres de la NASA et mises à la disposition de la communauté au sens large pour les investigations supplémentaires en sciences de la Terre qu\'il peut permettre.\n\nLes produits de données EMIT pour chaque étape de l\'analyse, du niveau 1b au niveau 4, sont décrits dans une série de documents de base théorique des algorithmes (ATBD). Ceux-ci décrivent les fondements théoriques de chaque étape de l\'analyse, définissent les quantités contenues dans les fichiers de données et fournissent des conseils d\'interprétation. Les prévisions d\'incertitude sont distribuées avec tous les produits.\n\nNiveau 1b (radiance au capteur)',
      'it':
          'La missione EMIT fornirà una suite di dati per tutte le aree misurate con successo sotto la Stazione Spaziale Internazionale. Questi dati e i prodotti derivati ​​verranno utilizzati per raggiungere gli obiettivi scientifici di EMIT, riducendo l’incertezza nella forzatura radiativa delle polveri minerali. Tutte le misurazioni verranno consegnate al Centro di archivio attivo distribuito dei processi terrestri della NASA e rese disponibili alla comunità più ampia per le ulteriori indagini sulle scienze della Terra che può consentire.\n\nI prodotti dei dati EMIT per ciascuna fase di analisi dal Livello 1b al Livello 4 sono descritti in una serie di Algorithm Theoretical Basis Documents (ATBD). Questi descrivono i fondamenti teorici per ciascuna fase dell\'analisi, definiscono le quantità nei file di dati e forniscono indicazioni sull\'interpretazione. Le previsioni di incertezza sono distribuite con tutti i prodotti.\n\nLivello 1b (Radianza al sensore)',
      'ja':
          'EMIT ミッションは、国際宇宙ステーションの下で測定に成功したすべての領域の一連のデータ製品を提供します。これらのデータと派生製品は、EMIT の科学目標を達成するために使用され、鉱物粉塵の放射力の不確実性が軽減されます。すべての測定値は NASA 土地プロセス分散型アクティブ アーカイブ センターに配信され、追加の地球科学調査のために広範なコミュニティに利用可能になります。\n\nレベル 1b からレベル 4 までの分析の各段階の EMIT データ製品は、一連のアルゴリズム理論的基礎ドキュメント (ATBD) で説明されています。これらは、分析の各段階の理論的基礎を説明し、データ ファイル内の量を定義し、解釈に関するガイダンスを提供します。不確実性予測はすべての製品で配布されます。\n\nレベル 1b (センサーの輝度)',
    },
    'e1q6j7lh': {
      'en':
          'Level 2a (Surface Reflectance, the spectral fingerprint of Earth’s surface)',
      'de':
          'Level 2a (Oberflächenreflexion, der spektrale Fingerabdruck der Erdoberfläche)',
      'es':
          'Nivel 2a (Reflectancia de la superficie, la huella espectral de la superficie de la Tierra)',
      'fr':
          'Niveau 2a (Surface Reflectance, l’empreinte spectrale de la surface de la Terre)',
      'it':
          'Livello 2a (Riflessione della superficie, l’impronta spettrale della superficie terrestre)',
      'ja': 'レベル 2a (表面反射率、地球表面のスペクトル指紋)',
    },
    'yk2yiyl0': {
      'en':
          'Level 2b (Surface Mineralogy, the spectral abundance of 10 common minerals: Calcite, Chlorite, Dolomite, Goethite, Gypsum, Hematite, Illite and Muscovite, Kaolinite, Montmorillonite, Vermiculite) ',
      'de':
          'Ebene 2b (Oberflächenmineralogie, die spektrale Häufigkeit von 10 häufig vorkommenden Mineralien: Calcit, Chlorit, Dolomit, Goethit, Gips, Hämatit, Illit und Muskovit, Kaolinit, Montmorillonit, Vermiculit)',
      'es':
          'Nivel 2b (Mineralogía de superficies, la abundancia espectral de 10 minerales comunes: calcita, clorita, dolomita, goethita, yeso, hematita, illita y moscovita, caolinita, montmorillonita, vermiculita)',
      'fr':
          'Niveau 2b (Minéralogie de surface, l\'abondance spectrale de 10 minéraux courants : Calcite, Chlorite, Dolomite, Goethite, Gypse, Hématite, Illite et Muscovite, Kaolinite, Montmorillonite, Vermiculite)',
      'it':
          'Livello 2b (Minerologia superficiale, abbondanza spettrale di 10 minerali comuni: calcite, clorite, dolomite, goethite, gesso, ematite, illite e muscovite, caolinite, montmorillonite, vermiculite)',
      'ja':
          'レベル 2b (表面鉱物学、10 種類の一般的な鉱物のスペクトル存在量: 方解石、緑泥石、ドロマイト、針鉄鉱、石膏、赤鉄鉱、イライト、白雲母、カオリナイト、モンモリロナイト、バーミキュライト)',
    },
    'kt5eij6m': {
      'en': 'Level 3 (Aggregated Surface Mineralogy) ',
      'de': 'Ebene 3 (Aggregierte Oberflächenmineralogie)',
      'es': 'Nivel 3 (Mineralogía de Superficie Agregada)',
      'fr': 'Niveau 3 (Minéralogie de surface agrégée)',
      'it': 'Livello 3 (Minerologia superficiale aggregata)',
      'ja': 'レベル 3 (凝集表面鉱物学)',
    },
    '846jsqav': {
      'en':
          ' Level 4 (Earth System Model Runs)\n\n\nGreenhouse Gas Observations\n',
      'de':
          'Level 4 (Erdsystemmodellläufe)\n\n\nBeobachtungen von Treibhausgasen',
      'es':
          'Nivel 4 (Ejecuciones del modelo del sistema terrestre)\n\n\nObservaciones de gases de efecto invernadero',
      'fr':
          'Niveau 4 (exécutions du modèle du système terrestre)\n\n\nObservations de gaz à effet de serre',
      'it':
          'Livello 4 (esecuzioni del modello del sistema Terra)\n\n\nOsservazioni sui gas serra',
      'ja': 'レベル 4 (地球システム モデルの実行)\n\n\n温室効果ガスの観測',
    },
    '3s73uy2z': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'kj6prvzt': {
      'en': 'EMIT data',
      'de': 'EMIT-Daten',
      'es': 'EMITIR datos',
      'fr': 'ÉMETTRE des données',
      'it': 'Dati EMESSI',
      'ja': 'データの送信',
    },
    'iz2gloxe': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Accomplishmentsandfuturebenefits
  {
    'brcl112j': {
      'en': 'July 13, 2022',
      'de': '13. Juli 2022',
      'es': '13 de julio de 2022',
      'fr': '13 juillet 2022',
      'it': '13 luglio 2022',
      'ja': '2022 年 7 月 13 日',
    },
    'g3w8ixv4': {
      'en': '29 july, 2022',
      'de': '29. Juli 2022',
      'es': '29 julio, 2022',
      'fr': '29 juillet 2022',
      'it': '29 luglio 2022',
      'ja': '2022 年 7 月 29 日',
    },
    '715294xt': {
      'en': 'September 30, 2022',
      'de': '30. September 2022',
      'es': '30 de septiembre de 2022',
      'fr': '30 septembre 2022',
      'it': '30 settembre 2022',
      'ja': '2022年9月30日',
    },
    'p6bzf6km': {
      'en': 'October 12, 2022',
      'de': '12. Oktober 2022',
      'es': '12 de octubre de 2022',
      'fr': '12 octobre 2022',
      'it': '12 ottobre 2022',
      'ja': '2022 年 10 月 12 日',
    },
    'cp48e5mm': {
      'en': 'October 25, 2022',
      'de': '25. Oktober 2022',
      'es': '25 de octubre de 2022',
      'fr': '25 octobre 2022',
      'it': '25 ottobre 2022',
      'ja': '2022年10月25日',
    },
    '9oqzmeq7': {
      'en': 'December 15, 2022',
      'de': '15. Dezember 2022',
      'es': '15 de diciembre de 2022',
      'fr': '15 décembre 2022',
      'it': '15 dicembre 2022',
      'ja': '2022 年 12 月 15 日',
    },
    '79ocktxq': {
      'en': 'Accomplishments and future benefits',
      'de': 'Erfolge und zukünftige Vorteile',
      'es': 'Logros y beneficios futuros',
      'fr': 'Réalisations et avantages futurs',
      'it': 'Risultati e benefici futuri',
      'ja': 'これまでの成果と今後のメリット',
    },
    '2xohj3ti': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // July132022
  {
    'y68ym69o': {
      'en':
          'Designed to analyze airborne dust to see how it might affect climate, the EMIT mission launches to the International Space Station on Thursday, July 14.\n\nHere are five things to know about EMIT:\n\n1. It will identify the composition of mineral dust from Earth’s arid regions.\n\n2. It will clarify whether mineral dust heats or cools the planet.\n\n3. It will help scientists understand how dust affects different Earth processes.\n\n4. Its data will improve the accuracy of climate models.\n\n5. It will help scientists predict how future climate scenarios will affect the type and amount of dust in our atmosphere.',
      'de':
          'Die EMIT-Mission soll am Donnerstag, dem 14. Juli, den Staub in der Luft analysieren, um herauszufinden, wie er sich auf das Klima auswirken könnte. Sie startet zur Internationalen Raumstation.\n\nHier sind fünf Dinge, die Sie über EMIT wissen sollten:\n\n1. Es wird die Zusammensetzung des Mineralstaubs aus den Trockengebieten der Erde ermitteln.\n\n2. Es wird geklärt, ob Mineralstaub den Planeten erwärmt oder kühlt.\n\n3. Es wird Wissenschaftlern helfen zu verstehen, wie Staub verschiedene Prozesse auf der Erde beeinflusst.\n\n4. Seine Daten werden die Genauigkeit von Klimamodellen verbessern.\n\n5. Es wird Wissenschaftlern helfen, vorherzusagen, wie sich zukünftige Klimaszenarien auf die Art und Menge des Staubs in unserer Atmosphäre auswirken werden.',
      'es':
          'Diseñada para analizar el polvo en el aire para ver cómo podría afectar el clima, la misión EMIT se lanza a la Estación Espacial Internacional el jueves 14 de julio.\n\nAquí hay cinco cosas que debe saber sobre EMIT:\n\n1. Identificará la composición del polvo mineral de las regiones áridas de la Tierra.\n\n2. Esclarecerá si el polvo mineral calienta o enfría el planeta.\n\n3. Ayudará a los científicos a comprender cómo el polvo afecta los diferentes procesos de la Tierra.\n\n4. Sus datos mejorarán la precisión de los modelos climáticos.\n\n5. Ayudará a los científicos a predecir cómo los escenarios climáticos futuros afectarán el tipo y la cantidad de polvo en nuestra atmósfera.',
      'fr':
          'Conçue pour analyser la poussière en suspension dans l\'air afin de voir comment elle pourrait affecter le climat, la mission EMIT sera lancée vers la Station spatiale internationale le jeudi 14 juillet.\n\nVoici cinq choses à savoir sur EMIT :\n\n1. Il identifiera la composition des poussières minérales provenant des régions arides de la Terre.\n\n2. Il clarifiera si la poussière minérale chauffe ou refroidit la planète.\n\n3. Cela aidera les scientifiques à comprendre comment la poussière affecte différents processus terrestres.\n\n4. Ses données amélioreront la précision des modèles climatiques.\n\n5. Cela aidera les scientifiques à prédire comment les futurs scénarios climatiques affecteront le type et la quantité de poussière dans notre atmosphère.',
      'it':
          'Progettata per analizzare la polvere nell\'aria per vedere come potrebbe influenzare il clima, la missione EMIT verrà lanciata alla Stazione Spaziale Internazionale giovedì 14 luglio.\n\nEcco cinque cose da sapere su EMIT:\n\n1. Identificherà la composizione della polvere minerale proveniente dalle regioni aride della Terra.\n\n2. Chiarirà se le polveri minerali riscaldano o raffreddano il pianeta.\n\n3. Aiuterà gli scienziati a capire come la polvere influisce sui diversi processi terrestri.\n\n4. I suoi dati miglioreranno la precisione dei modelli climatici.\n\n5. Aiuterà gli scienziati a prevedere in che modo i futuri scenari climatici influenzeranno il tipo e la quantità di polvere nella nostra atmosfera.',
      'ja':
          '空中浮遊粉塵を分析して気候にどのような影響を与えるかを確認することを目的としたEMITミッションは、7月14日木曜日に国際宇宙ステーションに向けて打ち上げられる。\n\nEMIT について知っておくべき 5 つのことは次のとおりです。\n\n1. 地球の乾燥地域からの鉱物粉塵の組成を特定します。\n\n2. 鉱物粉塵が地球を加熱するのか、それとも冷却するのかを明らかにするでしょう。\n\n3. 科学者が塵が地球のさまざまなプロセスにどのような影響を与えるかを理解するのに役立ちます。\n\n4. そのデータは気候モデルの精度を向上させます。\n\n5. 科学者が将来の気候シナリオが大気中の塵の種類と量にどのような影響を与えるかを予測するのに役立ちます。',
    },
    '43metxo6': {
      'en':
          'As depicted in this illustration, NASA’s EMIT will be attached to Express Logistics Carrier 1, a platform on the International Space Station that supports external science instruments. The mission will help scientists better understand the role of airborne dust in heating and cooling the atmosphere. Credit: NASA/JPL-Caltech\n\n\nFor more information: https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
      'de':
          'Wie in dieser Abbildung dargestellt, wird das EMIT der NASA an Express Logistics Carrier 1 angeschlossen, einer Plattform auf der Internationalen Raumstation, die externe wissenschaftliche Instrumente unterstützt. Die Mission wird Wissenschaftlern helfen, die Rolle von Staub in der Luft bei der Erwärmung und Abkühlung der Atmosphäre besser zu verstehen. Bildnachweis: NASA/JPL-Caltech\n\n\nWeitere Informationen: https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
      'es':
          'Como se muestra en esta ilustración, el EMIT de la NASA se conectará al Express Logistics Carrier 1, una plataforma de la Estación Espacial Internacional que admite instrumentos científicos externos. La misión ayudará a los científicos a comprender mejor el papel del polvo en suspensión en el calentamiento y enfriamiento de la atmósfera. Crédito: NASA/JPL-Caltech\n\n\nPara más información: https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
      'fr':
          'Comme le montre cette illustration, l’EMIT de la NASA sera attaché à Express Logistics Carrier 1, une plate-forme de la Station spatiale internationale qui prend en charge des instruments scientifiques externes. La mission aidera les scientifiques à mieux comprendre le rôle de la poussière en suspension dans l’air dans le réchauffement et le refroidissement de l’atmosphère. Crédit : NASA/JPL-Caltech\n\n\nPour plus d\'informations : https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
      'it':
          'Come illustrato in questa illustrazione, l’EMIT della NASA sarà collegato a Express Logistics Carrier 1, una piattaforma sulla Stazione Spaziale Internazionale che supporta strumenti scientifici esterni. La missione aiuterà gli scienziati a comprendere meglio il ruolo delle polveri sospese nell’aria nel riscaldamento e nel raffreddamento dell’atmosfera. Credito: NASA/JPL-Caltech\n\n\nPer ulteriori informazioni: https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
      'ja':
          'この図に示されているように、NASA の EMIT は、外部の科学機器をサポートする国際宇宙ステーション上のプラットフォームである Express Logistics Carrier 1 に取り付けられます。このミッションは、科学者が大気の加熱と冷却における浮遊塵の役割をより深く理解するのに役立ちます。クレジット: NASA/JPL-カリフォルニア工科大学\n\n\n詳細については: https://earth.jpl.nasa.gov/emit/news/18/nasas-new-mineral-dust-detector-readies-for-launch/',
    },
    'bl2pisk2': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'nnvt34wz': {
      'en': 'July 13, 2022',
      'de': '13. Juli 2022',
      'es': '13 de julio de 2022',
      'fr': '13 juillet 2022',
      'it': '13 luglio 2022',
      'ja': '2022 年 7 月 13 日',
    },
    'yie7t75m': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // July292022
  {
    '4n5v1nmp': {
      'en':
          'NASA\'s Mineral Dust Detector Starts Gathering Data\n\nAfter being installed on the exterior of the International Space Station, NASA’s Earth Surface Mineral Dust Source Investigation (EMIT) mission has provided its first view of Earth. The milestone, called “first light,” took place at 7:51 p.m. PDT (10:51 p.m. EDT) on July 27 as the space station passed over Western Australia.\nDeveloped by NASA’s Jet Propulsion Laboratory in Southern California, EMIT is focused on mapping the mineral dust composition of Earth’s arid regions to better understand how dust affects climate heating and cooling.\nThe instrument works by measuring the hundreds of wavelengths of light reflected from materials on Earth.\nGround controllers used the Canadarm2 robotic arm of the space station to remove EMIT from a Dragon spacecraft and install it on the outside of the station, a process that began on July 22 and took more than 40 hours. \n\nFor more information, visit: \nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/ \n',
      'de':
          'Der Mineralstaubdetektor der NASA beginnt mit der Datenerfassung\n\nNach der Installation an der Außenseite der Internationalen Raumstation hat die NASA-Mission Earth Surface Mineral Dust Source Investigation (EMIT) ihren ersten Blick auf die Erde ermöglicht. Der Meilenstein, „First Light“ genannt, fand um 19:51 Uhr statt. PDT (22:51 Uhr EDT) am 27. Juli, als die Raumstation Westaustralien überflog.\nEMIT wurde vom Jet Propulsion Laboratory der NASA in Südkalifornien entwickelt und konzentriert sich auf die Kartierung der Mineralstaubzusammensetzung der Trockenregionen der Erde, um besser zu verstehen, wie sich Staub auf die Klimaerwärmung und -kühlung auswirkt.\nDas Instrument misst Hunderte von Wellenlängen des Lichts, das von Materialien auf der Erde reflektiert wird.\nBodenkontrolleure nutzten den Canadarm2-Roboterarm der Raumstation, um EMIT von einem Dragon-Raumschiff zu entfernen und an der Außenseite der Station zu installieren. Dieser Prozess begann am 22. Juli und dauerte mehr als 40 Stunden.\n\nFür weitere Informationen besuchen Sie:\nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/',
      'es':
          'El detector de polvo mineral de la NASA comienza a recopilar datos\n\nDespués de ser instalada en el exterior de la Estación Espacial Internacional, la misión de Investigación de Fuentes de Polvo Mineral de la Superficie Terrestre (EMIT) de la NASA ha proporcionado su primera vista de la Tierra. El hito, denominado “primera luz”, tuvo lugar a las 19.51 horas. PDT (10:51 p.m.EDT) el 27 de julio cuando la estación espacial pasaba sobre Australia Occidental.\nDesarrollado por el Laboratorio de Propulsión a Chorro de la NASA en el sur de California, EMIT se centra en mapear la composición del polvo mineral de las regiones áridas de la Tierra para comprender mejor cómo el polvo afecta el calentamiento y enfriamiento del clima.\nEl instrumento funciona midiendo cientos de longitudes de onda de luz reflejadas por los materiales de la Tierra.\nLos controladores terrestres utilizaron el brazo robótico Canadarm2 de la estación espacial para retirar EMIT de una nave espacial Dragon e instalarlo en el exterior de la estación, un proceso que comenzó el 22 de julio y tomó más de 40 horas.\n\nPara más información visite:\nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/',
      'fr':
          'Le détecteur de poussière minérale de la NASA commence à collecter des données\n\nAprès avoir été installée à l’extérieur de la Station spatiale internationale, la mission Earth Surface Mineral Dust Source Investigation (EMIT) de la NASA a fourni sa première vue de la Terre. Le jalon, appelé « première lumière », a eu lieu à 19h51. PDT (22 h 51 HAE) le 27 juillet alors que la station spatiale passait au-dessus de l\'Australie occidentale.\nDéveloppé par le Jet Propulsion Laboratory de la NASA en Californie du Sud, EMIT se concentre sur la cartographie de la composition des poussières minérales des régions arides de la Terre afin de mieux comprendre comment la poussière affecte le réchauffement et le refroidissement du climat.\nL’instrument fonctionne en mesurant les centaines de longueurs d’onde de lumière réfléchies par les matériaux sur Terre.\nLes contrôleurs au sol ont utilisé le bras robotique Canadarm2 de la station spatiale pour retirer l\'EMIT d\'un vaisseau spatial Dragon et l\'installer à l\'extérieur de la station, un processus qui a débuté le 22 juillet et a duré plus de 40 heures.\n\nPour plus d\'informations, visitez:\nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/',
      'it':
          'Il rilevatore di polveri minerali della NASA inizia a raccogliere dati\n\nDopo essere stata installata all’esterno della Stazione Spaziale Internazionale, la missione Earth Surface Mineral Dust Source Investigation (EMIT) della NASA ha fornito la sua prima visione della Terra. Il traguardo, chiamato “prima luce”, è avvenuto alle 19:51. PDT (22:51 EDT) il 27 luglio mentre la stazione spaziale passava sull\'Australia occidentale.\nSviluppato dal Jet Propulsion Laboratory della NASA nel sud della California, EMIT si concentra sulla mappatura della composizione della polvere minerale delle regioni aride della Terra per comprendere meglio come la polvere influisce sul riscaldamento e sul raffreddamento del clima.\nLo strumento funziona misurando le centinaia di lunghezze d\'onda della luce riflessa dai materiali sulla Terra.\nI controllori di terra hanno utilizzato il braccio robotico Canadarm2 della stazione spaziale per rimuovere EMIT da una navicella spaziale Dragon e installarlo all\'esterno della stazione, un processo iniziato il 22 luglio e durato più di 40 ore.\n\nPer maggiori informazioni visita:\nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/',
      'ja':
          'NASAの鉱物粉塵検出器がデータ収集を開始\n\n国際宇宙ステーションの外側に設置された後、NASA の地球表面鉱物粉塵源調査 (EMIT) ミッションは、初めて地球の様子を提供しました。 「ファーストライト」と呼ばれるこのマイルストーンは午後7時51分に発生した。 7月27日太平洋夏時間（東部夏時間午後10時51分）、宇宙ステーションが西オーストラリア上空を通過した。\n南カリフォルニアにある NASA のジェット推進研究所によって開発された EMIT は、粉塵が気候の冷暖房にどのような影響を与えるかをより深く理解するために、地球の乾燥地域の鉱物粉塵の組成をマッピングすることに焦点を当てています。\nこの機器は、地球上の物質から反射される光の何百もの波長を測定することによって機能します。\n地上管制官は、宇宙ステーションのCanadarm2ロボットアームを使用して、ドラゴン宇宙船からEMITを取り外し、ステーションの外側に設置しました。このプロセスは7月22日に始まり、40時間以上かかりました。\n\n詳細については、以下を参照してください。\nhttps://earth.jpl.nasa.gov/emit/news/19/nasas-mineral-dust-detector-starts-gathering-data/',
    },
    '131pydwg': {
      'en':
          'This image shows the first measurements taken by EMIT on July 27, 2022, as it passed over Western Australia. The image at the front of the cube shows a mix of materials in Western Australia, including exposed soil (brown), vegetation (dark green), agricultural fields (light green), a small river, and clouds. The rainbow colors extending through the main part of the cube are the spectral fingerprints from corresponding spots in the front image.\n\nCredit: NASA/JPL-Caltech',
      'de':
          'Dieses Bild zeigt die ersten Messungen von EMIT am 27. Juli 2022, als es Westaustralien überflog. Das Bild an der Vorderseite des Würfels zeigt einen Materialmix in Westaustralien, darunter freiliegende Erde (braun), Vegetation (dunkelgrün), landwirtschaftliche Felder (hellgrün), einen kleinen Fluss und Wolken. Die Regenbogenfarben, die sich durch den Hauptteil des Würfels erstrecken, sind die spektralen Fingerabdrücke der entsprechenden Stellen im vorderen Bild.\n\nBildnachweis: NASA/JPL-Caltech',
      'es':
          'Esta imagen muestra las primeras mediciones tomadas por EMIT el 27 de julio de 2022, cuando pasaba sobre Australia Occidental. La imagen en el frente del cubo muestra una mezcla de materiales en Australia Occidental, incluyendo suelo expuesto (marrón), vegetación (verde oscuro), campos agrícolas (verde claro), un pequeño río y nubes. Los colores del arco iris que se extienden a través de la parte principal del cubo son las huellas espectrales de los puntos correspondientes en la imagen frontal.\n\nCrédito: NASA/JPL-Caltech',
      'fr':
          'Cette image montre les premières mesures prises par EMIT le 27 juillet 2022, lors de son passage au-dessus de l\'Australie occidentale. L\'image à l\'avant du cube montre un mélange de matériaux en Australie occidentale, notamment du sol exposé (marron), de la végétation (vert foncé), des champs agricoles (vert clair), une petite rivière et des nuages. Les couleurs de l\'arc-en-ciel qui s\'étendent à travers la partie principale du cube sont les empreintes spectrales des points correspondants dans l\'image avant.\n\nCrédit : NASA/JPL-Caltech',
      'it':
          'Questa immagine mostra le prime misurazioni effettuate da EMIT il 27 luglio 2022, mentre passava sull\'Australia occidentale. L\'immagine nella parte anteriore del cubo mostra un mix di materiali dell\'Australia occidentale, tra cui terreno esposto (marrone), vegetazione (verde scuro), campi agricoli (verde chiaro), un piccolo fiume e nuvole. I colori dell\'arcobaleno che si estendono attraverso la parte principale del cubo sono le impronte spettrali dei punti corrispondenti nell\'immagine frontale.\n\nCredito: NASA/JPL-Caltech',
      'ja':
          'この画像は、2022 年 7 月 27 日に西オーストラリア上空を通過した際に EMIT によって測定された最初の測定を示しています。立方体の前面の画像には、露出した土壌 (茶色)、植生 (濃い緑色)、農地 (薄緑色)、小さな川、雲など、西オーストラリア州のマテリアルの組み合わせが示されています。立方体の主要部分を通って広がる虹色は、正面画像内の対応するスポットからのスペクトル指紋です。\n\nクレジット: NASA/JPL-カリフォルニア工科大学',
    },
    '79u124j0': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '46l0vytj': {
      'en': '29 july, 2022',
      'de': '29. Juli 2022',
      'es': '29 julio, 2022',
      'fr': '29 juillet 2022',
      'it': '29 luglio 2022',
      'ja': '2022 年 7 月 29 日',
    },
    'zu6rcvom': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // September302022
  {
    'wm6kgefn': {
      'en':
          'NASA, USGS Map Minerals to Understand Earth Makeup, Climate Change\n\nThese new observations can be used to identify the presence of a wide variety of minerals as well as mineral weathering or alteration.\n\nNASA and the U.S. Geological Survey (USGS) will map portions of the southwest United States for critical minerals using advanced airborne imaging.\n\nHyperspectral data from hundreds of wavelengths of reflected light can provide new information about Earth’s surface and atmosphere to help scientists understand Earth’s geology and biology, as well as the effects of climate change.\n\nThe research project, called the Geological Earth Mapping Experiment (GEMx), will use NASA’s Airborne Visible/Infrared Imaging Spectrometer (AVIRIS) and Hyperspectral Thermal Emission Spectrometer (HyTES) instruments flown on NASA’s ER-2 and Gulfstream V aircraft to collect the measurements over the country’s arid and semi-arid regions, including parts of California, Nevada, Arizona, and New Mexico.\n\nFor more information, visit: https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-understand-earth-makeup-climate-change/\n',
      'de':
          'NASA und USGS kartieren Mineralien, um die Beschaffenheit der Erde und den Klimawandel zu verstehen\n\nDiese neuen Beobachtungen können verwendet werden, um das Vorhandensein einer Vielzahl von Mineralien sowie die Verwitterung oder Veränderung von Mineralien zu identifizieren.\n\nDie NASA und das U.S. Geological Survey (USGS) werden Teile des Südwestens der Vereinigten Staaten mithilfe fortschrittlicher luftgestützter Bildgebung auf kritische Mineralien kartieren.\n\nHyperspektrale Daten von Hunderten von Wellenlängen reflektierten Lichts können neue Informationen über die Erdoberfläche und -atmosphäre liefern und Wissenschaftlern helfen, die Geologie und Biologie der Erde sowie die Auswirkungen des Klimawandels zu verstehen.\n\nDas Forschungsprojekt mit dem Namen Geological Earth Mapping Experiment (GEMx) wird die Instrumente Airborne Visible/Infrared Imaging Spectrometer (AVIRIS) und Hyperspectral Thermal Emission Spectrometer (HyTES) der NASA verwenden, die mit den NASA-Flugzeugen ER-2 und Gulfstream V geflogen sind, um die Messungen zu sammeln die trockenen und halbtrockenen Regionen des Landes, darunter Teile von Kalifornien, Nevada, Arizona und New Mexico.\n\nWeitere Informationen finden Sie unter: https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-understand-earth-makeup-climate-change/',
      'es':
          'La NASA y el USGS mapean minerales para comprender la composición de la Tierra y el cambio climático\n\nEstas nuevas observaciones se pueden utilizar para identificar la presencia de una amplia variedad de minerales, así como la erosión o alteración de los minerales.\n\nLa NASA y el Servicio Geológico de los Estados Unidos (USGS) mapearán partes del suroeste de los Estados Unidos en busca de minerales críticos utilizando imágenes aéreas avanzadas.\n\nLos datos hiperespectrales de cientos de longitudes de onda de luz reflejada pueden proporcionar nueva información sobre la superficie y la atmósfera de la Tierra para ayudar a los científicos a comprender la geología y la biología de la Tierra, así como los efectos del cambio climático.\n\nEl proyecto de investigación, llamado Experimento de mapeo geológico de la Tierra (GEMx), utilizará los instrumentos Airborne Visible/Infrared Imaging Spectrometer (AVIRIS) y Hyperspectral Thermal Emission Spectrometer (HyTES) de la NASA volados en los aviones ER-2 y Gulfstream V de la NASA para recolectar las mediciones sobre las regiones áridas y semiáridas del país, incluidas partes de California, Nevada, Arizona y Nuevo México.\n\nPara obtener más información, visite: https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-understand-earth-makeup-climate-change/',
      'fr':
          'La NASA et l\'USGS cartographient les minéraux pour comprendre la composition de la Terre et le changement climatique\n\nCes nouvelles observations peuvent être utilisées pour identifier la présence d’une grande variété de minéraux ainsi que l’altération ou l’altération des minéraux.\n\nLa NASA et l\'US Geological Survey (USGS) cartographieront des parties du sud-ouest des États-Unis à la recherche de minéraux critiques à l\'aide d\'une imagerie aéroportée avancée.\n\nLes données hyperspectrales provenant de centaines de longueurs d’onde de lumière réfléchie peuvent fournir de nouvelles informations sur la surface et l’atmosphère de la Terre pour aider les scientifiques à comprendre la géologie et la biologie de la Terre, ainsi que les effets du changement climatique.\n\nLe projet de recherche, appelé Geological Earth Mapping Experiment (GEMx), utilisera les instruments du spectromètre d\'imagerie visible/infrarouge aéroporté (AVIRIS) et du spectromètre d\'émission thermique hyperspectral (HyTES) de la NASA embarqués sur les avions ER-2 et Gulfstream V de la NASA pour collecter les mesures sur les régions arides et semi-arides du pays, notamment certaines parties de la Californie, du Nevada, de l\'Arizona et du Nouveau-Mexique.\n\nPour plus d\'informations, visitez : https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-understand-earth-makeup-climate-change/',
      'it':
          'NASA, USGS Mappa i minerali per comprendere la composizione della Terra e i cambiamenti climatici\n\nQueste nuove osservazioni possono essere utilizzate per identificare la presenza di un’ampia varietà di minerali, nonché di alterazione o alterazione dei minerali.\n\nLa NASA e l’U.S. Geological Survey (USGS) mapperanno porzioni del sud-ovest degli Stati Uniti alla ricerca di minerali critici utilizzando l’imaging aereo avanzato.\n\nI dati iperspettrali provenienti da centinaia di lunghezze d’onda della luce riflessa possono fornire nuove informazioni sulla superficie e sull’atmosfera terrestre per aiutare gli scienziati a comprendere la geologia e la biologia della Terra, nonché gli effetti del cambiamento climatico.\n\nIl progetto di ricerca, chiamato Geological Earth Mapping Experiment (GEMx), utilizzerà gli strumenti Airborne Visible/Infrared Imaging Spectrometer (AVIRIS) e Hyperspectral Thermal Emission Spectrometer (HyTES) della NASA volati sugli aerei ER-2 e Gulfstream V della NASA per raccogliere le misurazioni su le regioni aride e semi-aride del paese, comprese parti della California, Nevada, Arizona e Nuovo Messico.\n\nPer ulteriori informazioni, visitare: https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-understand-earth-makeup-climate-change/',
      'ja':
          'NASA、USGS が地球の構成と気候変動を理解するために鉱物を地図化\n\nこれらの新しい観察は、さまざまな鉱物の存在や鉱物の風化や変質を特定するために使用できます。\n\nNASA と米国地質調査所 (USGS) は、高度な航空画像処理を使用して、米国南西部の重要な鉱物の地図を作成します。\n\n何百もの波長の反射光からのハイパースペクトル データは、科学者が地球の地質や生物学、さらには気候変動の影響を理解するのに役立つ、地球の表面と大気に関する新しい情報を提供します。\n\n地質地球マッピング実験 (GEMx) と呼ばれるこの研究プロジェクトでは、NASA の ER-2 およびガルフストリーム V 航空機に搭載された NASA の航空機可視/赤外線画像分光計 (AVIRIS) とハイパースペクトル熱放射分光計 (HyTES) 機器を使用して、全地球にわたる測定値を収集します。カリフォルニア、ネバダ、アリゾナ、ニューメキシコの一部を含む、国の乾燥および半乾燥地域。\n\n詳細については、https://earth.jpl.nasa.gov/emit/news/20/nasa-usgs-map-minerals-to-under-earth-makeup-climate-change/をご覧ください。',
    },
    '26dfh12a': {
      'en':
          'A photo of a NASA ER-2 high-altitude aircraft with the AVIRIS and HyTES instruments installed.\n\nCredit: NASA',
      'de':
          'Ein Foto eines NASA-ER-2-Höhenflugzeugs mit installierten AVIRIS- und HyTES-Instrumenten.\n\nBildnachweis: NASA',
      'es':
          'Una foto de un avión de gran altitud ER-2 de la NASA con los instrumentos AVIRIS y HyTES instalados.\n\nCrédito: NASA',
      'fr':
          'Une photo d\'un avion à haute altitude ER-2 de la NASA avec les instruments AVIRIS et HyTES installés.\n\nCrédit : NASA',
      'it':
          'Una foto di un aereo ad alta quota ER-2 della NASA con gli strumenti AVIRIS e HyTES installati.\n\nCredito: NASA',
      'ja': 'AVIRIS と HyTES 機器が設置された NASA ER-2 高高度航空機の写真。\n\nクレジット: NASA',
    },
    '6agi2l54': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'otadk9vn': {
      'en': 'September 30, 2022',
      'de': '30. September 2022',
      'es': '30 de septiembre de 2022',
      'fr': '30 septembre 2022',
      'it': '30 settembre 2022',
      'ja': '2022年9月30日',
    },
    'pdnbk8j1': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // October122022
  {
    '9j840zfm': {
      'en':
          'NASA Dust Detective Delivers First Maps From Space for Climate Science.\n\nNASA’s Earth Surface Mineral Dust Source Investigation (EMIT) mission aboard the International Space Station has produced its first mineral maps, providing detailed images that show the composition of the surface in regions of northwest Nevada and Libya in the Sahara Desert.\n\nRobert Green, EMIT’s principal investigator and senior research scientist at JPL: “The data we’re getting from EMIT will give us more insight into the heating and cooling of Earth, and the role mineral dust plays in that cycle. It’s promising to see the amount of data we’re getting from the mission in such a short time,” said Kate Calvin, NASA’s chief scientist and senior climate advisor. “EMIT is one of seven Earth science instruments on the International Space Station giving us more information about how our planet is affected by climate change.”\n\nThe other mineral map shows substantial amounts of kaolinite as well as two iron oxides, hematite and goethite, in a sparsely populated section of the Sahara about 500 miles (800 kilometers) south of Tripoli. Darker-colored dust particles from iron-oxide-rich areas strongly absorb energy from the Sun and heat the atmosphere, potentially affecting the climate.\nEMIT will gather billions of new spectroscopic measurements across six continents, closing this gap in knowledge and advancing climate science. “With this exceptional performance, we are on track to comprehensively map the minerals of Earth’s arid regions – about 25% of the Earth’s land surface – in less than a year and achieve our climate science objectives,” Green said.\n\nEMIT’s data also will be freely available for a wide range of investigations, including, for example, the search for strategically important minerals such as lithium and rare-earth elements. What’s more, the instrument’s technology is laying the groundwork for the future Surface Biology and Geology (SBG) satellite mission, which is part of NASA’s Earth System Observatory, a set of missions aimed at addressing climate change.\n\nFor more information, visit: https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/\n\n',
      'de':
          'NASA Dust Detective liefert erste Karten aus dem Weltraum für die Klimawissenschaft.\n\nDie NASA-Mission Earth Surface Mineral Dust Source Investigation (EMIT) an Bord der Internationalen Raumstation hat ihre ersten Mineralkarten erstellt und detaillierte Bilder geliefert, die die Zusammensetzung der Oberfläche in Regionen im Nordwesten Nevadas und Libyens in der Sahara zeigen.\n\nRobert Green, EMIT-Hauptforscher und leitender Forschungswissenschaftler am JPL: „Die Daten, die wir von EMIT erhalten, werden uns mehr Einblick in die Erwärmung und Abkühlung der Erde und die Rolle von Mineralstaub in diesem Kreislauf geben.“ „Es ist vielversprechend, die Menge an Daten zu sehen, die wir in so kurzer Zeit von der Mission erhalten“, sagte Kate Calvin, Chefwissenschaftlerin und leitende Klimaberaterin der NASA. „EMIT ist eines von sieben geowissenschaftlichen Instrumenten auf der Internationalen Raumstation, die uns mehr Informationen darüber liefern, wie unser Planet vom Klimawandel betroffen ist.“\n\nDie andere Mineralkarte zeigt erhebliche Mengen Kaolinit sowie zwei Eisenoxide, Hämatit und Goethit, in einem dünn besiedelten Teil der Sahara etwa 500 Meilen (800 Kilometer) südlich von Tripolis. Dunklere Staubpartikel aus eisenoxidreichen Gebieten absorbieren stark die Energie der Sonne und erwärmen die Atmosphäre, was möglicherweise Auswirkungen auf das Klima hat.\nEMIT wird Milliarden neuer spektroskopischer Messungen auf sechs Kontinenten sammeln, um diese Wissenslücke zu schließen und die Klimawissenschaft voranzubringen. „Mit dieser außergewöhnlichen Leistung sind wir auf dem besten Weg, die Mineralien der Trockengebiete der Erde – etwa 25 % der Landoberfläche der Erde – in weniger als einem Jahr umfassend zu kartieren und unsere klimawissenschaftlichen Ziele zu erreichen“, sagte Green.\n\nDie Daten von EMIT werden außerdem für eine Vielzahl von Untersuchungen frei verfügbar sein, darunter beispielsweise die Suche nach strategisch wichtigen Mineralien wie Lithium und Seltenerdelementen. Darüber hinaus legt die Technologie des Instruments den Grundstein für die zukünftige Satellitenmission Surface Biology and Geology (SBG), die Teil des Earth System Observatory der NASA ist, einer Reihe von Missionen zur Bekämpfung des Klimawandels.\n\nWeitere Informationen finden Sie unter: https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/',
      'es':
          'El detective de polvo de la NASA ofrece los primeros mapas desde el espacio para la ciencia climática.\n\nLa misión de Investigación de Fuentes de Polvo Mineral de la Superficie Terrestre (EMIT) de la NASA a bordo de la Estación Espacial Internacional ha producido sus primeros mapas minerales, proporcionando imágenes detalladas que muestran la composición de la superficie en regiones del noroeste de Nevada y Libia en el desierto del Sahara.\n\nRobert Green, investigador principal de EMIT y científico investigador senior del JPL: “Los datos que estamos obteniendo de EMIT nos darán más información sobre el calentamiento y enfriamiento de la Tierra y el papel que desempeña el polvo mineral en ese ciclo. Es prometedor ver la cantidad de datos que estamos obteniendo de la misión en tan poco tiempo”, dijo Kate Calvin, científica en jefe y asesora climática senior de la NASA. \"EMIT es uno de los siete instrumentos de ciencias de la Tierra en la Estación Espacial Internacional que nos brinda más información sobre cómo nuestro planeta se ve afectado por el cambio climático\".\n\nEl otro mapa de minerales muestra cantidades sustanciales de caolinita, así como dos óxidos de hierro, hematita y goethita, en una sección escasamente poblada del Sahara a unas 500 millas (800 kilómetros) al sur de Trípoli. Las partículas de polvo de colores más oscuros procedentes de zonas ricas en óxido de hierro absorben fuertemente la energía del Sol y calientan la atmósfera, afectando potencialmente al clima.\nEMIT recopilará miles de millones de nuevas mediciones espectroscópicas en seis continentes, cerrando esta brecha en el conocimiento y avanzando en la ciencia climática. \"Con este desempeño excepcional, estamos en camino de mapear exhaustivamente los minerales de las regiones áridas de la Tierra (alrededor del 25% de la superficie terrestre) en menos de un año y lograr nuestros objetivos científicos climáticos\", dijo Green.\n\nLos datos de EMIT también estarán disponibles gratuitamente para una amplia gama de investigaciones, incluida, por ejemplo, la búsqueda de minerales estratégicamente importantes como el litio y elementos de tierras raras. Es más, la tecnología del instrumento está sentando las bases para la futura misión satelital de Biología y Geología de Superficies (SBG), que forma parte del Observatorio del Sistema Terrestre de la NASA, un conjunto de misiones destinadas a abordar el cambio climático.\n\nPara obtener más información, visite: https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/',
      'fr':
          'Le détective de poussière de la NASA fournit les premières cartes spatiales pour la science du climat.\n\nLa mission EMIT (Earth Surface Mineral Dust Source Investigation) de la NASA à bord de la Station spatiale internationale a produit ses premières cartes minérales, fournissant des images détaillées montrant la composition de la surface dans les régions du nord-ouest du Nevada et de la Libye dans le désert du Sahara.\n\nRobert Green, chercheur principal de l’EMIT et chercheur principal au JPL : « Les données que nous obtenons de l’EMIT nous donneront plus d’informations sur le réchauffement et le refroidissement de la Terre, ainsi que sur le rôle que joue la poussière minérale dans ce cycle. C’est prometteur de voir la quantité de données que nous obtiendrons de la mission en si peu de temps », a déclaré Kate Calvin, scientifique en chef et conseillère principale en matière de climat à la NASA. \"EMIT est l\'un des sept instruments scientifiques de la Terre installés sur la Station spatiale internationale qui nous fournissent davantage d\'informations sur la manière dont notre planète est affectée par le changement climatique.\"\n\nL\'autre carte minérale montre des quantités substantielles de kaolinite ainsi que deux oxydes de fer, l\'hématite et la goethite, dans une partie peu peuplée du Sahara, à environ 800 kilomètres au sud de Tripoli. Les particules de poussière de couleur plus foncée provenant des zones riches en oxyde de fer absorbent fortement l\'énergie du Soleil et réchauffent l\'atmosphère, affectant potentiellement le climat.\nEMIT rassemblera des milliards de nouvelles mesures spectroscopiques sur six continents, comblant ainsi ce manque de connaissances et faisant progresser la science du climat. « Grâce à cette performance exceptionnelle, nous sommes sur la bonne voie pour cartographier de manière exhaustive les minéraux des régions arides de la Terre – environ 25 % de la surface terrestre – en moins d’un an et atteindre nos objectifs en matière de science climatique », a déclaré Green.\n\nLes données d’EMIT seront également disponibles gratuitement pour un large éventail d’enquêtes, y compris, par exemple, la recherche de minéraux d’importance stratégique tels que le lithium et les éléments de terres rares. De plus, la technologie de l’instrument jette les bases de la future mission satellite de biologie et géologie de surface (SBG), qui fait partie de l’Observatoire du système terrestre de la NASA, un ensemble de missions visant à lutter contre le changement climatique.\n\nPour plus d\'informations, visitez : https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/',
      'it':
          'Il Dust Detective della NASA fornisce le prime mappe dallo spazio per la scienza del clima.\n\nLa missione Earth Surface Mineral Dust Source Investigation (EMIT) della NASA a bordo della Stazione Spaziale Internazionale ha prodotto le sue prime mappe minerali, fornendo immagini dettagliate che mostrano la composizione della superficie nelle regioni del Nevada nordoccidentale e della Libia nel deserto del Sahara.\n\nRobert Green, ricercatore principale dell’EMIT e ricercatore senior presso il JPL: “I dati che stiamo ottenendo dall’EMIT ci forniranno maggiori informazioni sul riscaldamento e il raffreddamento della Terra e sul ruolo svolto dalla polvere minerale in quel ciclo. È promettente vedere la quantità di dati che stiamo ottenendo dalla missione in così poco tempo”, ha affermato Kate Calvin, capo scienziato della NASA e consulente senior sul clima. “EMIT è uno dei sette strumenti di scienze della Terra installati sulla Stazione Spaziale Internazionale che ci forniscono maggiori informazioni su come il nostro pianeta è influenzato dai cambiamenti climatici”.\n\nL’altra mappa minerale mostra notevoli quantità di caolinite e due ossidi di ferro, ematite e goethite, in una sezione scarsamente popolata del Sahara a circa 500 miglia (800 chilometri) a sud di Tripoli. Le particelle di polvere di colore più scuro provenienti da aree ricche di ossido di ferro assorbono fortemente l’energia del Sole e riscaldano l’atmosfera, influenzando potenzialmente il clima.\nEMIT raccoglierà miliardi di nuove misurazioni spettroscopiche in sei continenti, colmando questa lacuna nella conoscenza e facendo avanzare la scienza del clima. “Con questa prestazione eccezionale, siamo sulla buona strada per mappare in modo completo i minerali delle regioni aride della Terra – circa il 25% della superficie terrestre – in meno di un anno e raggiungere i nostri obiettivi di scienza del clima”, ha affermato Green.\n\nI dati dell’EMIT saranno inoltre disponibili gratuitamente per un’ampia gamma di indagini, inclusa, ad esempio, la ricerca di minerali strategicamente importanti come il litio e gli elementi delle terre rare. Inoltre, la tecnologia dello strumento sta gettando le basi per la futura missione satellitare Surface Biology and Geology (SBG), che fa parte dell’Earth System Observatory della NASA, una serie di missioni volte ad affrontare il cambiamento climatico.\n\nPer ulteriori informazioni, visitare: https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/',
      'ja':
          'NASA 塵探査団が気候科学のために宇宙から初の地図を提供。\n\n国際宇宙ステーションに搭載された NASA の地球表面鉱物粉塵源調査 (EMIT) ミッションは、サハラ砂漠のネバダ北西部とリビアの地域の表面の組成を示す詳細な画像を提供する、初の鉱物マップを作成しました。\n\nEMITの主任研究員でありJPLの上級研究員であるロバート・グリーン氏は次のように述べています。「EMITから得られるデータは、地球の加熱と冷却、そしてそのサイクルにおいて鉱物粉塵が果たす役割についてのより多くの洞察を与えるでしょう。」これほど短期間でミッションから得られるデータ量を確認できるのは期待が持てる」とNASAの主任科学者兼上級気候顧問のケイト・カルビン氏は語った。 「EMITは、国際宇宙ステーションにある7つの地球科学機器のうちの1つで、私たちの地球が気候変動によってどのような影響を受けるかについてより多くの情報を提供します。」\n\nもう 1 つの鉱物地図には、トリポリの南約 500 マイル (800 キロメートル) のサハラ砂漠の人口まばらな地域に、大量のカオリナイトと 2 つの酸化鉄、ヘマタイトとゲーサイトが示されています。酸化鉄が豊富な地域からの濃い色の塵粒子は、太陽からのエネルギーを強く吸収して大気を加熱し、気候に影響を与える可能性があります。\nEMIT は、6 大陸にわたって数十億件の新しい分光測定値を収集し、この知識のギャップを埋め、気候科学を進歩させます。 「この卓越したパフォーマンスにより、私たちは1年以内に地球の地表の約25％に相当する地球の乾燥地域の鉱物の包括的な地図を作成し、気候科学の目標を達成する軌道に乗っています」とグリーン氏は述べた。\n\nEMITのデータは、例えばリチウムや希土類元素などの戦略的に重要な鉱物の探索など、幅広い調査にも自由に利用できるようになる。さらに、この機器の技術は、気候変動に対処することを目的とした一連のミッションである NASA の地球システム観測所の一部である、将来の地表生物地質学 (SBG) 衛星ミッションの基礎を築いています。\n\n詳細については、https://earth.jpl.nasa.gov/emit/news/21/nasa-dust-detective-delivers-first-maps-from-space-for-climate-science/をご覧ください。',
    },
    'l3caxowd': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '944zfio2': {
      'en': 'October 12, 2022',
      'de': '12. Oktober 2022',
      'es': '12 de octubre de 2022',
      'fr': '12 octobre 2022',
      'it': '12 ottobre 2022',
      'ja': '2022 年 10 月 12 日',
    },
    'q4f6ia8n': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // October252022
  {
    'rf1ozn8k': {
      'en':
          ' Methane ‘Super-Emitters\' Mapped by NASA\'s New Earth Space Mission\n\nEMIT is mapping the prevalence of key minerals in the planet’s dust-producing deserts – information that will advance our understanding of airborne dust’s effects on climate. But EMIT has demonstrated another crucial capability: detecting the presence of methane, a potent greenhouse gas. \n“Reining in methane emissions is key to limiting global warming. This exciting new development will not only help researchers better pinpoint where methane leaks are coming from, but also provide insight on how they can be addressed – quickly,” said NASA Administrator Bill Nelson. Methane absorbs infrared light in a unique pattern – called a spectral fingerprint – that EMIT’s imaging spectrometer can discern with high accuracy and precision. The instrument can also measure carbon dioxide.\n\nFor more information, visit: \nhttps://earth.jpl.nasa.gov/emit/news/23/methane-super-emitters-mapped-by-nasas-new-earth-space-mission/ \n',
      'de':
          'Methan-„Superemitter“, kartiert von der New Earth Space Mission der NASA\n\nEMIT kartiert die Verbreitung wichtiger Mineralien in den staubproduzierenden Wüsten des Planeten – Informationen, die unser Verständnis der Auswirkungen von Staub in der Luft auf das Klima verbessern werden. Aber EMIT hat eine weitere entscheidende Fähigkeit bewiesen: den Nachweis des Vorhandenseins von Methan, einem starken Treibhausgas.\n„Die Eindämmung der Methanemissionen ist der Schlüssel zur Begrenzung der globalen Erwärmung. „Diese aufregende neue Entwicklung wird Forschern nicht nur dabei helfen, besser zu bestimmen, woher Methanlecks kommen, sondern auch Erkenntnisse darüber liefern, wie sie schnell behoben werden können“, sagte NASA-Administrator Bill Nelson. Methan absorbiert Infrarotlicht in einem einzigartigen Muster – einem sogenannten spektralen Fingerabdruck –, das das bildgebende Spektrometer von EMIT mit hoher Genauigkeit und Präzision erkennen kann. Das Instrument kann auch Kohlendioxid messen.\n\nFür weitere Informationen besuchen Sie:\nhttps://earth.jpl.nasa.gov/emit/news/23/methan-super-emitters-mapped-by-nasas-new-earth-space-mission/',
      'es':
          '\'Superemisores\' de metano mapeados por la nueva misión espacial terrestre de la NASA\n\nEMIT está mapeando la prevalencia de minerales clave en los desiertos productores de polvo del planeta, información que mejorará nuestra comprensión de los efectos del polvo en el aire sobre el clima. Pero EMIT ha demostrado otra capacidad crucial: detectar la presencia de metano, un potente gas de efecto invernadero.\n“Controlar las emisiones de metano es clave para limitar el calentamiento global. Este nuevo e interesante desarrollo no sólo ayudará a los investigadores a identificar mejor de dónde provienen las fugas de metano, sino que también proporcionará información sobre cómo abordarlas rápidamente”, dijo el administrador de la NASA, Bill Nelson. El metano absorbe la luz infrarroja en un patrón único, llamado huella digital espectral, que el espectrómetro de imágenes de EMIT puede discernir con gran exactitud y precisión. El instrumento también puede medir dióxido de carbono.\n\nPara más información visite:\nhttps://earth.jpl.nasa.gov/emit/news/23/metano-super-emitters-mapped-by-nasas-new-earth-space-mission/',
      'fr':
          'Les « super-émetteurs » de méthane cartographiés par la nouvelle mission spatiale terrestre de la NASA\n\nEMIT cartographie la prévalence de minéraux clés dans les déserts producteurs de poussière de la planète – des informations qui feront progresser notre compréhension des effets de la poussière en suspension dans l’air sur le climat. Mais EMIT a démontré une autre capacité cruciale : détecter la présence de méthane, un puissant gaz à effet de serre.\n« La maîtrise des émissions de méthane est essentielle pour limiter le réchauffement climatique. Ce nouveau développement passionnant aidera non seulement les chercheurs à mieux identifier l’origine des fuites de méthane, mais fournira également un aperçu de la manière dont elles peuvent être traitées – rapidement », a déclaré l’administrateur de la NASA, Bill Nelson. Le méthane absorbe la lumière infrarouge selon un motif unique – appelé empreinte spectrale – que le spectromètre imageur d’EMIT peut discerner avec une grande exactitude et précision. L\'instrument peut également mesurer le dioxyde de carbone.\n\nPour plus d\'informations, visitez:\nhttps://earth.jpl.nasa.gov/emit/news/23/methane-super-emitters-mapped-by-nasas-new-earth-space-mission/',
      'it':
          'I “superemettitori” di metano mappati dalla missione spaziale New Earth della NASA\n\nL’EMIT sta mappando la prevalenza dei minerali chiave nei deserti del pianeta produttori di polvere: informazioni che miglioreranno la nostra comprensione degli effetti della polvere nell’aria sul clima. Ma l’EMIT ha dimostrato un’altra capacità cruciale: rilevare la presenza di metano, un potente gas serra.\n“Contenere le emissioni di metano è fondamentale per limitare il riscaldamento globale. Questo nuovo entusiasmante sviluppo non solo aiuterà i ricercatori a individuare meglio da dove provengono le perdite di metano, ma fornirà anche informazioni su come affrontarle, in modo rapido”, ha affermato l’amministratore della NASA Bill Nelson. Il metano assorbe la luce infrarossa in uno schema unico – chiamato “impronta digitale spettrale” – che lo spettrometro per immagini di EMIT può discernere con elevata accuratezza e precisione. Lo strumento può anche misurare l\'anidride carbonica.\n\nPer maggiori informazioni visita:\nhttps://earth.jpl.nasa.gov/emit/news/23/manthrope-super-emitters-mapped-by-nasas-new-earth-space-mission/',
      'ja':
          'NASAの新しい地球宇宙ミッションによってマッピングされたメタンの「スーパーエミッター」\n\nEMIT は、地球上の粉塵を生み出す砂漠における主要な鉱物の分布状況をマッピングしています。この情報は、空気中の粉塵が気候に及ぼす影響についての理解を進めることになります。しかし、EMIT は別の重要な機能を実証しました。それは、強力な温室効果ガスであるメタンの存在を検出することです。\n「メタンの排出を抑制することが地球温暖化を抑制する鍵です。このエキサイティングな新開発は、研究者がメタン漏洩の原因をより正確に特定するのに役立つだけでなく、メタン漏洩に迅速に対処する方法についての洞察も提供します」とNASA長官ビル・ネルソンは述べた。メタンは、スペクトル指紋と呼ばれる独特のパターンで赤外線を吸収します。EMIT の画像分光計は、このパターンを高精度かつ正確に識別できます。この機器は二酸化炭素も測定できます。\n\n詳細については、以下を参照してください。\nhttps://earth.jpl.nasa.gov/emit/news/23/methane-super-emitters-mapped-by-nasas-new-earth-space-mission/',
    },
    'g1d8oufu': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'rab3rhtm': {
      'en': 'October 25, 2022',
      'de': '25. Oktober 2022',
      'es': '25 de octubre de 2022',
      'fr': '25 octobre 2022',
      'it': '25 ottobre 2022',
      'ja': '2022年10月25日',
    },
    'q1zubw5e': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // December152022
  {
    '1ggclii7': {
      'en':
          'NASA Sensors help detect methane emitted by landfills. \n\nUsing data from NASA’s EMIT mission, plus current airborne and future satellite instruments, will be part of a global survey of point-source emissions of methane from solid waste sites such as landfills.\nTo improve predictions of how future climate scenarios might change the amount and type of mineral dust emitted into Earth’s atmosphere.\n\nFor more information, visit: \nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-methane-emitted-by-landfills/\n',
      'de':
          'NASA-Sensoren helfen bei der Erkennung von Methan, das von Mülldeponien ausgestoßen wird.\n\nDie Verwendung von Daten der EMIT-Mission der NASA sowie aktueller luftgestützter und zukünftiger Satelliteninstrumente wird Teil einer globalen Untersuchung der punktuellen Methanemissionen aus festen Abfalldeponien wie Deponien sein.\nVerbesserung der Vorhersagen darüber, wie zukünftige Klimaszenarien die Menge und Art des in die Erdatmosphäre emittierten Mineralstaubs verändern könnten.\n\nFür weitere Informationen besuchen Sie:\nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-methan-emitted-by-landfills/',
      'es':
          'Los sensores de la NASA ayudan a detectar el metano emitido por los vertederos.\n\nEl uso de datos de la misión EMIT de la NASA, además de instrumentos satelitales actuales y futuros, será parte de un estudio global de las emisiones puntuales de metano de los sitios de desechos sólidos, como los vertederos.\nMejorar las predicciones sobre cómo los escenarios climáticos futuros podrían cambiar la cantidad y el tipo de polvo mineral emitido a la atmósfera de la Tierra.\n\nPara más información visite:\nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-mtane-emitted-by-landfills/',
      'fr':
          'Les capteurs de la NASA aident à détecter le méthane émis par les décharges.\n\nL’utilisation des données de la mission EMIT de la NASA, ainsi que des instruments aéroportés et satellitaires actuels, fera partie d’une enquête mondiale sur les émissions ponctuelles de méthane provenant des sites de déchets solides tels que les décharges.\nAméliorer les prévisions sur la manière dont les futurs scénarios climatiques pourraient modifier la quantité et le type de poussière minérale émise dans l’atmosphère terrestre.\n\nPour plus d\'informations, visitez:\nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-methane-emitte-by-landfills/',
      'it':
          'I sensori della NASA aiutano a rilevare il metano emesso dalle discariche.\n\nL’utilizzo dei dati della missione EMIT della NASA, oltre agli attuali strumenti aerei e futuri satellitari, farà parte di un’indagine globale sulle emissioni puntuali di metano provenienti da siti di rifiuti solidi come le discariche.\nMigliorare le previsioni su come i futuri scenari climatici potrebbero modificare la quantità e il tipo di polvere minerale emessa nell’atmosfera terrestre.\n\nPer maggiori informazioni visita:\nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-mETANE-emission-by-landfills/',
      'ja':
          'NASA センサーは、埋め立て地から排出されるメタンの検出に役立ちます。\n\nNASA の EMIT ミッションからのデータに加え、現在航空機搭載および将来の衛星計測器を使用することは、埋め立て地などの固形廃棄物サイトからのメタンの点発生源排出に関する世界規模の調査の一部となります。\n将来の気候シナリオによって、地球の大気中に放出される鉱物粉塵の量と種類がどのように変化するかについての予測を改善するため。\n\n詳細については、以下を参照してください。\nhttps://earth.jpl.nasa.gov/emit/news/24/nasa-sensors-to-help-detect-methane-emitted-by-landfills/',
    },
    '4eyu277q': {
      'en':
          'Methane from the waste sector makes up about 20% of human-caused methane emissions. A new project from a nonprofit group, Carbon Mapper, will use NASA instruments and data to measure emissions from landfills around the globe.\nCredit: Daniel Jędzura / Adobe Stock\n',
      'de':
          'Methan aus dem Abfallsektor macht etwa 20 % der vom Menschen verursachten Methanemissionen aus. Ein neues Projekt einer gemeinnützigen Gruppe, Carbon Mapper, wird NASA-Instrumente und -Daten nutzen, um Emissionen von Mülldeponien rund um den Globus zu messen.\nBildnachweis: Daniel Jędzura / Adobe Stock',
      'es':
          'El metano del sector de residuos representa alrededor del 20% de las emisiones de metano causadas por el hombre. Un nuevo proyecto de un grupo sin fines de lucro, Carbon Mapper, utilizará instrumentos y datos de la NASA para medir las emisiones de los vertederos de todo el mundo.\nCrédito: Daniel Jędzura / Adobe Stock',
      'fr':
          'Le méthane provenant du secteur des déchets représente environ 20 % des émissions de méthane d’origine humaine. Un nouveau projet d\'un groupe à but non lucratif, Carbon Mapper, utilisera les instruments et les données de la NASA pour mesurer les émissions des décharges du monde entier.\nCrédit : Daniel Jędzura / Adobe Stock',
      'it':
          'Il metano proveniente dal settore dei rifiuti costituisce circa il 20% delle emissioni di metano causate dall’uomo. Un nuovo progetto di un gruppo no-profit, Carbon Mapper, utilizzerà strumenti e dati della NASA per misurare le emissioni provenienti dalle discariche di tutto il mondo.\nCredito: Daniel Jędzura / Adobe Stock',
      'ja':
          '廃棄物部門からのメタンは、人為的メタン排出量の約 20% を占めます。非営利団体 Carbon Mapper による新しいプロジェクトでは、NASA の機器とデータを使用して、世界中の埋め立て地からの排出量を測定します。\nクレジット: Daniel Jędzura / Adob​​e Stock',
    },
    'ke2zwjyy': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '78ac174i': {
      'en': 'December 15, 2022',
      'de': '15. Dezember 2022',
      'es': '15 de diciembre de 2022',
      'fr': '15 décembre 2022',
      'it': '15 dicembre 2022',
      'ja': '2022 年 12 月 15 日',
    },
    'nnkcd8fj': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // EMITforyou
  {
    '3l01d8xt': {
      'en':
          'Your location is: Cordoba, Argentina.                                  ',
      'de': 'Ihr Standort ist: Cordoba, Argentinien.',
      'es': 'Su ubicación es: Córdoba, Argentina.',
      'fr': 'Votre emplacement est : Cordoba, Argentine.',
      'it': 'La tua posizione è: Cordoba, Argentina.',
      'ja': 'あなたの所在地はアルゼンチンのコルドバです。',
    },
    'ci1hj2x1': {
      'en':
          'EMIT scans for last month of your location                              ',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'mldq2ltk': {
      'en':
          'This image refers to the concentration of methane, in a town near to Cordoba, named El Tuscal.',
      'de':
          'Dieses Bild bezieht sich auf die Methankonzentration in einer Stadt in der Nähe von Cordoba namens El Tuscal.',
      'es':
          'Esta imagen hace referencia a la concentración de metano, en un pueblo cercano a Córdoba, llamado El Tuscal.',
      'fr':
          'Cette image fait référence à la concentration de méthane, dans une ville proche de Cordoue, nommée El Tuscal.',
      'it':
          'Questa immagine si riferisce alla concentrazione di metano, in una cittadina vicino a Cordoba, chiamata El Tuscal.',
      'ja': 'この画像は、コルドバに近いエル・タスカルという町のメタン濃度を示しています。',
    },
    'xpx1ykk5': {
      'en': 'How EMIT can help you in: [Cordoba, Argentina]',
      'de': 'Wie EMIT Ihnen helfen kann in: [Cordoba, Argentinien]',
      'es': 'Cómo EMIT puede ayudarte en: [Córdoba, Argentina]',
      'fr': 'Comment EMIT peut vous aider dans : [Cordoba, Argentine]',
      'it': 'Come EMIT può aiutarti in: [Cordoba, Argentina]',
      'ja': 'EMIT がどのようにお手伝いできるか: [アルゼンチン、コルドバ]',
    },
    'oddxgunt': {
      'en': 'EMIT around the globe',
      'de': 'EMIT rund um den Globus',
      'es': 'EMIT en todo el mundo',
      'fr': 'EMIT dans le monde entier',
      'it': 'EMIT in tutto il mondo',
      'ja': '世界中に発信する',
    },
    '1zvo3lvf': {
      'en': 'How to use VISIONS',
      'de': 'So verwenden Sie VISIONEN',
      'es': 'Cómo utilizar VISIONES',
      'fr': 'Comment utiliser VISIONS',
      'it': 'Come utilizzare VISIONI',
      'ja': 'ビジョンの使い方',
    },
    '242clzo1': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '88chj9mx': {
      'en': 'EMIT for you',
      'de': 'EMIT für Sie',
      'es': 'EMITIR para ti',
      'fr': 'ÉMETTRE pour vous',
      'it': 'EMETTI per te',
      'ja': 'あなたのためにEMIT',
    },
    'll9wahuk': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Easteregg
  {
    'ywpchqjc': {
      'en':
          'Nothing to see here, we are still working on the app! Anyways, here is a game for you to enjoy!\n\nStay tuned!',
      'de':
          'Hier gibt es nichts zu sehen, wir arbeiten noch an der App! Wie auch immer, hier ist ein Spiel, das Ihnen Spaß machen wird!\n\nBleiben Sie dran!',
      'es':
          'No hay nada que ver aquí, ¡todavía estamos trabajando en la aplicación! De todos modos, ¡aquí tienes un juego para que disfrutes!\n\n¡Manténganse al tanto!',
      'fr':
          'Rien à voir ici, nous travaillons toujours sur l\'application ! Quoi qu\'il en soit, voici un jeu pour votre plaisir !\n\nRestez à l\'écoute!',
      'it':
          'Niente da vedere qui, stiamo ancora lavorando sull\'app! Ad ogni modo, ecco un gioco per il tuo divertimento!\n\nRimani sintonizzato!',
      'ja': 'ここには何も表示されません。アプリはまだ開発中です。とにかく、楽しんでいただけるゲームがここにあります！\n\n乞うご期待！',
    },
    'ki0q4igm': {
      'en': 'Credits: NASA and SpaceX',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '5d10hl1c': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Tutorial
  {
    'c05svi4v': {
      'en':
          'Here you can find the Tutorial Series Workshops,to introduce you to EMIT spectroscopy data and how to work with it. During this first workshop you will be provided an introduction to the EMIT mission, measurements, and data applications. \n\nAfter learning how to use VISIONS, you will be able to understand and analyze the data for your own use.\n\nThe tutorial consists of 3 videos:',
      'de':
          'Hier finden Sie die Workshops der Tutorial-Reihe, die Ihnen eine Einführung in die EMIT-Spektroskopiedaten und den Umgang damit geben. Während dieses ersten Workshops erhalten Sie eine Einführung in die EMIT-Mission, Messungen und Datenanwendungen.\n\nNachdem Sie den Umgang mit VISIONS erlernt haben, sind Sie in der Lage, die Daten für Ihren eigenen Gebrauch zu verstehen und zu analysieren.\n\nDas Tutorial besteht aus 3 Videos:',
      'es':
          'Aquí puede encontrar los talleres de la serie de tutoriales para presentarle los datos de espectroscopía EMIT y cómo trabajar con ellos. Durante este primer taller se le proporcionará una introducción a la misión, mediciones y aplicaciones de datos de EMIT.\n\nDespués de aprender a utilizar VISIONS, podrá comprender y analizar los datos para su propio uso.\n\nEl tutorial consta de 3 vídeos:',
      'fr':
          'Vous trouverez ici les ateliers de la série de didacticiels, pour vous présenter les données de spectroscopie EMIT et comment les utiliser. Au cours de ce premier atelier, vous recevrez une introduction à la mission EMIT, aux mesures et aux applications de données.\n\nAprès avoir appris à utiliser VISIONS, vous serez en mesure de comprendre et d\'analyser les données pour votre propre usage.\n\nLe tutoriel se compose de 3 vidéos :',
      'it':
          'Qui puoi trovare i workshop della serie Tutorial, per presentarti i dati della spettroscopia EMIT e come lavorarci. Durante questo primo workshop ti verrà fornita un\'introduzione alla missione EMIT, alle misurazioni e alle applicazioni dei dati.\n\nDopo aver appreso come utilizzare VISIONS, sarai in grado di comprendere e analizzare i dati per uso personale.\n\nIl tutorial è composto da 3 video:',
      'ja':
          'ここでは、EMIT 分光法データとその操作方法を紹介するチュートリアル シリーズ ワークショップを見つけることができます。この最初のワークショップでは、EMIT のミッション、測定、データ アプリケーションについて説明します。\n\nVISIONS の使用方法を学んだ後は、データを理解し、独自に使用するために分析できるようになります。\n\nこのチュートリアルは 3 つのビデオで構成されています。',
    },
    'auyqin8j': {
      'en': 'Here you can check the EMIT Open Data Portal:\n',
      'de': 'Hier können Sie das EMIT Open Data Portal überprüfen:',
      'es': 'Aquí puedes consultar el Portal de Datos Abiertos de EMIT:',
      'fr': 'Ici, vous pouvez consulter le portail EMIT Open Data :',
      'it': 'Qui puoi controllare il portale EMIT Open Data:',
      'ja': 'ここで EMIT オープン データ ポータルを確認できます。',
    },
    'm5oymip2': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '5pfophbc': {
      'en': 'VISIONS tutorial',
      'de': 'VISIONS-Tutorial',
      'es': 'Tutorial VISIONES',
      'fr': 'Tutoriel VISIONS',
      'it': 'Tutorial VISIONI',
      'ja': 'ビジョンのチュートリアル',
    },
    'c4dd2aby': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // EMITaroundtheblobe
  {
    '5x2qobxw': {
      'en':
          'Here you can find the VISION spectroscopy data maps were you can see the points of more concentration of CO2 over the world, in blue.\nAnd the the points of more concentration of methane over the world, in red.\n',
      'de':
          'Hier finden Sie die VISION-Spektroskopiedatenkarten, auf denen Sie in Blau die Punkte mit der höchsten CO2-Konzentration auf der Welt sehen können.\nUnd die Punkte mit höherer Methankonzentration auf der Welt, in Rot.',
      'es':
          'Aquí puedes encontrar los mapas de datos de espectroscopía de VISION donde puedes ver en azul los puntos de mayor concentración de CO2 a nivel mundial.\nY los puntos de mayor concentración de metano en el mundo, en rojo.',
      'fr':
          'Ici vous pouvez trouver les cartes de données de spectroscopie VISION où vous pouvez voir les points de plus forte concentration de CO2 dans le monde, en bleu.\nEt les points de plus grande concentration de méthane dans le monde, en rouge.',
      'it':
          'Qui puoi trovare le mappe dei dati della spettroscopia VISION dove puoi vedere i punti di maggiore concentrazione di CO2 nel mondo, in blu.\nE i punti di maggiore concentrazione di metano nel mondo, in rosso.',
      'ja':
          'ここでは、VISION 分光法データ マップを参照してください。世界中の CO2 濃度が高い地点が青で表示されています。\nそして、世界中でメタンがさらに集中している地点を赤で示しています。',
    },
    'azi9ycto': {
      'en':
          'VISIONS includes an advantage to see the next scan that will show in the map, shown by yellow quadrant lines. On the other hand the blue scan is information already available.\n',
      'de':
          'VISIONS bietet den Vorteil, den nächsten Scan zu sehen, der in der Karte durch gelbe Quadrantenlinien angezeigt wird. Beim blauen Scan hingegen handelt es sich um bereits verfügbare Informationen.',
      'es':
          'VISIONS incluye la ventaja de ver el siguiente escaneo que se mostrará en el mapa, mostrado por líneas de cuadrante amarillas. Por otro lado, el escaneo azul es información que ya está disponible.',
      'fr':
          'VISIONS inclut l\'avantage de voir le prochain scan qui s\'affichera sur la carte, indiqué par des lignes de quadrant jaunes. En revanche, le scan bleu contient des informations déjà disponibles.',
      'it':
          'VISIONS include il vantaggio di vedere la scansione successiva che verrà visualizzata sulla mappa, indicata da linee quadranti gialle. D\'altra parte la scansione blu è un\'informazione già disponibile.',
      'ja':
          'VISIONS には、マップ内に黄色の四分円で示される次のスキャンを確認できるという利点があります。一方、青いスキャンはすでに入手可能な情報です。',
    },
    'm99ec2km': {
      'en':
          'The yellow scan is a specific future trajectory that will go above Africa.\n',
      'de':
          'Der gelbe Scan ist eine spezifische zukünftige Flugbahn, die über Afrika hinausgehen wird.',
      'es':
          'El escaneo amarillo es una trayectoria futura específica que irá por encima de África.',
      'fr':
          'Le balayage jaune est une trajectoire future spécifique qui ira au-dessus de l’Afrique.',
      'it':
          'La scansione gialla è una traiettoria futura specifica che andrà al di sopra dell’Africa.',
      'ja': '黄色のスキャンは、アフリカを越える具体的な将来の軌道です。',
    },
    '8ra42po9': {
      'en':
          'What is PPM-M? \n\nParts-per-million-meter or “ppm-m”, is the unit of measurement for path-integrated gas concentration, which refers to how much of gas is present along a column of gas.\n',
      'de':
          'Was ist PPM-M?\n\nTeile pro Million Meter oder „ppm-m“ ist die Maßeinheit für die pfadintegrierte Gaskonzentration, die sich darauf bezieht, wie viel Gas entlang einer Gassäule vorhanden ist.',
      'es':
          '¿Qué es PPM-M?\n\nPartes por millón de metro o \"ppm-m\" es la unidad de medida para la concentración de gas en la trayectoria integrada, que se refiere a la cantidad de gas presente a lo largo de una columna de gas.',
      'fr':
          'Qu’est-ce que le PPM-M ?\n\nLes parties par million de mètres ou « ppm-m » sont l\'unité de mesure de la concentration de gaz intégrée au trajet, qui fait référence à la quantité de gaz présente le long d\'une colonne de gaz.',
      'it':
          'Cos\'è il PPM-M?\n\nParti per milione di metri o “ppm-m” è l\'unità di misura per la concentrazione di gas integrata nel percorso, che si riferisce alla quantità di gas presente lungo una colonna di gas.',
      'ja':
          'PPM-Mとは何ですか?\n\n100 万分の 1 メートルまたは「ppm-m」は、経路統合ガス濃度の測定単位であり、ガスの柱に沿ってどれだけのガスが存在するかを指します。',
    },
    '6rgyc0i9': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    '02zazunu': {
      'en': 'EMIT around the globe',
      'de': 'EMIT rund um den Globus',
      'es': 'EMIT en todo el mundo',
      'fr': 'EMIT dans le monde entier',
      'it': 'EMIT in tutto il mondo',
      'ja': '世界中に発信する',
    },
    'wc3e2p34': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // HowEMITcanhelpyou
  {
    'vupd21tc': {
      'en':
          'Here you can find how EMIT can help you in: [Cordoba, Argentina]\n',
      'de':
          'Hier erfahren Sie, wie EMIT Ihnen helfen kann in: [Cordoba, Argentinien]',
      'es':
          'Aquí podrás encontrar cómo EMIT puede ayudarte en: [Córdoba, Argentina]',
      'fr':
          'Vous trouverez ici comment EMIT peut vous aider dans : [Cordoba, Argentine]',
      'it': 'Qui puoi scoprire come EMIT può aiutarti in: [Cordoba, Argentina]',
      'ja': 'EMIT がどのようにお手伝いできるかはこちらでご覧いただけます: [コルドバ、アルゼンチン]',
    },
    'lei2o0cw': {
      'en':
          'EMIT scan for last month of your location                              ',
      'de': 'EMIT-Scan für den letzten Monat Ihres Standorts',
      'es': 'Escaneo EMIT del último mes de su ubicación',
      'fr': 'EMIT scan pour le mois dernier de votre emplacement',
      'it': 'Scansione EMIT per l\'ultimo mese della tua posizione',
      'ja': '現在地の先月のスキャンをEMITします',
    },
    '3wun8weo': {
      'en':
          'EMIT in your community is of great significance as the analysis can determine how mineral dust affects the climate in the area, mapping the composition of your arid zone, thus helping us understand its impact on warming and cooling. The region of Córdoba, Argentina, is known for its lack of major water sources, which is why it\'s essential for small-scale producers to comprehend EMIT\'s data. This knowledge enables them to better predict and understand crop cycles, optimizing resource allocation in response to various factors like rainfall, wind, and dust. EMIT could assist in monitoring dust currents and provide information on the minerals expected in these storms, enabling workers to make informed decisions about the best timing for planting.\n\nFurthermore, EMIT\'s analysis of crucial minerals in the area will help communities create job opportunities, thereby improving the local economy and living conditions. It allows for the detection of substances attracted in these storms and counteracting environmental pollutants that affect both the environment and living organisms.\n\nMoreover, EMIT enables the identification of minerals in your area, which are of paramount importance as their components influence the warming or cooling of this region. An example of this is the analysis of methane:\n',
      'de':
          'EMIT in Ihrer Gemeinde ist von großer Bedeutung, da die Analyse ermitteln kann, wie sich Mineralstaub auf das Klima in der Region auswirkt, die Zusammensetzung Ihrer Trockenzone abbildet und uns so dabei hilft, deren Auswirkungen auf Erwärmung und Abkühlung zu verstehen. Die Region Córdoba in Argentinien ist für ihren Mangel an wichtigen Wasserquellen bekannt, weshalb es für Kleinproduzenten wichtig ist, die Daten von EMIT zu verstehen. Dieses Wissen ermöglicht es ihnen, Erntezyklen besser vorherzusagen und zu verstehen und die Ressourcenzuteilung als Reaktion auf verschiedene Faktoren wie Niederschlag, Wind und Staub zu optimieren. EMIT könnte bei der Überwachung von Staubströmen helfen und Informationen über die in diesen Stürmen zu erwartenden Mineralien liefern, sodass Arbeiter fundierte Entscheidungen über den besten Zeitpunkt für die Pflanzung treffen können.\n\nDarüber hinaus wird die Analyse wichtiger Mineralien in der Region durch EMIT den Gemeinden dabei helfen, Beschäftigungsmöglichkeiten zu schaffen und so die lokale Wirtschaft und die Lebensbedingungen zu verbessern. Es ermöglicht die Erkennung von Substanzen, die von diesen Stürmen angezogen werden, und wirkt Umweltschadstoffen entgegen, die sowohl die Umwelt als auch lebende Organismen beeinträchtigen.\n\nDarüber hinaus ermöglicht EMIT die Identifizierung von Mineralien in Ihrer Region, die von größter Bedeutung sind, da ihre Bestandteile die Erwärmung oder Abkühlung dieser Region beeinflussen. Ein Beispiel hierfür ist die Analyse von Methan:',
      'es':
          'Las EMIT en su comunidad son de gran importancia ya que el análisis puede determinar cómo el polvo mineral afecta el clima en el área, mapeando la composición de su zona árida, ayudándonos así a comprender su impacto en el calentamiento y el enfriamiento. La región de Córdoba, Argentina, es conocida por su falta de importantes fuentes de agua, por lo que es esencial que los pequeños productores comprendan los datos de EMIT. Este conocimiento les permite predecir y comprender mejor los ciclos de los cultivos, optimizando la asignación de recursos en respuesta a diversos factores como la lluvia, el viento y el polvo. EMIT podría ayudar a monitorear las corrientes de polvo y proporcionar información sobre los minerales que se esperan en estas tormentas, permitiendo a los trabajadores tomar decisiones informadas sobre el mejor momento para plantar.\n\nAdemás, el análisis de EMIT de minerales cruciales en el área ayudará a las comunidades a crear oportunidades de empleo, mejorando así la economía local y las condiciones de vida. Permite detectar sustancias atraídas en estas tormentas y contrarrestar los contaminantes ambientales que afectan tanto al medio ambiente como a los organismos vivos.\n\nAdemás, EMIT permite la identificación de minerales en su área, que son de suma importancia ya que sus componentes influyen en el calentamiento o enfriamiento de esta región. Un ejemplo de esto es el análisis del metano:',
      'fr':
          'EMIT dans votre communauté est d\'une grande importance car l\'analyse peut déterminer comment la poussière minérale affecte le climat de la région, cartographiant la composition de votre zone aride, nous aidant ainsi à comprendre son impact sur le réchauffement et le refroidissement. La région de Cordoue, en Argentine, est connue pour son manque de sources d\'eau majeures, c\'est pourquoi il est essentiel que les petits producteurs comprennent les données d\'EMIT. Ces connaissances leur permettent de mieux prévoir et comprendre les cycles des cultures, en optimisant l\'allocation des ressources en réponse à divers facteurs tels que les précipitations, le vent et la poussière. EMIT pourrait aider à surveiller les courants de poussière et fournir des informations sur les minéraux attendus dans ces tempêtes, permettant ainsi aux travailleurs de prendre des décisions éclairées sur le meilleur moment pour planter.\n\nEn outre, l\'analyse réalisée par EMIT sur les minéraux essentiels de la région aidera les communautés à créer des opportunités d\'emploi, améliorant ainsi l\'économie locale et les conditions de vie. Il permet de détecter les substances attirées par ces tempêtes et de lutter contre les polluants environnementaux qui affectent à la fois l\'environnement et les organismes vivants.\n\nDe plus, EMIT permet l\'identification des minéraux dans votre région, qui sont d\'une importance primordiale car leurs composants influencent le réchauffement ou le refroidissement de cette région. Un exemple en est l’analyse du méthane :',
      'it':
          'L\'EMIT nella tua comunità è di grande importanza poiché l\'analisi può determinare in che modo la polvere minerale influisce sul clima nell\'area, mappando la composizione della tua zona arida, aiutandoci così a comprenderne l\'impatto sul riscaldamento e sul raffreddamento. La regione di Córdoba, in Argentina, è nota per la mancanza di grandi fonti d\'acqua, motivo per cui è essenziale che i piccoli produttori comprendano i dati di EMIT. Questa conoscenza consente loro di prevedere e comprendere meglio i cicli delle colture, ottimizzando l’allocazione delle risorse in risposta a vari fattori come precipitazioni, vento e polvere. EMIT potrebbe aiutare a monitorare le correnti di polvere e fornire informazioni sui minerali previsti in queste tempeste, consentendo ai lavoratori di prendere decisioni informate sul momento migliore per la semina.\n\nInoltre, l\'analisi effettuata dall\'EMIT sui minerali cruciali della zona aiuterà le comunità a creare opportunità di lavoro, migliorando così l\'economia locale e le condizioni di vita. Permette di rilevare le sostanze attratte da queste tempeste e di contrastare gli inquinanti ambientali che colpiscono sia l\'ambiente che gli organismi viventi.\n\nInoltre, EMIT consente l\'identificazione dei minerali nella tua zona, che sono di fondamentale importanza poiché i loro componenti influenzano il riscaldamento o il raffreddamento di questa regione. Un esempio di ciò è l’analisi del metano:',
      'ja':
          '地域社会での EMIT は、分析によって鉱物粉塵が地域の気候にどのような影響を与えるかを特定し、乾燥地帯の組成をマッピングできるため、温暖化と寒冷化への影響を理解するのに役立つため、非常に重要です。アルゼンチンのコルドバ地域は主要な水源が存在しないことで知られており、そのため小規模生産者にとって EMIT のデータを理解することが不可欠です。この知識により、作物のサイクルをより適切に予測して理解できるようになり、降雨、風、粉塵などのさまざまな要因に応じて資源配分を最適化できます。 EMITは、塵流の監視を支援し、これらの嵐で予想される鉱物に関する情報を提供することで、作業員が植栽の最適なタイミングについて情報に基づいた決定を下せるようにすることができます。\n\nさらに、EMITによるこの地域の重要な鉱物の分析は、コミュニティが雇用の機会を創出するのに役立ち、それによって地域の経済と生活条件が改善されます。これにより、これらの嵐に引き寄せられる物質を検出し、環境と生物の両方に影響を与える環境汚染物質に対抗することが可能になります。\n\nさらに、EMIT を使用すると、お住まいの地域の鉱物を特定することができます。鉱物の成分はこの地域の温暖化または寒冷化に影響を与えるため、非常に重要です。この例としては、メタンの分析があります。',
    },
    '726frsma': {
      'en':
          'This is important because this potent greenhouse gas is a significant driver of climate change, with agriculture being both a victim and contributor to this issue.',
      'de':
          'Dies ist wichtig, da dieses starke Treibhausgas ein wesentlicher Treiber des Klimawandels ist und die Landwirtschaft sowohl Opfer als auch Mitverursacher dieses Problems ist.',
      'es':
          'Esto es importante porque este potente gas de efecto invernadero es un importante impulsor del cambio climático, y la agricultura es a la vez víctima y contribuyente a este problema.',
      'fr':
          'Ceci est important car ce puissant gaz à effet de serre est un moteur important du changement climatique, l’agriculture étant à la fois une victime et un contributeur à ce problème.',
      'it':
          'Questo è importante perché questo potente gas serra è un fattore significativo del cambiamento climatico, di cui l’agricoltura è sia vittima che contributore.',
      'ja': 'この強力な温室効果ガスは気候変動の重大な推進要因であり、農業はこの問題の被害者でもあり貢献者でもあるため、これは重要です。',
    },
    'tvhevi4l': {
      'en':
          'What is PPM-M? \n\nParts-per-million-meter or “ppm-m”, is the unit of measurement for path-integrated gas concentration, which refers to how much of gas is present along a column of gas.\n',
      'de':
          'Was ist PPM-M?\n\nTeile pro Million Meter oder „ppm-m“ ist die Maßeinheit für die pfadintegrierte Gaskonzentration, die sich darauf bezieht, wie viel Gas entlang einer Gassäule vorhanden ist.',
      'es':
          '¿Qué es PPM-M?\n\nPartes por millón de metro o \"ppm-m\" es la unidad de medida para la concentración de gas en la trayectoria integrada, que se refiere a la cantidad de gas presente a lo largo de una columna de gas.',
      'fr':
          'Qu’est-ce que le PPM-M ?\n\nLes parties par million de mètres ou « ppm-m » sont l\'unité de mesure de la concentration de gaz intégrée au trajet, qui fait référence à la quantité de gaz présente le long d\'une colonne de gaz.',
      'it':
          'Cos\'è il PPM-M?\n\nParti per milione di metri o “ppm-m” è l\'unità di misura per la concentrazione di gas integrata nel percorso, che si riferisce alla quantità di gas presente lungo una colonna di gas.',
      'ja':
          'PPM-Mとは何ですか?\n\n100 万分の 1 メートルまたは「ppm-m」は、経路統合ガス濃度の測定単位であり、ガスの柱に沿ってどれだけのガスが存在するかを指します。',
    },
    'hgbekcjk': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
    'orfk0pbo': {
      'en': 'How EMIT can help you ',
      'de': 'Wie EMIT Ihnen helfen kann',
      'es': 'Cómo EMIT puede ayudarle',
      'fr': 'Comment EMIT peut vous aider',
      'it': 'Come EMIT può aiutarti',
      'ja': 'EMIT がどのように役立つか',
    },
    'm35rvus7': {
      'en': 'Home',
      'de': 'Heim',
      'es': 'Hogar',
      'fr': 'Maison',
      'it': 'Casa',
      'ja': '家',
    },
  },
  // Miscellaneous
  {
    'e10m3hj3': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'i3a9n6hv': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '95ckern7': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'adxf803k': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'kz6pktwi': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'g95q9y67': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'cbyra5le': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'flx8lfk5': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'egubar2f': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'itqqn5kj': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'dupnrenh': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'rdm22si9': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'gkc17wgx': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '0tjshwa1': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'eu6wguaa': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '7njpochy': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    's7qritcv': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '45anvlmn': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'axnkboqv': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '8w9ks8s2': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    '483jjajs': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'b1f48jj3': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
    'goqkz6w0': {
      'en': '',
      'de': '',
      'es': '',
      'fr': '',
      'it': '',
      'ja': '',
    },
  },
].reduce((a, b) => a..addAll(b));
