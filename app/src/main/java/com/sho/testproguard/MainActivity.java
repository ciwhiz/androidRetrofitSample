package com.sho.testproguard;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sho.testproguard.model.Post;
import com.sho.testproguard.model.Post;
import com.sho.testproguard.repository.ApiService;
import com.sho.testproguard.repository.TestDataListRepository;
import com.sho.testproguard.repository.WhiteListManager;

import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    private TextView resultTextView;
    private Button goSecondBtn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        resultTextView = findViewById(R.id.result_text);
        goSecondBtn = findViewById(R.id.button_go_second_activity);

        // http logger
        HttpLoggingInterceptor logInterceptor = new HttpLoggingInterceptor();
        logInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        OkHttpClient.Builder builder = new OkHttpClient.Builder();
        builder.interceptors().add(logInterceptor);
        OkHttpClient okHttpClientForLogging = builder.build();

        // Retrofit 초기화
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://jsonplaceholder.typicode.com")
                .addConverterFactory(GsonConverterFactory.create())
                .client(okHttpClientForLogging)
                .build();

        ApiService apiService = retrofit.create(ApiService.class);

        new TestDataListRepository().getData();
        new WhiteListManager().manageWhiteList();

        // API 호출
        Log.v("MainActivity", "API 호출 apiService.getPost()");
        Call<Post> call = apiService.getPost();
        Log.v("MainActivity", "API 호출 후 call.enqueue(new Callback<Post>(");
        call.enqueue(new Callback<Post>() {
            @Override
            public void onResponse(Call<Post> call, Response<Post> response) {
                Log.v("MainActivity", "API 호출 후 onResponse 내부 :: " + response.body());
                Log.v("MainActivity", "API 호출 후 onResponse 내부 :: " + response.raw());
                if (response.isSuccessful() && response.body() != null) {
                    Post post = response.body();
                    Log.v("MainActivity", "API 호출 후 onResponse 내부 response isSuccess, post = response.body() 이후");
                    resultTextView.setText("Title: " + post.getTitle() + "\nBody: " + post.getBody());
                }
            }

            @Override
            public void onFailure(Call<Post> call, Throwable t) {
                resultTextView.setText("Error: " + t.getMessage());
            }
        });

        goSecondBtn.setOnClickListener(v -> {
            Intent intent = new Intent(MainActivity.this, SecondActivity.class);
            startActivity(intent);
        });
    }
}