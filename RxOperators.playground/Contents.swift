//: Playground - noun: a place where people can play

import RxSwift


 // Implementation for map operator
executeProcedure(for: "map") { 
    Observable.of(10, 20, 30)
        .map{ $0 * $0 }
        .subscribe(onNext:{
            print($0)
        })
        .dispose()
}
 
// Implementation for flatMap and flatMapLatest operator
executeProcedure(for: "flatMap and flatMapLatest") {
    
    struct GamePlayer {
        let playerScore: Variable<Int>
    }
    let disposeBag = DisposeBag()
    
    let alex = GamePlayer(playerScore: Variable(70))
    let gemma = GamePlayer(playerScore: Variable(85))
    
    var currentPlayer = Variable(alex)
    
    currentPlayer.asObservable()
        .flatMapLatest{ $0.playerScore.asObservable() }
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
    
    currentPlayer.value.playerScore.value = 90
    alex.playerScore.value = 95
    
    currentPlayer.value = gemma
    
    alex.playerScore.value = 96
}

// Implementation for scan and buffer operator
executeProcedure(for: "scan and buffer") {
    
    let disposeBag = DisposeBag()
    
    let gameScore = PublishSubject<Int>()
    
    gameScore
        .buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance)
        .map {
            print($0, "--> ", terminator: "")
            return $0.reduce(0, +)
        }
        .scan(501, accumulator: -)
        .map { max($0, 0) }
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
    
    gameScore.onNext(60)
    gameScore.onNext(13)
    gameScore.onNext(50)
}


// Implementation for filter operator
executeProcedure(for: "filter") { 
    
    let disposeBag = DisposeBag()
    
    let integers = Observable.generate(initialState: 1,
                                       condition: { $0 < 101 },
                                       iterate: { $0 + 1 }
    )
    
    integers
        .filter { $0.isPrime() }
        .toArray()
        .subscribe({
            print( $0 )
        })
    .disposed(by: disposeBag)
}

// Implementation for distinctUntilChanged operator
executeProcedure(for: "distinctUntilChanged") { 
    
    let disposeBag = DisposeBag()
    
    let stringToSearch = Variable("")
    stringToSearch.asObservable()
        .map({
            $0.lowercased()
        })
    .distinctUntilChanged()
        .subscribe({
            print($0)
        })
    .disposed(by: disposeBag)
    
    stringToSearch.value = "TINTIN"
    stringToSearch.value = "tintin"
    stringToSearch.value = "noDDy"
    stringToSearch.value = "TINTIN"
}


// Implementation for takeWhile operator
executeProcedure(for: "takeWhile") { 
    let disposeBag = DisposeBag()
    
    let integers = Observable.of(10, 20, 30, 40, 30, 20, 10)
    integers
        .takeWhile({
            $0 < 40
        })
        .subscribe(onNext: {
            print( $0 )
        })
        .disposed(by: disposeBag)
}

































