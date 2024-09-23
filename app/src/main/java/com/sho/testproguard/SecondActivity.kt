package com.sho.testproguard

import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.sho.testproguard.repository.ApiService2
import com.sho.testproguard.repository.WhiteListParsedData
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class SecondActivity : AppCompatActivity() {

    private lateinit var resultTextView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        resultTextView = findViewById(R.id.result_text_second)

        // Retrofit 초기화
        val retrofit = Retrofit.Builder()
            .baseUrl("https://jsonplaceholder.typicode.com")  // 임시 API URL
            .addConverterFactory(GsonConverterFactory.create())
            .build()

        val apiService = retrofit.create(ApiService2::class.java)

        // API 호출
        val call = apiService.getWhiteListData()
        call.enqueue(object : Callback<WhiteListParsedData> {
            override fun onResponse(
                call: Call<WhiteListParsedData>,
                response: Response<WhiteListParsedData>
            ) {
                if (response.isSuccessful && response.body() != null) {
                    val whiteListData = response.body()
                    whiteListData?.let {
                        Log.d(SecondActivity::class.simpleName, "it : " + it)
                        val version = it.version ?: "unknown version"
                        val whiteList = it.whiteList?.joinToString { spec -> spec.description } ?: "No whiltelist data"
                        resultTextView.text = "Version: $version\n" +
                                "WhiteList: $whiteList"
                    }
                }
            }

            override fun onFailure(call: Call<WhiteListParsedData>, t: Throwable) {
                resultTextView.text = "Error: ${t.message}"
            }
        })
    }
}
