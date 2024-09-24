package com.sho.testproguard

import android.content.Context
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.GsonBuilder
import com.sho.testproguard.repository.ApiService2
import com.sho.testproguard.repository.WhiteListParsedData
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import okhttp3.Dispatcher
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.io.IOException

class SecondActivity : AppCompatActivity() {

    private lateinit var resultTextView: TextView
    private lateinit var resultTextView2: TextView
    private lateinit var resultTextView3: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_second)

        resultTextView = findViewById(R.id.result_text_second)
        resultTextView2 = findViewById(R.id.result_text_second_gson_src)
        resultTextView3 = findViewById(R.id.result_text_second_gson)

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

        CoroutineScope(Dispatchers.IO).launch {
            gsonParsingJsonString()
        }
    }

    private fun gsonParsingJsonString() {
        val gson = GsonBuilder().create()

        try {
            val readData = parseJsonFileToString(this, "person_data.json")
            Log.v("sho9", "agp 7 File Read OK! readData is $readData")
            val person: Person2 = gson.fromJson(readData, Person2::class.java)
            Log.v("sho9", person.toString())
            val id = person.id ?: "no id"
            val name = person.name ?: "no name"
            val age = person.age ?: "no age"
            resultTextView3.text = "id: $id\n" + "name: $name\n" + "age: $age\n"
        } catch (e: Exception) {
            Log.v("sho9", " ###  error on Gson parsing.." + e.printStackTrace())
            e.printStackTrace()
        }
    }

    fun parseJsonFileToString(context: Context, jsonFile: String): String {
        val assetManager = context.assets
        var jsonStr = ""
        if (TextUtils.isEmpty(jsonFile)) {
            return jsonStr!!
        }
        try {
            val `is` = assetManager.open(jsonFile)
            val fileSize = `is`.available()

            val buffer = ByteArray(fileSize)
            `is`.read(buffer)
            `is`.close()

            jsonStr = String(buffer, charset("UTF-8"))
        } catch (ex: IOException) {
            ex.printStackTrace()
        }
        return jsonStr!!
    }
}

data class Person2(
    var id: Int,
    var name: String,
    var age: Int
)