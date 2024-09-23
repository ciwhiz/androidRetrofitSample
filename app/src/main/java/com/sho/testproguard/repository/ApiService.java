package com.sho.testproguard.repository;

import com.sho.testproguard.model.Post;

import retrofit2.Call;
import retrofit2.http.GET;

public interface ApiService {
    @GET("/posts/1")  // 샘플 JSONPlaceholder API 요청
    Call<Post> getPost();
}
