# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

fix-flow-nav-high-risk-data-breaches = Yüksek riskli veri ihlalleri
fix-flow-nav-leaked-passwords = Sızan parolalar
fix-flow-nav-security-recommendations = Güvenlik önerileri
guided-resolution-flow-exit = Kontrol paneline dön
guided-resolution-flow-back-arrow = Önceki adıma git
guided-resolution-flow-next-arrow = Sonraki adıma git
guided-resolution-flow-step-navigation-label = Rehberli adımlar

# Celebration screens


## Shared CTA labels

fix-flow-celebration-next-label = Devam edelim
fix-flow-celebration-next-recommendations-label = Önerilere bak
fix-flow-celebration-next-dashboard-label = Kontrol panelinize gidin

## High-risk flow

fix-flow-celebration-high-risk-title = Yüksek riskli ihlallerinizi düzeltdiniz!
fix-flow-celebration-high-risk-description-next-passwords = Şimdi açığa çıkmış parolaları düzeltelim.
fix-flow-celebration-high-risk-description-next-security-questions = Şimdi açığa çıkmış güvenlik sorularınızı düzeltelim.
fix-flow-celebration-high-risk-description-next-security-recommendations = Ardından, hangi verilerinizin ele geçirildiğine göre size kişiselleştirilmiş güvenlik önerileri sunacağız.
fix-flow-celebration-high-risk-description-next-dashboard = Adımlarınızın sonuna geldiniz. Kontrol panelinizden istediğiniz işlemi görebilir ve ilerlemenizi takip edebilirsiniz.

## Leaked passwords and security questions flow

fix-flow-celebration-leaked-passwords-title = Parolalarınız artık koruma altında!
fix-flow-celebration-security-questions-title = Güvenlik sorularınız koruma altında!
fix-flow-celebration-leaked-passwords-description-next-security-questions = Şimdi açığa çıkmış güvenlik sorularınızı inceleyip güncelleyelim.
fix-flow-celebration-leaked-passwords-description-next-security-recommendations = Ardından, hangi verilerinizin ele geçirildiğine göre size kişiselleştirilmiş güvenlik önerileri sunacağız.
fix-flow-celebration-leaked-passwords-description-next-dashboard = Tebrikler! Adımlarınızın sonuna geldiniz. Kontrol panelinizden istediğiniz işlemi görebilir ve ilerlemenizi takip edebilirsiniz.

## Security recommendations flow

fix-flow-celebration-security-recommendations-title = Tüm önerileri tamamladınız!
fix-flow-celebration-security-recommendations-description-next-dashboard = Tebrikler! Adımlarınızın sonuna geldiniz. Kontrol panelinizden istediğiniz işlemi görebilir ve ilerlemenizi takip edebilirsiniz.

# High Risk Data Breaches

high-risk-breach-heading = İşte yapmanız gerekenler
high-risk-breach-subheading = Bu işlem hassas bilgilerinize erişilmesini gerektirdiği için bunları kendiniz düzeltmeniz gerekiyor.
# Variables
# $num_breaches is the number of breaches where the high risk data was found.
high-risk-breach-summary =
    { $num_breaches ->
        [one] { $num_breaches } veri ihlalinde yer alıyor:
       *[other] { $num_breaches } veri ihlalinde yer alıyor:
    }
# Variables
# $breach_name is the name of the breach where the high risk data was found.
# $breach_date is the date when the breach occurred.
# An example of this string is Twitter on 13/09/18.
high-risk-breach-name-and-date = { $breach_name }, <breach_date>{ $breach_date } tarihinde</breach_date>
high-risk-breach-mark-as-fixed = Düzeltildi olarak işaretle
high-risk-breach-skip = Şimdilik geç
# Variables:
# $estimated_time is the estimated time it would take for a user to complete breach resolution steps. It not be singular, and the + is meant as "or more".
# An example of this string is Your estimated time: 15+ minutes.
high-risk-breach-estimated-time =
    { $estimated_time ->
        [one] Tahmini süre: { $estimated_time }+ dakika
       *[other] Tahmini süre: { $estimated_time }+ dakika
    }

# Credit Card Breaches

