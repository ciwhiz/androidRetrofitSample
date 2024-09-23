package com.sho.testproguard.repository

import retrofit2.Call
import retrofit2.http.GET

interface ApiService2 {
    @GET("/posts/2")  // 임시 엔드포인트
    fun getWhiteListData(): Call<WhiteListParsedData>
}
