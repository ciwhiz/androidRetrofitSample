package com.sho.testproguard.repository

import androidx.annotation.Keep

// TestDataListRepository의 기본 구조
open class TestDataListRepository {
    // 필요한 데이터 및 메서드를 정의
    open fun getData(): WhiteListParsedData {
        // 테스트 데이터를 반환하는 함수
        return WhiteListParsedData(
            version = "1.0",
            whiteList = listOf(
                ActionWhiteListSpecData(
                    description = "Sample Description",
                    protocol = "HTTPS",
                    host = "example.com",
                    domain = "example.com",
                    topDomain = listOf("com"),
                    port = "443",
                    path = listOf("/api/v1")
                )
            )
        )
    }
}

// WhiteListManager 클래스 정의
class WhiteListManager {
    // 필요한 데이터 및 메서드를 정의
    fun manageWhiteList() {
        // 화이트리스트를 관리하는 메서드
        TestDataListRepository().getData()
    }
}

// WhiteListParsedData 및 ActionWhiteListSpecData 데이터 클래스 정의
data class WhiteListParsedData(
    var version: String = "unknown version",
    var whiteList: List<ActionWhiteListSpecData> = mutableListOf()
)

data class ActionWhiteListSpecData(
    var description: String = "",
    var protocol: String = "",
    var host: String = "",
    var domain: String = "",
    var topDomain: List<String> = mutableListOf(),
    var port: String = "",
    var path: List<String> = mutableListOf()
)