high-risk-breach-credit-card-title = Kredi kartı numaranız ele geçirildi
high-risk-breach-credit-card-step-one = Bu kartı hâlâ kullanıyorsanız kartı düzenleyen kuruluşla iletişime geçerek kartın çalındığını bildirin.
high-risk-breach-credit-card-step-two = Yeni bir numaraya sahip yeni bir kart isteyin.
high-risk-breach-credit-card-step-three = Hesaplarınızda tanımadığınız ödemeler olup olmadığını kontrol edin.

# Bank Account Breaches

high-risk-breach-bank-account-title = Banka hesap numaranız ele geçirildi
high-risk-breach-bank-account-description = En kısa sürede harekete geçmeniz, kayıplarınızı karşılamanıza yardımcı olacak daha fazla hukuki koruma sağlayabilir.
high-risk-breach-bank-account-step-one = Hesap numaranızın ele geçirildiğini hemen bankanıza bildirin.
high-risk-breach-bank-account-step-two = Hesap numaranızı değiştirin.
high-risk-breach-bank-account-step-three = Hesaplarınızda tanımadığınız ödemeler olup olmadığını kontrol edin.

# Social Security Number Breaches

high-risk-breach-social-security-title = Sosyal güvenlik numaranız ele geçirildi

# Social Security Number Modal

ssn-modal-ok = Tamam

# PIN Breaches

high-risk-breach-pin-title = PIN’iniz ele geçirilmiş
high-risk-breach-pin-description = En kısa sürede harekete geçmeniz, kayıplarınızı karşılamanıza yardımcı olacak daha fazla hukuki koruma sağlayabilir.
high-risk-breach-pin-step-one = PIN’inizin ele geçirildiğini hemen bankanıza bildirin.
high-risk-breach-pin-step-two = Aynı PIN’i kullandığınız her yerde PIN’lerinizi değiştirin.
high-risk-breach-pin-step-three = Hesaplarınızda tanımadığınız ödemeler olup olmadığını kontrol edin.

# No high risk breaches found

# Variables
# $email_list is list of emails that the user is monitoring for breaches. E.g. john@yahoo.com, ali@gmail.com, sam@hotmail.com
high-risk-breach-none-description = E-posta adresinize bağlı olarak veri ihlalleri tespit ettik. { $email_list } için yüksek riskli veri ihlalleri bulamadık.
high-risk-breach-none-sub-description-part-one = Yüksek riskli veri ihlalleri şunlardır:
high-risk-breach-none-sub-description-ssn = Sosyal güvenlik numarası
high-risk-breach-none-sub-description-bank-account = Banka hesap bilgileri
high-risk-breach-none-sub-description-cc-number = Kredi kartı numaraları
high-risk-breach-none-sub-description-pin = PIN'ler
high-risk-breach-none-continue = Devam et

# Security recommendations

security-recommendation-steps-label = Güvenlik önerileri
security-recommendation-steps-title = Tavsiyemiz:
security-recommendation-steps-cta-label = Anladım!

# Phone security recommendation

security-recommendation-phone-title = Telefon numaranızı koruyun
# $num_breaches is the number of breaches where the phone number was found.
security-recommendation-phone-summary =
    { $num_breaches ->
        [one] Telefon numaranız { $num_breaches } veri ihlalinde ele geçirildi:
       *[other] Telefon numaranız { $num_breaches } veri ihlalinde ele geçirildi:
    }
security-recommendation-phone-description = Maalesef bunu geri alamazsınız ama güvende kalmak için atabileceğiniz adımlar var.
security-recommendation-phone-step-one = Daha fazla gereksiz aramayı önlemek için spam numaraları engelleyebilirsiniz

# Email security recommendation

security-recommendation-email-title = E-posta adresinizi koruyun
# $num_breaches is the number of breaches where the email address was found.
security-recommendation-email-summary =
    { $num_breaches ->
        [one] E-posta adresiniz { $num_breaches } veri ihlalinde ele geçirildi:
       *[other] E-posta adresiniz { $num_breaches } veri ihlalinde ele geçirildi:
    }
