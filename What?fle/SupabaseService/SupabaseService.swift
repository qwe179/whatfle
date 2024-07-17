//
//  SupabaseService.swift
//  What?fle
//
//  Created by 23 09 on 7/9/24.
//

import Foundation
import RxSwift
import Supabase

protocol SupabaseServiceDelegate: AnyObject {
    func signInWithIdToken(provider: OpenIDConnectCredentials.Provider, idToken: String) -> Single<Session>
}

final class SupabaseService: SupabaseServiceDelegate {
    var client: SupabaseClient = SupabaseClient(supabaseURL: URL(string: "https://zzfghrhtmemsirwljiei.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp6Zmdocmh0bWVtc2lyd2xqaWVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI0MDM0OTksImV4cCI6MjAyNzk3OTQ5OX0.dVGJFqec15FBUhJFbVfw9utlpGs71S2NZoeTvvEVRMw")

    deinit {
        print("\(self) is being deinit")
    }

    func signInWithIdToken(provider: OpenIDConnectCredentials.Provider, idToken: String) -> Single<Session> {
        return Single.create { single in
            Task {
                do {
                    let response = try await self.client.auth.signInWithIdToken(
                        credentials: .init(
                            provider: provider,
                            idToken: idToken
                        )
                    )
                    single(.success(response))
                } catch {
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
