//
//  AppConfigs.swift
//  What?fle
//
//  Created by 이정환 on 2/28/24.
//

import Foundation

enum AppConfigs {
    private static var secrets: NSDictionary? {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path) else {
            print("⚠️ 'Secrets.plist' not found or is not accessible.")
            return nil
        }
        return dictionary
    }
}

extension AppConfigs {
    enum UserInfo {
        static var accountID: Int {
            1
        }
    }

    enum API {
        enum Key {
            static var accessToken: String {
                "Bearer eyJhbGciOiJIUzI1NiIsImtpZCI6IjdvUTl1RGRlN3E5SXNvT2IiLCJ0eXAiOiJKV1QifQ.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzE1OTQ3NjA2LCJpYXQiOjE3MTUzNDI4MDYsImlzcyI6Imh0dHBzOi8venpmZ2hyaHRtZW1zaXJ3bGppZWkuc3VwYWJhc2UuY28vYXV0aC92MSIsInN1YiI6IjhlOWFkZGRmLWI1YTktNDgyNS1iOGM3LWZjMmNhYTcwMmJiOCIsImVtYWlsIjoicmtkd2pzcm4yQGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZ29vZ2xlIiwicHJvdmlkZXJzIjpbImdvb2dsZSJdfSwidXNlcl9tZXRhZGF0YSI6eyJhdmF0YXJfdXJsIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jS2hMcHdHaFZISzZkX28zSVBZTUh6ODQ2cjF5X3dzajhVTzQ3T0dSck0yN0s4OU9nPXM5Ni1jIiwiZW1haWwiOiJya2R3anNybjJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZ1bGxfbmFtZSI6ImggZSIsImlzcyI6Imh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbSIsIm5hbWUiOiJoIGUiLCJwaG9uZV92ZXJpZmllZCI6ZmFsc2UsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLaExwd0doVkhLNmRfbzNJUFlNSHo4NDZyMXlfd3NqOFVPNDdPR1JyTTI3Szg5T2c9czk2LWMiLCJwcm92aWRlcl9pZCI6IjExNDY1NTg2NTE3NzkwMjA0ODM2OCIsInN1YiI6IjExNDY1NTg2NTE3NzkwMjA0ODM2OCJ9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6Im9hdXRoIiwidGltZXN0YW1wIjoxNzE1MzQyODA2fV0sInNlc3Npb25faWQiOiI0NWZiZjJmMS01NzlhLTQyYWUtOWNlMS03NmM1OTMyZjk4NzYiLCJpc19hbm9ueW1vdXMiOmZhbHNlfQ.RRWnlfqF_D8tnI5RJUxHQNeQZK3JdTD2b6gfkAtTTzQ"
            }

            enum Naver {
                static var clientID: String {
                    (secrets?.value(forKey: "Naver-Client-ID") as? String) ?? ""
                }

                static var clientSecret: String {
                    (secrets?.value(forKey: "Naver-Client-Secret") as? String) ?? ""
                }
            }

            enum Kakao {
                static var kakaoRESTAPIKey: String {
                    (secrets?.value(forKey: "Kakao_REST_API_KEY") as? String) ?? ""
                }
            }
        }

        enum BaseURL {
            static var dev: String {
                "https://zzfghrhtmemsirwljiei.supabase.co/functions/v1/whatfle"
            }

            enum Naver {
                static var search: String {
                    (secrets?.value(forKey: "NaverSearchURL") as? String) ?? ""
                }
            }

            enum Kakao {
                static var search: String {
                    "https://dapi.kakao.com/v2/local/"
                }
            }
        }
    }
}
