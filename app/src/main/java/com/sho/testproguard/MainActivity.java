package com.sho.testproguard;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.sho.testproguard.model.Post;
import com.sho.testproguard.repository.ApiService;
import com.sho.testproguard.repository.TestDataListRepository;
import com.sho.testproguard.repository.WhiteListManager;

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

        // Retrofit 초기화
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("https://jsonplaceholder.typicode.com")
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        ApiService apiService = retrofit.create(ApiService.class);

        new TestDataListRepository().getData();
        new WhiteListManager().manageWhiteList();

        // API 호출
        Call<Post> call = apiService.getPost();
        call.enqueue(new Callback<Post>() {
            @Override
            public void onResponse(Call<Post> call, Response<Post> response) {
                if (response.isSuccessful() && response.body() != null) {
                    Post post = response.body();
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