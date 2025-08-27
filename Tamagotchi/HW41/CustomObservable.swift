//
//  CustomObservable.swift
//  Tamagotchi
//
//  Created by hyunMac on 8/25/25.
//

import Foundation
import Alamofire
import RxSwift

struct Lotto: Codable {
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

enum SampleError: Error {
    case sampleError
    case networkError
}

final class CustomObservable {
    static func getLotto(query: String) -> Observable<Result<Lotto,AFError>> {
        return Observable<Result<Lotto,AFError>>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(query)"
            print(url)
            AF.request(url).responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    observer.onNext(.success(value))
                    observer.onCompleted()
                case .failure(let error):
                    observer.onNext(.failure(error))
                    observer.onCompleted()
//                    observer.onError(SampleError.sampleError)
                    //onError쓰면 메모리 정리되면서 부모까지 사용안됨.
                    //onNext로 Result타입 던져서 위에서 처리
                }
            }
            return Disposables.create()
        }
    }

    static func getMovie(query: String) -> Observable<MovieRequest> {
        return Observable<MovieRequest>.create { observer in
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=\(query)&key=\(SecretKey.movieKey)"
            print(url)
            AF.request(url).responseDecodable(of: MovieRequest.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(_):
                        observer.onError(SampleError.sampleError)
                    }
                }
            	return Disposables.create()
        }
    }

    static func getMovieWithSingle(query: String) -> Single<Result<MovieRequest,SampleError>> {
        return Single.create { observer in
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=\(query)&key=\(SecretKey.movieKey)"
            AF.request(url).responseDecodable(of: MovieRequest.self) { response in
                    switch response.result {
                    case .success(let success):
                        observer(.success(.success(success)))
                    case .failure(let failure):
                        observer(.success(.failure(SampleError.sampleError)))
                    }
                }
                return Disposables.create()
        }
    }
}
