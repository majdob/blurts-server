# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

fix-flow-nav-high-risk-data-breaches = Suuren riskin tietomurrot
fix-flow-nav-leaked-passwords = Vuotaneet salasanat
fix-flow-nav-security-recommendations = Turvallisuussuositukset
guided-resolution-flow-exit = Palaa hallintapaneeliin
guided-resolution-flow-back-arrow = Siirry edelliseen vaiheeseen
guided-resolution-flow-next-arrow = Siirry seuraavaan vaiheeseen
guided-resolution-flow-step-navigation-label = Ohjatut vaiheet

# Celebration screens


## Shared CTA labels

fix-flow-celebration-next-label = Jatketaan
fix-flow-celebration-next-recommendations-label = Näytä suositukset
fix-flow-celebration-next-dashboard-label = Siirry hallintapaneeliin

## High-risk flow

fix-flow-celebration-high-risk-title = Olet korjannut suuren riskin altistumiset!
fix-flow-celebration-high-risk-description-in-progress = Tämän työn tekeminen voi tuntua suurelta, mutta se on tärkeää pitääksesi itsesi turvassa. Jatka samaan malliin.
fix-flow-celebration-high-risk-description-done = Tämän työn tekeminen voi tuntua suurelta, mutta se on tärkeää pitääksesi itsesi turvassa.
fix-flow-celebration-high-risk-description-next-passwords = Korjataan nyt altistuneet salasanasi.
fix-flow-celebration-high-risk-description-next-security-questions = Korjataan nyt altistuneet turvallisuuskysymyksesi.
fix-flow-celebration-high-risk-description-next-security-recommendations = Seuraavaksi annamme sinulle räätälöityjä tietoturvasuosituksia sen perusteella, mitä tietojasi on vuodettu.
fix-flow-celebration-high-risk-description-next-dashboard = Olet saavuttanut vaiheesi loppuun. Voit tarkastella mitä tahansa toimintokohteita ja seurata edistymistäsi hallintapaneelissa.

## Leaked passwords and security questions flow

fix-flow-celebration-leaked-passwords-title = Salasanasi ovat nyt suojattu!
fix-flow-celebration-security-questions-title = Turvakysymyksesi ovat suojattuja!
fix-flow-celebration-leaked-passwords-description-next-security-questions = Katselmoidaan ja päivitetään nyt altistuneet turvallisuuskysymyksesi.
fix-flow-celebration-leaked-passwords-description-next-security-recommendations = Seuraavaksi annamme sinulle räätälöityjä tietoturvasuosituksia sen perusteella, mitä tietojasi on vuodettu.

## Security recommendations flow


# High Risk Data Breaches

# Variables
# $num_breaches is the number of breaches where the high risk data was found.
high-risk-breach-summary =
    { $num_breaches ->
        [one] Se esiintyi { $num_breaches } tietovuodon yhteydessä:
       *[other] Se esiintyi { $num_breaches } tietovuodon yhteydessä:
    }
high-risk-breach-mark-as-fixed = Merkitse korjatuksi
high-risk-breach-skip = Ohita nyt
# Variables:
# $estimated_time is the estimated time it would take for a user to complete breach resolution steps. It not be singular, and the + is meant as "or more".
# An example of this string is Your estimated time: 15+ minutes.
high-risk-breach-estimated-time =
    { $estimated_time ->
        [one] Arvioitu aika: { $estimated_time }+ minuutti
       *[other] Arvioitu aika: { $estimated_time }+ minuuttia
    }

# Credit Card Breaches

high-risk-breach-credit-card-title = Luottokorttisi numero paljastui
high-risk-breach-credit-card-step-one = Jos sinulla on edelleen tämä kortti, ota yhteyttä sen myöntäjään ja ilmoita se varastetuksi.
high-risk-breach-credit-card-step-two = Pyydä uusi kortti uudella numerolla.
high-risk-breach-credit-card-step-three = Tarkista tilisi luvattomien maksujen varalta.