security-recommendation-email-description = Maalesef bunu düzeltemezsiniz. Ancak kendinizi korumak için atabileceğiniz adımlar var.
security-recommendation-email-step-two = <link_to_info>Kimlik avı dolandırıcılığına</link_to_info> dikkat edin
security-recommendation-email-step-three = Şüpheli e-postaları spam olarak işaretleyip göndereni engelleyin
security-recommendation-email-step-four = E-postalarınızı korumak için <link_to_info>{ -brand-relay } e-posta maskelerini</link_to_info> kullanabilirsiniz

# IP security recommendation

security-recommendation-ip-title = Daha fazla gizlilik için VPN kullanabilirsiniz
# $num_breaches is the number of breaches where the IP address was found.
security-recommendation-ip-summary =
    { $num_breaches ->
        [one] IP adresiniz { $num_breaches } veri ihlalinde ele geçirildi:
       *[other] IP adresiniz { $num_breaches } veri ihlalinde ele geçirildi:
    }
security-recommendation-ip-description = IP adresiniz konumunuzu ve internet servis sağlayıcınızı ifşa edebilir. Hacker’lar konumunuzu bulmak veya cihazlarınıza bağlanmak için bu bilgileri kullanabilir.
security-recommendation-ip-step-one = Gerçek IP adresinizi gizlemek ve internette daha az iz bırakmak için VPN (örn. <link_to_info>{ -brand-mozilla-vpn }</link_to_info>) kullanabilirsiniz.

# Leaked Passwords

# Variables
# $breach_name is the name of the breach where the leaked password was found.
leaked-passwords-title = { $breach_name } parolanız ele geçirildi
# Variables
# $breach_date is the date when the breach occurred.
leaked-passwords-summary = { $breach_date } tarihinde meydana gelen bir veri ihlalinde yer alıyor.
leaked-passwords-steps-title = İşte yapmanız gerekenler
leaked-passwords-steps-subtitle = Bunun için hesabınıza erişim gerekiyor, o yüzden kendiniz düzeltmeniz gerekecek.
# Variables
# $breach_name is the name of the breach where the leaked password was found.
# $emails_affected are the emails associated with the breach.
leaked-passwords-step-one = <link_to_breach_site>{ $breach_name }</link_to_breach_site> sitesindeki/uygulamasındaki <b>{ $emails_affected }</b> hesabınızın parolasını değiştirin.
leaked-passwords-step-two = Kullandığınız her yerde değiştirin.
leaked-passwords-mark-as-fixed = Düzeltildi olarak işaretle
leaked-passwords-skip = Şimdilik geç
# Variables
# $estimated_time is the amount of time it would take for a user to manually resolve a leaked password breach. It will always be a number greater than 1.
# "Est." is shortform for "Estimated".
# "mins" is shortform for "minutes".
leaked-passwords-estimated-time =
    { $estimated_time ->
        [one] Tahmini tamamlanma süresi: site başına { $estimated_time } dk.
       *[other] Tahmini tamamlanma süresi: site başına { $estimated_time } dk.
    }

# Leaked Security Questions

leaked-security-questions-title = Güvenlik sorularınız ele geçirilmiş
# Variables
# $breach_name is the name of the breach where the leaked security questions were found.
# $breach_date is the date when the breach occurred.
# An example of this string is Twitter on 13/09/18.
leaked-security-questions-summary = { $breach_date } tarihinde meydana gelen { $breach_name } veri ihlalinde yer alıyorlar.
leaked-security-questions-description = Dolandırıcılar bunları hesaplarınıza ve aynı güvenlik sorularını kullandığınız diğer sitelere erişmek için kullanabilir. Hesaplarınızı korumak için güvenlik sorularını hemen şimdi güncelleyin.
leaked-security-questions-steps-title = İşte yapmanız gerekenler
leaked-security-questions-steps-subtitle = Bunun için hesabınıza erişim gerekiyor, o yüzden kendiniz düzeltmeniz gerekecek.
# Variables
# $breach_name is the name of the breach where the security questions were found.
# $email_affected is the email associated with the breach.
leaked-security-questions-step-one = <link_to_breach_site>{ $breach_name }</link_to_breach_site> sitesindeki/uygulamasındaki <b>{ $email_affected }</b> hesabınızın güvenlik sorularını güncelleyin.
