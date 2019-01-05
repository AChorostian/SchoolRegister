# GoFive

| Autorzy  	| Język programowania  	| Travis Status  	|
|:-----:	|:-----:	|:-----:	|
| [![inql](https://avatars0.githubusercontent.com/u/23345084?s=40&v=4)](https://github.com/inql) [![dz3lo](https://avatars0.githubusercontent.com/u/25078869?s=40&v=4)](https://github.com/dz3lo) [![matmalecki](https://avatars2.githubusercontent.com/u/32633611?s=40&v=4)](https://github.com/Matmalecki)   	| [![ruby](https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/36px-Ruby_logo.svg.png)](https://www.ruby-lang.org/en/) 	| [![Build Status](https://travis-ci.com/TestowanieRubyUG20182019/projektsemestralny-gofive.svg?token=3kJQswsH2SS3Xnj1fhuG&branch=master)](https://travis-ci.com/TestowanieRubyUG20182019/projektsemestralny-gofive)  	|

## How to run:

step by step Instructions:

1. install Ruby.
2. install bundler.
3. install rspec, simplecov and sqlite.
4. install rubymine.
5. clone and open main project directory from rubymine.
6. `bundle install`
7. you should receive message that you need to install more gems. click install.
8. complete!

#### Run application
`ruby bin/run.rb`
#### Run unit tests
`rake`


# Excercise (in polish)

Napisz w języku Ruby program, który będzie prostą implementacją e-dziennika w jakieś placówce edukacyjnej.
Ma ona spełniać następujące wymagania:
   * Dodanie, edycja i usunięcie ucznia (1.5 pkt)
   * Dopisanie, edycja i usuwanie przedmiotów do ucznia (1.5 pkt)
   * Dopisywanie, edycja ocen przedmiotu do ucznia (1.5 pkt)
   * Statystyki (średnia z przedmiotu, średnia z przedmiotów) danego ucznia (1.5 pkt)
   * Dodanie, edycja uwag do ucznia (1 pkt)
   * Import/Eksport danych do pliku .csv (3 pkt)
   * Możliwość zapisu danych do bazy danych (przy pomocy SQLite). (5 pkt)
   
Przy użyciu narzędzi znanych na zajęciach przetestuj ten kod.
Do oceny będą brane pod uwagę:
   * Przechodzenie wszystkich testów: 1 pkt
   * Uwzględnienie powyższych wymagań: 15 pkt
   * Pokrycie kodu: 2 pkt (w zależności od procentu)
   * Testy pozytywne: 10 pkt
   * Testy negatywne: 10 pkt
   * Sytuacje wyjątkowe: 10 pkt
   * Stylistyka napisanych testów: 2 pkt
   
Ponadto do oceny będą brane pod uwagę (brak rzeczy oznacza utratę punktów): 
   * Zbyt słaba historia w repozytorium (do - 3 pkt)
   * Struktura projektu (do -2 pkt)
   * Mała ilość wykorzystania asercji (-3 pkt)
   * Brak testu w minitest oraz w RSpec (-2 pkt)
   
Ponadto jako dodatkowo będzie brane użycie narzędzi , które nie były pokazywane na zajęciach.