# Bank Account Breaches

high-risk-breach-bank-account-title = Pankkitilisi paljastui
high-risk-breach-bank-account-step-one = Ilmoita pankillesi välittömästi, että tilinumerosi on vaarantunut.
high-risk-breach-bank-account-step-two = Vaihda tilinumerosi.
high-risk-breach-bank-account-step-three = Tarkista tilisi luvattomien maksujen varalta.

# Social Security Number Breaches

high-risk-breach-social-security-title = Henkilötunnuksesi paljastui

# Social Security Number Modal

ssn-modal-ok = OK

# PIN Breaches

high-risk-breach-pin-title = PIN-koodisi paljastui
high-risk-breach-pin-step-one = Ilmoita pankillesi välittömästi, että PIN-koodisi on vaarantunut.
high-risk-breach-pin-step-two = Vaihda PIN-koodi kaikkialla, missä olet mahdollisesti käyttänyt samaa PIN-koodia.
high-risk-breach-pin-step-three = Tarkista tilisi luvattomien maksujen varalta.

# No high risk breaches found

high-risk-breach-none-title = Hyviä uutisia, suuren riskin tietovuotoja ei löytynyt
high-risk-breach-none-sub-description-part-one = Suuren riskin tietomurtoihin sisältyy:
high-risk-breach-none-sub-description-ssn = Henkilötunnus
high-risk-breach-none-sub-description-bank-account = Pankkitilin tiedot
high-risk-breach-none-sub-description-cc-number = Luottokorttien numerot
high-risk-breach-none-sub-description-pin = PIN-koodit
high-risk-breach-none-continue = Jatka

# Security recommendations

security-recommendation-steps-label = Turvallisuussuositukset
security-recommendation-steps-title = Tässä meidän neuvomme:
security-recommendation-steps-cta-label = Selvä!

# Phone security recommendation

security-recommendation-phone-title = Suojaa puhelinnumerosi

# Email security recommendation

security-recommendation-email-title = Suojaa sähköpostiosoitteesi
security-recommendation-email-step-two = Ole tietoinen <link_to_info>kalasteluhuijauksista</link_to_info>
security-recommendation-email-step-three = Merkitse epäilyttävät sähköpostit roskapostiksi ja estä lähettäjä
security-recommendation-email-step-four = Käytä <link_to_info>{ -brand-relay }-sähköpostimaskeja</link_to_info> suojataksesi sähköpostiosoitettasi jatkossa

# IP security recommendation

security-recommendation-ip-title = Käytä VPN:ää yksityisyyden lisäämiseksi
# $num_breaches is the number of breaches where the IP address was found.
security-recommendation-ip-summary =
    { $num_breaches ->
        [one] IP-osoitteesi paljastui { $num_breaches } tietovuodon yhteydessä:
       *[other] IP-osoitteesi paljastui { $num_breaches } tietovuodon yhteydessä:
    }

# Leaked Passwords

# Variables
# $breach_name is the name of the breach where the leaked password was found.
leaked-passwords-title = Salasanasi kohteessa { $breach_name } vuodettiin
# Variables
# $breach_date is the date when the breach occurred.
leaked-passwords-summary = Se esiintyi tietovuodossa { $breach_date }.
leaked-passwords-steps-title = Tämän kaiken voit tehdä
leaked-passwords-steps-subtitle = Tämä vaatii pääsyn tiliisi, joten sinun on korjattava se manuaalisesti.
leaked-passwords-step-two = Vaihda se missä tahansa muualla, missä olet käyttänyt sitä.
leaked-passwords-mark-as-fixed = Merkitse korjatuksi
leaked-passwords-skip = Ohita nyt

# Leaked Security Questions

leaked-security-questions-title = Turvakysymyksesi paljastettiin
leaked-security-questions-steps-title = Tämän kaiken voit tehdä
leaked-security-questions-steps-subtitle = Tämä vaatii pääsyn tiliisi, joten sinun on korjattava se manuaalisesti.
